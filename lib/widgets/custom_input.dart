import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput({super.key, 
  required this.icon,
   required this.placeholder, 
   required this.textController,
   this.keyboardType=TextInputType.text, 
    this.isPassword=false});

  @override
  Widget build(BuildContext context) {
     Size size=MediaQuery.of(context).size;
    return Container(child: Column(children: [
        Container(
          padding: EdgeInsets.only(top: size.height/90,left: size.width/50,bottom: size.height/90,right: size.width /20,),
          margin: EdgeInsets.only(bottom: size.height/60),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30),boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black.withOpacity(0.05),offset: Offset(0, 5),blurRadius: 5)
          ]),
          child: TextField(
            controller: textController,
            autocorrect: false,
            keyboardType: keyboardType,
            obscureText: isPassword,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
focusedBorder: InputBorder.none,
border: InputBorder.none,
hintText: placeholder,

            ),
          ),),
      ],),);
  }
}