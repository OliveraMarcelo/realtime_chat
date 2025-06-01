import 'package:meta/meta.dart';
import 'dart:convert';

class MensajesResponse {
    bool ok;
    List<Mensaje> mensajes;

    MensajesResponse({
        required this.ok,
        required this.mensajes,
    });

    MensajesResponse copyWith({
        bool? ok,
        List<Mensaje>? mensajes,
    }) => 
        MensajesResponse(
            ok: ok ?? this.ok,
            mensajes: mensajes ?? this.mensajes,
        );

    factory MensajesResponse.fromRawJson(String str) => MensajesResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MensajesResponse.fromJson(Map<String, dynamic> json) => MensajesResponse(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(json["mensajes"].map((x) => Mensaje.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
    };
}

class Mensaje {
    String de;
    String para;
    String mensaje;
    DateTime createdAt;
    DateTime updatedAt;

    Mensaje({
        required this.de,
        required this.para,
        required this.mensaje,
        required this.createdAt,
        required this.updatedAt,
    });

    Mensaje copyWith({
        String? de,
        String? para,
        String? mensaje,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Mensaje(
            de: de ?? this.de,
            para: para ?? this.para,
            mensaje: mensaje ?? this.mensaje,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Mensaje.fromRawJson(String str) => Mensaje.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
