// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

//{
//    "result": null,
//    "targetUrl": null,
//    "success": false,
//    "error": {
//        "code": 0,
//        "message": "El usuario actual no ha iniciado sesión en la aplicación!",
//        "details": null,
//        "validationErrors": null
//    },
//    "unAuthorizedRequest": true,
//    "__abp": true
//}


import 'dart:convert';

import 'package:viridis_sonus_app/models/registros_models/registro.dart';

class ListadoRegistrosResponse {
    ListadoRegistrosResponse({
        required this.result,
        this.targetUrl,
        required this.success,
        this.error,
        required this.unAuthorizedRequest,
        this.abp,
    });

    Resultado result;
    dynamic? targetUrl;
    bool success;
    dynamic? error;
    bool unAuthorizedRequest;
    bool? abp;

    factory ListadoRegistrosResponse.fromJson(String str) => ListadoRegistrosResponse.fromMap(json.decode(str));

    factory ListadoRegistrosResponse.fromMap(Map<String, dynamic> json) => ListadoRegistrosResponse(
        result: Resultado.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
    );

}

class Resultado {
    Resultado({
        required this.totalCount,
        this.items,
    });

    int totalCount;
    List<Registro>? items;

    factory Resultado.fromJson(String str) => Resultado.fromMap(json.decode(str));

    factory Resultado.fromMap(Map<String, dynamic> json) => Resultado(
        totalCount: json["totalCount"],
        items: List<Registro>.from(json["items"].map((x) => Registro.fromMap(x))),
    );

}

class ClaseSonometro {
    ClaseSonometro({
        required this.descripcion,
        required this.id,
    });

    String descripcion;
    int id;

    factory ClaseSonometro.fromJson(String str) => ClaseSonometro.fromMap(json.decode(str));

    factory ClaseSonometro.fromMap(Map<String, dynamic> json) => ClaseSonometro(
        descripcion: json["descripcion"],
        id: json["id"],
    );
}

class CreatorUser {
    CreatorUser({
        required this.userName,
        this.name,
        this.surname,
        this.apellidoMaterno,
        this.emailAddress,
        this.isActive,
        this.fullName,
        this.lastLoginTime,
        required this.creationTime,
        this.roles,
        required this.id,
    });

    String userName;
    dynamic? name;
    dynamic? surname;
    dynamic? apellidoMaterno;
    dynamic? emailAddress;
    bool? isActive;
    dynamic? fullName;
    dynamic ?lastLoginTime;
    DateTime creationTime;
    dynamic? roles;
    int id;

    factory CreatorUser.fromJson(String str) => CreatorUser.fromMap(json.decode(str));

    factory CreatorUser.fromMap(Map<String, dynamic> json) => CreatorUser(
        userName: json["userName"],
        name: json["name"],
        surname: json["surname"],
        apellidoMaterno: json["apellidoMaterno"],
        emailAddress: json["emailAddress"],
        isActive: json["isActive"],
        fullName: json["fullName"],
        lastLoginTime: json["lastLoginTime"],
        creationTime: DateTime.parse(json["creationTime"]),
        roles: json["roles"],
        id: json["id"],
    );
}
