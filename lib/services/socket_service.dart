
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'dart:developer' as log;


import '../global/enviroment.dart';
import 'auth_service.dart';

enum ServerStatus{
  // ignore: constant_identifier_names
  Connecting,
  // ignore: constant_identifier_names
  Online,
  // ignore: constant_identifier_names
  Offline,
}

class SocketProvider with ChangeNotifier{


late io.Socket _socket;

io.Socket get socket=> _socket;

ServerStatus _serverStatus= ServerStatus.Connecting;
ServerStatus get serverStatus=> _serverStatus;

 /* SocketProvider(){
  connect();
}  */

  void connect()async{
    // Dart client
    final token= await AuthService.getToken();
    log.log('Este es el token de la peticion ==> $token');
  _socket=io.io(Enviroment.socketUrl, io.OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .enableAutoConnect()
      .enableForceNew()
      .setExtraHeaders({
        'Authorization':token
      })  // enable auto-connection
      .build()
      );
      
  //socket.connect();  ////// solo si disableAutoConnect esta activado
  
  socket.onConnect((_) {
    _serverStatus= ServerStatus.Online;
    notifyListeners();
    });
  socket.onDisconnect((_) {
    _serverStatus= ServerStatus.Offline;
      notifyListeners();
  });

  socket.on('nuevo-mensaje', (payload){
    log.log('El usuario se llama ${payload['nombre']}');
    log.log('Tiene ${payload['edad']} años de edad');
  });

  }

void disconnect(){
  socket.disconnect();
}
}