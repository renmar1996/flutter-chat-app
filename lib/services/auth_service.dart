import 'dart:convert';
import 'dart:developer';
import 'package:chat/global/enviroment.dart';
import 'package:flutter/material.dart';
import'package:http/http.dart'as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/login_response.dart';
import '../models/usuario.dart';

class AuthService with ChangeNotifier{

Usuario? usuario;

bool _autenticando=false;

bool get autenticando => _autenticando;
     set autenticando(bool value){
      _autenticando=value;
      notifyListeners();
    }

///Getters del token de forma estática
 static Future<String> getToken()async{
  const store= FlutterSecureStorage();
  final token= await store.read(key: 'token');
  return token!;
}
static Future<void> deleteToken()async{
  const store= FlutterSecureStorage();
  await store.delete(key: 'token');
  } 

final _storage=const FlutterSecureStorage();

Future<bool> login(String email,String password)async{

  autenticando=true;

  final data={
    'email':email,
    'password':password
  };
log(data.toString());
  final resp=await http.post(Uri.parse('${Enviroment.apiUrl}/login'),
    body: jsonEncode(data),
    headers: {
      'Content-Type':'application/json'
      },
  );
log(resp.body);
 autenticando=false;
 if(resp.statusCode==200){
  final loginResponse= loginResponseFromJson(resp.body);
  usuario=loginResponse.usuario;
  await guardarToken(loginResponse.token);
  return true;
} else{
  return false;
}

}

Future register(String nombre,String email,String password)async{
autenticando=true;

  final data={
    'nombre':nombre,
    'email':email,
    'password':password
  };
log(data.toString());
  final resp=await http.post(Uri.parse('${Enviroment.apiUrl}/login/new'),
    body: jsonEncode(data),
    headers: {
      'Content-Type':'application/json'
      },
  );
log(resp.body);
 autenticando=false;
 if(resp.statusCode==200){
  final loginResponse= loginResponseFromJson(resp.body);
  usuario=loginResponse.usuario;
  await guardarToken(loginResponse.token);
  return true;
} else{
  Map<String,dynamic> respBody= jsonDecode(resp.body);
  if(respBody.containsKey('msg')){

  return respBody['msg'];
  }else{
    return 'No hay ni pinga';
  }
}


}

Future<bool> isLoggedIn()async{
  final token=await _storage.read(key: 'token');
final resp=await http.get(Uri.parse('${Enviroment.apiUrl}/login/renewToken'),
headers: {
      'Content-Type':'application/json',
      'Authorization':token!
      },);
      
      if(resp.statusCode==200){
  final loginResponse= loginResponseFromJson(resp.body);
  usuario=loginResponse.usuario;
  await guardarToken(loginResponse.token);
  return true;
} else{
  logout();
  return false;
}
}

  Future guardarToken(String token)async{
    return await _storage.write(key: 'token', value: token);
  }
Future logout()async{
  await _storage.delete(key: 'token');
} 
}