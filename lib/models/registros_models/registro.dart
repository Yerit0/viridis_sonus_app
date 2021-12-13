import 'dart:convert';
import 'package:viridis_sonus_app/models/registros_models/listado_registros_response.dart';
import 'package:flutter/material.dart';

class Registro {
    Registro({
        required this.minima,
        required this.maxima,
        required this.media,
        required this.latitud,
        required this.longitud,
        required this.altitud,
        required this.investigador,
        required this.esInvestigador,
        required this.fechaCreacion,
        required this.creationTime,
        required this.claseSonometroId,
        required this.claseSonometro,
        required this.creatorUserId,
        required this.creatorUser,
        required this.interior,
        required this.interiorOExterior,
        required this.id,
    });

    double minima;
    double maxima;
    double media;
    double latitud;
    double longitud;
    double altitud;
    bool investigador;
    String esInvestigador;
    String fechaCreacion;
    DateTime creationTime;
    int claseSonometroId;
    ClaseSonometro claseSonometro;
    int creatorUserId;
    CreatorUser creatorUser;
    bool interior;
    String interiorOExterior;
    int id;

    factory Registro.fromJson(String str) => Registro.fromMap(json.decode(str));

    factory Registro.fromMap(Map<String, dynamic> json) => Registro(
        minima: json["minima"].toDouble(),
        maxima: json["maxima"].toDouble(),
        media: json["media"].toDouble(),
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        altitud: json["altitud"].toDouble(),
        investigador: json["investigador"],
        esInvestigador: json["esInvestigador"],
        fechaCreacion: json["fechaCreacion"],
        creationTime: DateTime.parse(json["creationTime"]),
        claseSonometroId: json["claseSonometroId"],
        claseSonometro: ClaseSonometro.fromMap(json["claseSonometro"]),
        creatorUserId: json["creatorUserId"],
        creatorUser: CreatorUser.fromMap(json["creatorUser"]),
        interior: json["interior"],
        interiorOExterior: json["interiorOExterior"],
        id: json["id"],
    );
}