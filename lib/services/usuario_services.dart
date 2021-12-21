import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:viridis_sonus_app/models/models.dart';

class UsuarioService extends ChangeNotifier {

  final String _baseUrl = 'apis.viridussonus.cl';
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final storage = new FlutterSecureStorage();

  Usuario? infoUsuario;

  //UsuarioService(){
  //  this.getInfoUsario();
  //}

  Future<String> _getJsonData( String endpoint) async {
    final token = await storage.read(key: 'token') ?? '';
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final url = Uri.https(this._baseUrl, endpoint, );
    final response = await http.post(url, headers: headers);
    return response.body;
  }

  getInfoUsario () async {
    String _endpoint = 'api/services/app/RegistrosSonido/InfoUsuario';
    final jsonData = await this._getJsonData(_endpoint);


    final InfoUsuarioResponse infoUsuarioResponse = InfoUsuarioResponse.fromJson(jsonData);

    if(!infoUsuarioResponse.success){
      return infoUsuarioResponse.error['message'];
    } else {
      this.infoUsuario = infoUsuarioResponse.result;
      notifyListeners();
    }
  }

  logout(){
    infoUsuario = null;
  }

}