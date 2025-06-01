import 'dart:convert';

import 'package:realtime_chat/global/environment.dart';
import "package:http/http.dart" as http;
import 'package:realtime_chat/models/user.dart';
import 'package:realtime_chat/models/usuarios_response.dart';
import 'package:realtime_chat/services/auth_service.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final response = await http
          .get(Uri.parse('${Environment.apiUrl}/usuarios'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      });
 
    print('Response body: ${response.body}'); // Confirma el JSON recibido

    final usersResponse = UsuariosResponse.fromJson(response.body);
      return usersResponse.usuarios;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
