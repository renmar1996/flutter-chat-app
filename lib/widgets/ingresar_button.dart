import 'package:flutter/material.dart';

class IngresarButton extends StatelessWidget {
  final String textButton;
  final void Function()? onPress;
   IngresarButton({super.key, required this.textButton, required this.onPress});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return ElevatedButton(
        onPressed: onPress,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black,disabledBackgroundColor: Colors.grey),
       
        child: Container(
            width: double.infinity,
            height: size.height/12,
            child: Center(
                child: Text(
              textButton,
              style: TextStyle(color: Colors.white),
            ))));
  }
}
