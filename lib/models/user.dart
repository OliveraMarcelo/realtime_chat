import 'dart:convert';

class Usuario {
  bool online;
  String email;
  String nombre;
  String uid;
  Usuario({
    required this.online,
    required this.email,
    required this.nombre,
    required this.uid,
  });

  Usuario copyWith({
    bool? online,
    String? email,
    String? nombre,
    String? uid,
  }) {
    return Usuario(
      online: online ?? this.online,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'online': online});
    result.addAll({'email': email});
    result.addAll({'nombre': nombre});
    result.addAll({'uid': uid});
  
    return result;
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      online: map['online'] ?? false,
      email: map['email'] ?? '',
      nombre: map['nombre'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Usuario(online: $online, email: $email, nombre: $nombre, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Usuario &&
      other.online == online &&
      other.email == email &&
      other.nombre == nombre &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return online.hashCode ^
      email.hashCode ^
      nombre.hashCode ^
      uid.hashCode;
  }
}
