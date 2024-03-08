// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    String nombre;
    String email;
    bool online;
    String uuid;

    Usuario({
        required this.nombre,
        required this.email,
        required this.online,
        required this.uuid,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json.containsKey('nombre')?json["nombre"]:'',
        email: json.containsKey('email')?json["email"]:'',
        online: json.containsKey('online')?json["online"]:true,
        uuid: json.containsKey('uuid')?json["uuid"]:'',
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "email": email,
        "online": online,
        "uuid": uuid,
    };
}
