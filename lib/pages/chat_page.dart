import 'dart:developer';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mensajes_response.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  final List<ChatMessage> _messages = [];
  ChatService? chatService;
  SocketProvider? socketProvider;
  AuthService? authService;
  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketProvider = Provider.of<SocketProvider>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketProvider!.socket.on('mensaje-personal', _escucharMensaje);
    _cargarHistorial(chatService!.usuarioPara!.uuid);
  }

  void _cargarHistorial(String uuid) async {
    List<Mensaje> chat = await chatService!.getChat(uuid);
    final history = chat.map((mens) => ChatMessage(
        texto: mens.mensaje, uuid: mens.de, animationController: AnimationController(vsync: this,duration: Duration(milliseconds: 300))..forward()));
    if(mounted){
      setState(() {
    _messages.insertAll(0, history);
  });
    }
  }

  void _escucharMensaje(dynamic payload) {
    print('Tengo mensaje ==> $payload');
    ChatMessage message = ChatMessage(
        texto: payload['mensaje'],
        uuid: payload['de'],
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 300)));
    if (mounted) {
      setState(() {
        _messages.insert(0, message);
      });
    message.animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final chatService = Provider.of<ChatService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                chatService.usuarioPara!.nombre.substring(0, 2),
                style: TextStyle(fontSize: size.width / 30),
              ),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              chatService.usuarioPara!.nombre,
              style:
                  TextStyle(color: Colors.black87, fontSize: size.width / 30),
            )
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _messages[index];
                },
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: (value) {},
              onChanged: (String texto) {
                //Cuando hay un valor,para poder postear
                if(mounted){
                  setState(() {
                  if (texto.trim().isNotEmpty) {
                    _estaEscribiendo = true;
                  } else {
                    _estaEscribiendo = false;
                  }
                });
                }
              },
              decoration:
                  const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
              focusNode: _focusNode,
            ),
          ),
          IconTheme(
            data: IconThemeData(color: Colors.blue[400]),
            child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: _estaEscribiendo
                    ? () => _handleSubmit(_textController.text.trim())
                    : null,
                icon: const Icon(
                  Icons.send,
                )),
          ),
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.isEmpty) return;
    log(texto);
    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
      texto: texto,
      uuid: authService!.usuario!.uuid,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    if(mounted){}
    setState(() {
      _estaEscribiendo = false;
    });
    //Emitimos el mensaje al socket
    socketProvider!.socket.emit('mensaje-personal', {
      'de': authService!.usuario!.uuid,
      'para': chatService!.usuarioPara!.uuid,
      'mensaje': texto
    });
    //////////////////
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
