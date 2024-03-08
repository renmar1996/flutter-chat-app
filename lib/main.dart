import 'package:flutter/material.dart';

import 'package:chat/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'services/auth_service.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Colors.transparent, // Aquí puedes definir el color que desees
      statusBarIconBrightness: Brightness
          .dark, // Para cambiar el color de los iconos (blanco o negro)
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>AuthService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: '/loading',
        routes: appRoutes,
      ),
    );
  }
}


