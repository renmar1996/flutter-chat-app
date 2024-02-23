import 'package:flutter/material.dart';

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
      return Container(
        padding: EdgeInsets.symmetric(horizontal: size.height/30),
        margin: EdgeInsets.only(top: size.height/20),
        child: Column(children: [
          CustomInput(icon: Icons.mail_outline,placeholder: 'Correo',textController: emailController,keyboardType: TextInputType.emailAddress,),
          CustomInput(icon: Icons.lock_outline,placeholder: 'Contraseña',textController: passController,isPassword: true,),
          IngresarButton(textButton: 'Ingresar',onPress: (){ }),
      ],),
      );
    }
}


