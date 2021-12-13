import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:viridis_sonus_app/models/models.dart';

class SonometroService extends ChangeNotifier {
  final String _baseUrl = 'apis.viridussonus.cl';
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final storage = new FlutterSecureStorage();
  
  List<Sonometro> listadoSonometro = [];

  SonometroService(){
    this.getSonometros();
  }

  Future<String> _getJsonData( String endpoint) async {
    final token = await storage.read(key: 'token') ?? '';
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final url = Uri.https(this._baseUrl, endpoint, );
    final response = await http.post(url, headers: headers);
    print(response.body);
    return response.body;
  }
  
  getSonometros() async {
    String _endpoint = 'api/services/app/RegistrosSonido/TiposSonometros';
    final jsonData = await this._getJsonData(_endpoint);

    print(jsonData);

    final ListadoSonometroResponse sonometrosResponse = ListadoSonometroResponse.fromJson(jsonData);

    if(!sonometrosResponse.success){
      return sonometrosResponse.error['message'];
    } else {
      this.listadoSonometro = sonometrosResponse.result;
      notifyListeners();
    }



  }
  
}