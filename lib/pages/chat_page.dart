import 'dart:developer';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
   const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{
final TextEditingController _textController=TextEditingController();
final FocusNode _focusNode=FocusNode();
bool _estaEscribiendo=false;
final List<ChatMessage> _messages=[
  /* ChatMessage(texto: 'Hola mundo', uuid: '123'),
  ChatMessage(texto: 'Haaaaaaaaaaa', uuid: '1234'),
  ChatMessage(texto: 'Hola mundo', uuid: '123'), */
];
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(children: [
          CircleAvatar(
            child: Text('Te',style: TextStyle(fontSize: size.width/30),),
            backgroundColor: Colors.blue[100],
            maxRadius: 14,
          ),
          SizedBox(height: 3,),
          Text('Melisa Flores',style: TextStyle(color: Colors.black87,fontSize: size.width/30),)
        ],),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(child: Column(children: [
        Flexible(child: ListView.builder(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          itemCount: _messages.length,
          itemBuilder: (BuildContext context, int index) {
            return  _messages[index];
          },
        ),),
        Divider(height: 1,),
        Container(
          color: Colors.white,
          child: _inputChat(),
        )
      ],),),
    );
  }

  Widget _inputChat(){
    Size size=MediaQuery.of(context).size;
return SafeArea(child: Container(
  margin: EdgeInsets.symmetric(horizontal: 8),
  child: Row(children: [
    Flexible(child: TextField(
      controller: _textController,
      onSubmitted: (value) {
        
      },
      onChanged: (String texto) {
        //Cuando hay un valor,para poder postear
        setState(() {
          if(texto.trim().isNotEmpty){
          _estaEscribiendo=true;
        }else{
          _estaEscribiendo=false;
        }
        });
      },
      decoration:  const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
      focusNode: _focusNode,
    ),
    ),
    IconTheme(
      data: IconThemeData(
        color: Colors.blue[400]
      ),
      child: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: _estaEscribiendo 
        ?()=>_handleSubmit(_textController.text.trim()) 
        :null, 
      icon: const Icon(Icons.send,)
      ),
    ),
  ],),
));
  }

  _handleSubmit(String texto){
    if(texto.isEmpty)return;
    log(texto);
    _textController.clear();
    _focusNode.requestFocus();
    final newMessage=ChatMessage(texto: texto, uuid: '1235',animationController: AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400)),);
    _messages.insert(0,newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo=false;
    });

  }
  @override
  void dispose() {
    //TODO Offf del socket
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}