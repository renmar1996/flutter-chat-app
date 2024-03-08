import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context,String titulo, String subtitulo){
  showDialog(context: context, builder:(context) {
    return AlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        MaterialButton(onPressed: (){
          Navigator.pop(context);
        },child: Text('OK'),textColor: Colors.blue,)
      ],
    );
  }, );
}