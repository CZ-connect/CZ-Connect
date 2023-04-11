import 'package:flutter/material.dart';

class containerTextWidget extends StatelessWidget{
  const containerTextWidget({Key? key}) : super(key: key);
  String get h1 => "Meld je hier aan!";
  String get h2 => "Gebruik dit formulier om te solliciteren";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Text(h1, style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 40)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(h2,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
        ),
      ],
    );
  }
}
