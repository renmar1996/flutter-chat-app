import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uuid;
  final AnimationController animationController;
   ChatMessage({super.key, required this.texto, required this.uuid, required this.animationController});

  @override
  Widget build(BuildContext context) {
   AuthService authService=Provider.of<AuthService>(context,listen: false);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uuid==authService.usuario!.uuid
          ? _myMessage(context)
          :_notMyMessage(context),
        ),
      ),
    );
  }

  Widget _myMessage(BuildContext context){
    Size size=MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        
        margin: EdgeInsets.only(bottom: size.height/80,right: size.width/80),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(15)
        ),
        padding: EdgeInsets.all(size.width/50),
        child: Text(texto,style: TextStyle(color: Colors.white),),
      ));
  }
  Widget _notMyMessage(BuildContext context){
     Size size=MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        
        margin: EdgeInsets.only(bottom: size.height/80,left: size.width/80),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(15)
        ),
        padding: EdgeInsets.all(size.width/50),
        child: Text(texto,style: TextStyle(color: Colors.black),),
      ));
  }
}