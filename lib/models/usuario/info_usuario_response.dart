import 'dart:convert';

import 'package:viridis_sonus_app/models/models.dart';

class InfoUsuarioResponse {
    InfoUsuarioResponse({
        required this.result,
        this.targetUrl,
        required this.success,
        this.error,
        required this.unAuthorizedRequest,
        required this.abp,
    });

    Usuario result;
    dynamic? targetUrl;
    bool success;
    dynamic? error;
    bool unAuthorizedRequest;
    bool abp;

    factory InfoUsuarioResponse.fromJson(String str) => InfoUsuarioResponse.fromMap(json.decode(str));

    factory InfoUsuarioResponse.fromMap(Map<String, dynamic> json) => InfoUsuarioResponse(
        result: Usuario.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
    );

}

