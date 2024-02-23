import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
    const Logo({super.key, required this.title});
  
    @override
    Widget build(BuildContext context) {
      Size size=MediaQuery.of(context).size;
      return Container(
        child: Column(
          children: [
            Image.asset('assets/logo chat.jpg',height: size.height/3,),
            Text(title,style: TextStyle(fontSize: size.width/15),)
          ],
        ),
      );
    }
  }