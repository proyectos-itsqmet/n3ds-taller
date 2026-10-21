import 'package:flutter/material.dart';
import 'package:n3ds_taller/models/destino.dart';
import 'package:n3ds_taller/models/weather.dart';
import 'package:n3ds_taller/services/clima_service.dart';
import 'package:n3ds_taller/services/destino_service.dart';
import 'package:n3ds_taller/widgets/item_list.dart';

class DestinoDetalleScreen extends StatefulWidget {
  final Destino destino;

  const DestinoDetalleScreen({super.key, required this.destino});

  @override
  State<DestinoDetalleScreen> createState() => _DestinoDetalleScreenState();
}

class _DestinoDetalleScreenState extends State<DestinoDetalleScreen> {
  final _serviceClima = ClimaService();
  final _serviceDestino = DestinoService();
  late Future<Weather>? _climaDestino;

  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    _climaDestino = _serviceClima.buscarWeather(
      long: widget.destino.long,
      lat: widget.destino.lat,
    );
  }

  Future<void> guardar() async {
    setState(() => _guardando = true);
    final bool response = await _serviceDestino.guardar(
      widget.destino.id.toString(),
    );

    if (response) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Destino guardado")));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error al grabar destino")));
      }
    }

    setState(() => _guardando = false);
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
                      onPressed: () =>
                          _climaDestino = _serviceClima.buscarWeather(
                            long: widget.destino.long,
                            lat: widget.destino.lat,
                          ),
                      child: Text("Recargar"),
                    ),
                  ],
                ),
              );
            }

            final Weather? weather = snapshot.data;

            if (weather == null) {
              return Center(child: Text("No se encontro el destino"));
            }

            return ListView(
              children: [
                Image.network(height: 200, widget.destino.imagen),
                SizedBox(height: 24),
                Text(
                  widget.destino.destino,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                ItemList(
                  title: "Pais: ",
                  text: "${widget.destino.pais} - ${widget.destino.ciudad}",
                ),
                Divider(),
                ItemList(
                  title: "Precio: ",
                  text: widget.destino.precio.toString(),
                ),
                Divider(),
                ItemList(
                  title: "Temperatura",
                  text: weather.main!.temp.toString(),
                ),
                Divider(),
                ItemList(
                  title: "Sensación térmica",
                  text: weather.main!.feelsLike.toString(),
                ),
                Divider(),
                ItemList(
                  title: "Condición",
                  text:
                      "${weather.weather!.first.main!} - ${weather.weather!.first.description!}",
                ),
                SizedBox(height: 24),

                SizedBox(
                  height: 50,
                  child: FilledButton(
                    onPressed: _guardando ? null : () => guardar(),
                    child: Text(
                      _guardando ? "Guardando..." : "Guardar destino",
                    ),
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
