import 'package:flutter/material.dart';

class RegisterContainerTextWidget extends StatelessWidget {
  const RegisterContainerTextWidget({Key? key}) : super(key: key);
  String get str => "Registeren voor CZ-medewerkers";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(str,
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 30)),
      ],
    );
  }
}
