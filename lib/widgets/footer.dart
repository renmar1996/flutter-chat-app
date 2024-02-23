import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  final String text1;
  final String text2;
  final String footterText;
  final String routeName;
  const Footer({super.key, required this.text1, required this.text2, required this.footterText, required this.routeName });

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return  Padding(
      padding: EdgeInsets.only(top: size.height/20),
      child: Column(children: [
        Text(widget.text1),
        TextButton( child: Text(widget.text2,style: TextStyle(color: Colors.blue),),onPressed: (){
          Navigator.pushReplacementNamed(context, widget.routeName);
        },),
        TextButton( child: Text(widget.footterText,style: TextStyle(color: Colors.grey),),onPressed: (){}),
        
      ],),
    );
  }
}