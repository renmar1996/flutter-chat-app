import 'package:flutter/material.dart';

import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/usuarios_page.dart';

import '../pages/chat_page.dart';
import '../pages/login_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes={
  '/usuarios':(_)=>  const UsuariosPage(),
  '/chat':(_)=>   ChatPage(),
  '/login':(_)=>  const LoginPage(),
  '/register':(_)=>  const RegisterPage(),
  '/loading':(_)=>  const LoadingPage(),

};