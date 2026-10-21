import 'package:flutter/material.dart';
import 'package:n3ds_taller/models/destino.dart';
import 'package:n3ds_taller/services/destino_service.dart';

class MisDestinosScreen extends StatefulWidget {
  const MisDestinosScreen({super.key});

  @override
  State<MisDestinosScreen> createState() => _MisDestinosScreenState();
}

class _MisDestinosScreenState extends State<MisDestinosScreen> {
  final _service = DestinoService();
  late Future<List<Destino>> _destinos;

  bool _eliminando = false;

  @override
  void initState() {
    super.initState();
    _destinos = _service.buscarPorIdUsuario();
  }

  Future<void> eliminar(String destinoId) async {
    setState(() => _eliminando = true);
    final bool response = await _service.eliminar(destinoId);

    if (response) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Se elimino correctamente")));
      }

      _destinos = _service.buscarPorIdUsuario();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error al eliminar destino")));
      }
    }

    setState(() => _eliminando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Destinos")),
      body: FutureBuilder(
        future: _destinos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error al cargar los datos"));
          }

          final destinos = snapshot.data ?? [];

          if (destinos.isEmpty) {
            return Center(child: Text("No hay destinos disponibles"));
          }

          return ListView.separated(
            itemCount: destinos.length,
            itemBuilder: (context, index) {
              final item = destinos[index];

              return ListTile(
                leading: Image(
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  image: NetworkImage(item.imagen),
                ),
                title: Text(item.destino),
                subtitle: Text('${item.pais} - ${item.ciudad}'),
                trailing: IconButton(
                  onPressed: _eliminando
                      ? null
                      : () => eliminar(item.id.toString()),
                  icon: Icon(Icons.delete),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 12),
          );
        },
      ),
    );
  }
}
