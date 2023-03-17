import 'package:flutter/material.dart';

class containerTextWidget extends StatelessWidget{
  const containerTextWidget({Key? key}) : super(key: key);
  String get h1 => "Sing up here!";
  String get h2 => "use this form to apply";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Text(h1, style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 40)),
        Text(h2,
            style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 32))
      ],
    );
  }

}