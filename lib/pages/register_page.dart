import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../services/socket_service.dart';
import '../widgets/custom_input.dart';
import '../widgets/footer.dart';
import '../widgets/ingresar_button.dart';
import '../widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //backgroundColor: Color(0xffF2F2F2),
       body: SafeArea(
         child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
           child: Column(children: [
           Logo(title: 'Register'),
           _FormRegister(),
           Footer(text1: '¿Ya tienes cuenta?',text2: 'Ingresar con esta cuenta',footterText: 'Términos y condiciones de uso',routeName: '/login'),
           ]),
         ),
       ), 
    );
  }

}
  
  class _FormRegister extends StatefulWidget {
    const _FormRegister({super.key});

  @override
  State<_FormRegister> createState() =>_FormState();
}

class _FormState extends State<_FormRegister> {
  TextEditingController emailController= TextEditingController();
  TextEditingController nameController= TextEditingController();
  TextEditingController passController= TextEditingController();
    @override
    Widget build(BuildContext context) {
      Size size=MediaQuery.of(context).size;
       final authService=Provider.of<AuthService>(context);
       final socketService=Provider.of<SocketProvider>(context);
      return Container(
        padding: EdgeInsets.symmetric(horizontal: size.height/30),
        margin: EdgeInsets.only(top: size.height/20),
        child: Column(children: [
          CustomInput(icon: Icons.account_box,placeholder: 'Nombre',textController: nameController,keyboardType: TextInputType.emailAddress,),
          CustomInput(icon: Icons.mail_outline,placeholder: 'Correo',textController: emailController,),
          CustomInput(icon: Icons.lock_outline,placeholder: 'Contraseña',textController: passController,isPassword: true,),
          IngresarButton(textButton: 'Registrar',onPress:authService.autenticando ?null:()async{
           final registerOK= await authService.register(nameController.text.trim(), emailController.text.trim(), passController.text.trim());
           if(registerOK==true){
            socketService.connect();
            Navigator.pushReplacementNamed(context, '/usuarios');
           }else{
            mostrarAlerta(context, 'Registro Incorrecto', registerOK);
           }
          }),
      ],),
      );
    }
}


