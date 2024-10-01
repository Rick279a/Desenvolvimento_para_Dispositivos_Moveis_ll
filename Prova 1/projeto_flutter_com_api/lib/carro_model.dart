class Carro {
  final int id;
  final String marca;
  final String modelo;
  final int ano;
  final double preco;
  final String status;

  Carro({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.preco,
    required this.status,
  });

  factory Carro.fromJson(Map<String, dynamic> json) {
    return Carro(
      id: json['id'],
      marca: json['marca'],
      modelo: json['modelo'],
      ano: json['ano'],
      preco: json['preco'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'ano': ano,
      'preco': preco,
      'status': status,
    };
  }

  Carro copyWith({
    int? id,
    String? marca,
    String? modelo,
    int? ano,
    double? preco,
    String? status,
  }) {
    return Carro(
      id: id ?? this.id,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      ano: ano ?? this.ano,
      preco: preco ?? this.preco,
      status: status ?? this.status,
    );
  }
}
