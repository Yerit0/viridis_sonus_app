import 'dart:convert';

class Sonometro {
    Sonometro({
        required this.descripcion,
        required this.id,
    });

    String descripcion;
    int id;

    factory Sonometro.fromJson(String str) => Sonometro.fromMap(json.decode(str));

    factory Sonometro.fromMap(Map<String, dynamic> json) => Sonometro(
        descripcion: json["descripcion"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "descripcion": descripcion,
        "id": id,
    };
}