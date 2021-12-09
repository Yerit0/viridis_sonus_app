import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'apis.viridussonus.cl';

  Future<String?> crearUsuarioPostmanMethod(String nombre, String aPaterno, String aMaterno,
      String nombreUsuario, String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://apis.viridussonus.cl/api/services/app/Account/Register'));
    request.body = json.encode({
      "nombres": nombre,
      "apellidoPaterno": aPaterno,
      "apellidoMaterno": aMaterno,
      "userName": nombreUsuario,
      "emailAddress": email,
      "password": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

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

    final respuesta = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(respuesta.body);

    return '';
  }
}
