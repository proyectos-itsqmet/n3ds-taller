class Destino {
  final int id;
  final String pais;
  final String ciudad;
  final String destino;
  final String lat;
  final String long;
  final double precio;
  final String imagen;

  const Destino({
    required this.id,
    required this.pais,
    required this.ciudad,
    required this.destino,
    required this.lat,
    required this.long,
    required this.precio,
    required this.imagen,
  });

  factory Destino.fromJson(Map<String, dynamic> json) {
    final coordenadas = (json['coordenada'] as String).split(',');

    return Destino(
      id: json['id'] as int,
      pais: json['pais'] as String,
      ciudad: json['ciudad'] as String,
      destino: json['destino'] as String,
      lat: coordenadas[0].trim(),
      long: coordenadas[1].trim(),
      precio: (json['precio'] as num).toDouble(),
      imagen: json['imagen'] ?? "",
    );
  }
}
