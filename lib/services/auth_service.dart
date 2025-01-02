import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/login_response.dart';
import 'package:realtime_chat/models/user.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  final storage = const FlutterSecureStorage();
  bool _autenticando = false;
  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token!;
  }

  Future<bool> logout() async {
    await storage.delete(key: 'token');
    return true;
  }

  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  //final usuario = ??
  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {'email': email, 'password': password};
    print('${Environment.apiUrl}/login/');
    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    // Verificar el código de estado
    if (resp.statusCode == 200) {
      // El servidor respondió con éxito
      print('Login exitoso');
      print(resp.body);

      final loginResponse = LoginResponse.fromJson(resp.body);
      usuario = loginResponse.usuario;
      await saveToken(loginResponse.token);
      print(usuario.toString());
      return true;
      // Aquí puedes manejar lo que haga falta con la respuesta (guardar token, etc)
    } else {
      autenticando = false;
      // Hubo un error en la respuesta del servidor
      print('Error en el login. Código de estado: ${resp.statusCode}');
      print('Cuerpo del error: ${resp.body}');
      return false;
    }
  }
}
