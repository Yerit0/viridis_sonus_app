//{
//    "result": [
//        {
//            "descripcion": "Aplicación",
//            "id": 1
//        },
//        {
//            "descripcion": "Sonómetro clase 1",
//            "id": 2
//        },
//        {
//            "descripcion": "Sonómetro clase 2",
//            "id": 3
//        },
//        {
//            "descripcion": "Sonómetro clase 3",
//            "id": 4
//        }
//    ],
//    "targetUrl": null,
//    "success": true,
//    "error": null,
//    "unAuthorizedRequest": false,
//    "__abp": true
//}

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
import 'package:viridis_sonus_app/models/models.dart';

class ListadoSonometroResponse {
    ListadoSonometroResponse({
        required this.result,
        this.targetUrl,
        required this.success,
        this.error,
        required this.unAuthorizedRequest,
        required this.abp,
    });

    List<Sonometro> result;
    dynamic? targetUrl;
    bool success;
    dynamic? error;
    bool unAuthorizedRequest;
    bool abp;

    factory ListadoSonometroResponse.fromJson(String str) => ListadoSonometroResponse.fromMap(json.decode(str));

    factory ListadoSonometroResponse.fromMap(Map<String, dynamic> json) => ListadoSonometroResponse(
        result: List<Sonometro>.from(json["result"].map((x) => Sonometro.fromMap(x))),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
    );

}


