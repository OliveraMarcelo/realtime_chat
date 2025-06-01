import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/login_response.dart';
import 'package:realtime_chat/models/register_response.dart';
import 'package:realtime_chat/models/user.dart';

class AuthService with ChangeNotifier {
    Usuario? usuario;

AuthService() {
    isLoggedIn();
  }

  final storage = const FlutterSecureStorage();
  bool _autenticando = false;
  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token!;
  }

  Future<bool> logout() async {
    await storage.delete(key: 'token');
    autenticando = false;
    return true;
  }

  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {'email': email, 'password': password};
    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      usuario = loginResponse.usuario;
      await saveToken(loginResponse.token);
      
      return true;
    } else {
      autenticando = false;
      print('Error en el login. Código de estado: ${resp.statusCode}');
      print('Cuerpo del error: ${resp.body}');
      return false;
    }
  }

  Future<bool> register(String nombre, String email, String password) async {
    final data = {'nombre': nombre, 'email': email, 'password': password};
    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/new'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      final registerResponse = RegisterResponse.fromJson(resp.body);
      usuario = registerResponse.usuario;
      await saveToken(registerResponse.token);
      return true;
    } else {
      print('Error en el register. Código de estado: ${resp.statusCode}');
      print('Cuerpo del error: ${resp.body}');
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
        print("Cuerpo ");

    final token = await storage.read(key: 'token') ?? '';
    print(token);
    if (token.isEmpty) {
      return false;
    }
    final resp = await http.get(Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token });

    if (resp.statusCode == 200) {
      final registerResponse = RegisterResponse.fromJson(resp.body);
      usuario = registerResponse.usuario;
      await saveToken(registerResponse.token);
      return true;
    } else {
      logout();
      print('Error en el re new token. Código de estado: ${resp.statusCode}');
      print('Cuerpo del error: ${resp.body}');
      return false;
    }
  }
}
