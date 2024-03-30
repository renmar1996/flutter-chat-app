import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
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
        if(snapshot.hasError){
          return const Center(child:Text('Ha tenido un error al sincronizar'));
        }else{

        return const Center(child: CircularProgressIndicator());
        }
      },
    ),
    );
  }

  Future checkLoginState(BuildContext context) async{
     final authservice=Provider.of<AuthService>(context,listen:false);
     final socketservice=Provider.of<SocketProvider>(context,listen:false);
     
    final autenticado=await authservice.isLoggedIn();
    if(autenticado){
      socketservice.connect();
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