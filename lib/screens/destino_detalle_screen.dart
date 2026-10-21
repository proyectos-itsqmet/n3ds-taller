import 'package:flutter/material.dart';
import 'package:n3ds_taller/models/destino.dart';
import 'package:n3ds_taller/models/weather.dart';
import 'package:n3ds_taller/services/clima_service.dart';
import 'package:n3ds_taller/widgets/item_list.dart';

class DestinoDetalleScreen extends StatefulWidget {
  final Destino destino;

  const DestinoDetalleScreen({super.key, required this.destino});

  @override
  State<DestinoDetalleScreen> createState() => _DestinoDetalleScreenState();
}

class _DestinoDetalleScreenState extends State<DestinoDetalleScreen> {
  final _service = ClimaService();
  late Future<Weather>? _climaDestino;

  @override
  void initState() {
    super.initState();
    _climaDestino = _service.buscarWeather(
      long: widget.destino.long,
      lat: widget.destino.lat,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FutureBuilder(
          future: _climaDestino,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Error al cargar el destino"),
                    SizedBox(height: 12),
                    FilledButton(
                      onPressed: () => _climaDestino = _service.buscarWeather(
                        long: widget.destino.long,
                        lat: widget.destino.lat,
                      ),
                      child: Text("Recargar"),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.data == null) {
              return Center(child: Text("No se encontro el destino"));
            }

            return ListView(
              children: [
                Text(
                  widget.destino.destino,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 12),
                Image.network(height: 200, widget.destino.imagen),
                SizedBox(height: 24),
                ItemList(title: "Pais: ", text: widget.destino.pais),
                Divider(),
                ItemList(title: "Ciudad: ", text: widget.destino.ciudad),
                Divider(),
                ItemList(
                  title: "Precio: ",
                  text: widget.destino.precio.toString(),
                ),
                SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  child: FilledButton(
                    onPressed: () {},
                    child: Text("Guardar destino"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
