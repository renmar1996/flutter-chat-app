import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uuid;
  final AnimationController animationController;
   ChatMessage({super.key, required this.texto, required this.uuid, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uuid=='123'
          ? _myMessage()
          :_notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        
        margin: EdgeInsets.only(bottom: 5,left: 50,right: 5),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(8),
        child: Text(texto,style: TextStyle(color: Colors.white),),
      ));
  }
  Widget _notMyMessage(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        
        margin: EdgeInsets.only(bottom: 5,left: 5,right: 50),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(8),
        child: Text(texto,style: TextStyle(color: Colors.black),),
      ));
  }
}