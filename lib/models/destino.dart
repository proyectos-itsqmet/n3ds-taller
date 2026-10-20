class Destino {
  final int id;
  final String pais;
  final String ciudad;
  final String destino;
  final String coordenada;
  final double precio;
  final String imagen;

  const Destino({
    required this.id,
    required this.pais,
    required this.ciudad,
    required this.destino,
    required this.coordenada,
    required this.precio,
    required this.imagen,
  });

  factory Destino.fromJson(Map<String, dynamic> json) {
    return Destino(
      id: json['id'] as int,
      pais: json['pais'] as String,
      ciudad: json['ciudad'] as String,
      destino: json['destino'] as String,
      coordenada: json['coordenada'] as String,
      precio: (json['precio'] as num).toDouble(),
      imagen: json['imagen'] ?? "",
    );
  }
}
