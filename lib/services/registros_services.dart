import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:viridis_sonus_app/models/models.dart';

class RegistrosService extends ChangeNotifier {

  final String _baseUrl = 'apis.viridussonus.cl';
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final storage = new FlutterSecureStorage();

  List<Registro> registros = [];

  RegistrosService(){
    this.getRegistros();
  }
  
  Future<String?> _getJsonData( String endpoint, Map<String, dynamic> body) async {
    final token = await storage.read(key: 'token') ?? '';
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final url = Uri.https(this._baseUrl, endpoint, );

    final response = await http.post(url, headers: headers, body: json.encode(body));
      return response.body;
    }

  getRegistros() async {
    String _endpoint = 'api/services/app/RegistrosSonido/GetAll';
    final Map<String, dynamic> bodyData = {
      "SkipCount": 0,
      "MaxResultCount": 10,
      "ClaseSonometro": 1,
      "FechaDesde": null,
      "FechaHasta": null,
      "TipoUsuario": 0,
      "Usuario": 0,
      "Intensidad": 0
    };
    final jsonData = await this._getJsonData(_endpoint, bodyData);
    //TODO: corroborar si result != de null antes de mapear la data al modelo

    final registrosResponse = ListadoRegistrosResponse.fromJson(jsonData!);

    if(!registrosResponse.success){
      return registrosResponse.error['message'];
    } else {
      this.registros = registrosResponse.result!.items!;
      notifyListeners();
    }
  }

  crearRegistro(double minima, double maxima, double media, int claseSonometroId, bool interior,
                double latitud, double longitud, bool investigador) async {
    String _endpoint = 'api/services/app/RegistrosSonido/Create';
    final Map<String, dynamic> bodyData = {
      "MINIMA": minima,
      "MAXIMA": maxima,
      "MEDIA": media, //desde formulario
      "CLASESONOMETROID": claseSonometroId, //desde lista de sonometro
      "Interior": interior,
      "LATITUD": latitud,
      "LONGITUD": longitud,
      "ALTITUD": 0,
      "INVESTIGADOR": investigador
    };
    final jsonData = await this._getJsonData(_endpoint, bodyData);

    final Map<String, dynamic> decodedResponse = jsonDecode(jsonData!);

    if( decodedResponse['success'] == true ){
      await getRegistros();
      return null;
    } else {
      return decodedResponse['error']['message'];
    }
    
  }

}