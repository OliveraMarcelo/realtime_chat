import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:realtime_chat/models/user.dart';

class UsuariosResponse {
  final List<Usuario> usuarios;
  final bool ok;

  UsuariosResponse({
    required this.usuarios,
    required this.ok,
  });

  UsuariosResponse copyWith({
    List<Usuario>? usuarios,
    bool? ok,
  }) {
    return UsuariosResponse(
      usuarios: usuarios ?? this.usuarios,
      ok: ok ?? this.ok,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'usuarios': usuarios.map((x) => x.toMap()).toList()});
    result.addAll({'ok': ok});
  
    return result;
  }

  factory UsuariosResponse.fromMap(Map<String, dynamic> map) {
    return UsuariosResponse(
      usuarios: List<Usuario>.from(map['usuarios']?.map((x) => Usuario.fromMap(x))),
      ok: map['ok'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuariosResponse.fromJson(String source) => UsuariosResponse.fromMap(json.decode(source));

  @override
  String toString() => 'UsuariosResponse(usuarios: $usuarios, ok: $ok)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UsuariosResponse &&
      listEquals(other.usuarios, usuarios) &&
      other.ok == ok;
  }

  @override
  int get hashCode => usuarios.hashCode ^ ok.hashCode;
}
