import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:realtime_chat/models/user.dart';

class LoginResponse {
    bool ok;
    String msg;
    Usuario usuario;
    String token;

    LoginResponse({
        required this.ok,
        required this.msg,
        required this.usuario,
        required this.token,
    });


  LoginResponse copyWith({
    bool? ok,
    String? msg,
    Usuario? usuario,
    String? token,
  }) {
    return LoginResponse(
      ok: ok ?? this.ok,
      msg: msg ?? this.msg,
      usuario: usuario ?? this.usuario,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'ok': ok});
    result.addAll({'msg': msg});
    result.addAll({'usuario': usuario.toMap()});
    result.addAll({'token': token});
  
    return result;
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      ok: map['ok'] ?? false,
      msg: map['msg'] ?? '',
      usuario: Usuario.fromMap(map['usuario']),
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoginResponse(ok: $ok, msg: $msg, usuario: $usuario, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LoginResponse &&
      other.ok == ok &&
      other.msg == msg &&
      other.usuario == usuario &&
      other.token == token;
  }

  @override
  int get hashCode {
    return ok.hashCode ^
      msg.hashCode ^
      usuario.hashCode ^
      token.hashCode;
  }
}

