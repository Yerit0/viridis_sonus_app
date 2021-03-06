import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:viridis_sonus_app/main.dart';
import 'package:viridis_sonus_app/services/usuario_services.dart';

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

    if (respuesta.statusCode != 200) {
      return decodedResp['error']['message'];
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
      await storage.write(key: 'token', value : decodedResp['result']);
      return null;
    } else {
      return decodedResp['error']['details'];
  }

  }

  Future logout()async{
    await storage.delete(key: 'token');
    
    return;
  }


}
