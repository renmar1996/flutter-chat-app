import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarioService= UsuariosService();
  List<Usuario> usuarios=[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  
@override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService= Provider.of<AuthService>(context);
    final socketService= Provider.of<SocketProvider>(context);
    Usuario usuario= authService.usuario!;
    return Scaffold(
      appBar: AppBar(title:  Text(usuario.nombre),
      elevation: 1,backgroundColor: Colors.white,leading: IconButton(onPressed: (){
        socketService.disconnect();
        Navigator.pushReplacementNamed(context, '/login');
        AuthService.deleteToken();

      }, icon:Icon(Icons.exit_to_app)),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: socketService.serverStatus==ServerStatus.Online 
          ?Icon(Icons.check_circle,color: Colors.blue,)
          :Icon(Icons.offline_bolt,color: Colors.red,)
          ),
          ],
      ),
    
    body: SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: _cargarUsuarios,
      header: WaterDropHeader(
        complete: Icon(Icons.check,color: Colors.blue[400],),
      ),
      child: _listviewUsuario()),
    );
  }

  ListView _listviewUsuario() {
    return ListView.separated(
    physics:const BouncingScrollPhysics(),
    itemBuilder: (context, index) => _usuarioListTitle(usuarios[index]), 
  separatorBuilder: (context, index) => Divider(), itemCount: usuarios.length);
  }

  ListTile _usuarioListTitle(Usuario usuario) {
    return ListTile(
      onTap: (){
        final chatService=Provider.of<ChatService>(context,listen: false);
        chatService.usuarioPara=usuario;
        Navigator.pushNamed(context, '/chat');
      },
    title: Text(usuario.nombre),
    subtitle: Text(usuario.email),
    leading: CircleAvatar(
      backgroundColor: Colors.blue[100],
      child: Text(usuario.nombre.substring(0,2)),
    ),
    trailing: Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: usuario.online ? Colors.green[300] : Colors.red,
        borderRadius: BorderRadius.circular(100),
      ),
    ) ,
  );
  }
 Future<void> _cargarUsuarios()async{
     await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    
     usuarios=await usuarioService.getUsuarios();
     setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    
    //usuarios.add(());
    if(mounted)
    setState(() {

    });
    _refreshController.loadComplete();
  }
}