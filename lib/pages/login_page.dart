import 'dart:developer';

import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/mostrar_alerta.dart';
import '../widgets/custom_input.dart';
import '../widgets/footer.dart';
import '../widgets/ingresar_button.dart';
import '../widgets/logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //backgroundColor: Color(0xffF2F2F2),
       body: SafeArea(
         child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
           child: Column(children: [
           Logo(title: 'Login'),
           _Form(),
           Footer(text1: '¿No tienes una cuenta?',text2: 'Crea una cuenta',footterText: 'Términos y condiciones de uso',routeName: '/register'),
           ]),
         ),
       ), 
    );
  }
}
  
  class _Form extends StatefulWidget {
    const _Form({super.key});

  @override
  State<_Form> createState() =>_FormState();
}

class _FormState extends State<_Form> {
  TextEditingController emailController= TextEditingController();
  TextEditingController passController= TextEditingController();
    @override
    Widget build(BuildContext context) {
      Size size=MediaQuery.of(context).size;
      final authService=Provider.of<AuthService>(context);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: size.height/30),
        margin: EdgeInsets.only(top: size.height/20),
        child: Column(children: [
          CustomInput(icon: Icons.mail_outline,placeholder: 'Correo',textController: emailController,keyboardType: TextInputType.emailAddress,),
          CustomInput(icon: Icons.lock_outline,placeholder: 'Contraseña',textController: passController,isPassword: true,),
          IngresarButton(textButton: 'Ingresar',onPress:authService.autenticando?null:()async{
            log(emailController.text);
            log(passController.text);
           FocusScope.of(context).unfocus();
           final loginOk=await authService.login(emailController.text.trim(), passController.text.trim());
           if(loginOk){
            //TODO> Conectar a nuestro socket server
            //TODO:Navegar a otra pantalla
            Navigator.pushReplacementNamed(context, '/usuarios');
           }else{
            //TODO: Mostrar alert
            mostrarAlerta(context,'Login Incorrecto','Revise sus credenciales nuevamente');
           }
           }),
      ],),
      );
    }
}


