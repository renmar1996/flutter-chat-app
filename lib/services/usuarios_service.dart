import 'package:chat/global/enviroment.dart';
import 'package:chat/models/usuario_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:http/http.dart'as http;

import '../models/usuario.dart';

class UsuariosService{
  Future<List<Usuario>> getUsuarios()async{
    try {
      
      final resp= await http.get(Uri.parse('${Enviroment.apiUrl}/usuarios/'),
headers: {
      'Content-Type':'application/json',
      'Authorization':await AuthService.getToken(),
      },);
      final usuariosResponse=usuarioResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}