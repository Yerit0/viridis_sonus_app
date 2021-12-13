import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'apis.viridussonus.cl';
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final storage = new FlutterSecureStorage();

  Future<String?> crearUsuario(String nombre, String aPaterno, String aMaterno,
      String nombreUsuario, String email, String password) async {
    final Map<String, dynamic> authData = {
      "nombres": nombre,
      "apellidoPaterno": aPaterno,
      "apellidoMaterno": aMaterno,
      "userName": nombreUsuario,
      "emailAddress": email,
      "password": password
    };

    final url = Uri.https(_baseUrl, 'api/services/app/Account/Register');

    final respuesta = await http.post(url, 
                                      headers: headers,
                                      body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(respuesta.body);

    if (respuesta.statusCode == 201) {
      return 'Usuario creado!';
    } else {
      return decodedResp['error']['details'];
  }
  }

  Future<String?> loginUsuario(String usernameOrEmail, String password) async {

    final Map<String, dynamic> authData = {
      "userNameOrEmailAddress": usernameOrEmail,
      "password": password
    };

    final url = Uri.https(_baseUrl, 'api/Account/Authenticate');

    final respuesta = await http.post(url, 
                                      headers: headers,
                                      body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(respuesta.body);

    if(decodedResp.containsKey('result')){
      
    }

    if (respuesta.statusCode == 200) {
      //print(decodedResp['result']);
      await storage.write(key: 'token', value : decodedResp['result']);
      return null;
    } else {
      //print(decodedResp['error']['details']);
      return decodedResp['error']['details'];
  }

  }


}
