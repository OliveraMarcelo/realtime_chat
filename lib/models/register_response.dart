import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:realtime_chat/models/user.dart';

class RegisterResponse {
    bool ok;
    Usuario usuario;
    String token;

    RegisterResponse({
        required this.ok,
        required this.usuario,
        required this.token,
    });

    

  RegisterResponse copyWith({
    bool? ok,
    Usuario? usuario,
    String? token,
  }) {
    return RegisterResponse(
      ok: ok ?? this.ok,
      usuario: usuario ?? this.usuario,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'ok': ok});
    result.addAll({'usuario': usuario.toMap()});
    result.addAll({'token': token});
  
    return result;
  }

  factory RegisterResponse.fromMap(Map<String, dynamic> map) {
    return RegisterResponse(
      ok: map['ok'] ?? false,
      usuario: Usuario.fromMap(map['usuario']),
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterResponse.fromJson(String source) => RegisterResponse.fromMap(json.decode(source));

  @override
  String toString() => 'RegisterResponse(ok: $ok, usuario: $usuario, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RegisterResponse &&
      other.ok == ok &&
      other.usuario == usuario &&
      other.token == token;
  }

  @override
  int get hashCode => ok.hashCode ^ usuario.hashCode ^ token.hashCode;
}
