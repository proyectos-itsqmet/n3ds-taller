import 'package:flutter/material.dart';
import 'package:n3ds_taller/models/destino.dart';
import 'package:n3ds_taller/screens/destino_detalle_screen.dart';
import 'package:n3ds_taller/services/destino_service.dart';

class DestinosScreens extends StatefulWidget {
  const DestinosScreens({super.key});

  @override
  State<DestinosScreens> createState() => _DestinosScreensState();
}

class _DestinosScreensState extends State<DestinosScreens> {
  final _service = DestinoService();
  late Future<List<Destino>> _destinos;

  @override
  void initState() {
    super.initState();
    _destinos = _service.listar();
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
                trailing: IconButton.outlined(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DestinoDetalleScreen(destino: item),
                    ),
                  ),
                  icon: Icon(Icons.chevron_right),
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
