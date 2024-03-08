import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body:FutureBuilder(
      future: checkLoginState(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Center(child: Text('Espere'),);
      },
    ),
    );
  }

  Future checkLoginState(BuildContext context) async{
     final authservice=Provider.of<AuthService>(context,listen:false);
    final autenticado=await authservice.isLoggedIn();
    if(autenticado){
      //TODO: Contectar al socket
    Navigator.pushReplacement(context,
    PageRouteBuilder(pageBuilder: (_,__, ___) => const UsuariosPage(),)
    );
    }else{
     Navigator.pushReplacement(context,
    PageRouteBuilder(pageBuilder: (_,__, ___) => const LoginPage(),)
    );
    }
    
  }
}