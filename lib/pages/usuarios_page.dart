import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios=[
    Usuario(online: true, email: 'daguado@gmail.com', nombre: 'Dayana', uuid: '1'),
    Usuario(online: true, email: 'test1@gmail.com', nombre: 'Test1', uuid: '2'),
    Usuario(online: true, email: 'test2@gmail.com', nombre: 'Test2', uuid: '3'),
  ];
  @override
  Widget build(BuildContext context) {
    final authService= Provider.of<AuthService>(context);
    Usuario usuario= authService.usuario!;
    return Scaffold(
      appBar: AppBar(title:  Text(usuario.nombre),
      elevation: 1,backgroundColor: Colors.white,leading: IconButton(onPressed: (){
        //TODO desconectar
        Navigator.pushReplacementNamed(context, '/login');
        AuthService.deleteToken();

      }, icon:Icon(Icons.exit_to_app)),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: const Icon(Icons.check_circle,color: Colors.blue,),)],
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