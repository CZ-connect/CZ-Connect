import 'package:flutter/material.dart';

class ContainerTextWidget extends StatelessWidget {
  const ContainerTextWidget({Key? key}) : super(key: key);
  String get h1 => "Meld je hier aan!";
  String get h2 => "Gebruik dit formulier om te solliciteren.";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(h1,
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        Text(h2,
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 16))
      ],
    );
  }
}
