import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../global/enviroment.dart';
import '../models/mensajes_response.dart';
import '../models/usuario.dart';
import 'auth_service.dart';

class ChatService with ChangeNotifier{

  Usuario? usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioId) async{
   final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/mensajes/$usuarioId'),
headers: {
      'Content-Type':'application/json',
      'Authorization':await AuthService.getToken(),
      },
      );
final mensajesResponse= mensajesResponseFromJson(resp.body);
return mensajesResponse.mensajes;
  }
  
}