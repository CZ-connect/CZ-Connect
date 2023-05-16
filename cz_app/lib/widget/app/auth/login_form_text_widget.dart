import 'package:flutter/material.dart';

class LoginContainerTextWidget extends StatelessWidget {
  const LoginContainerTextWidget({Key? key}) : super(key: key);
  String get str => "Inloggen voor CZ-medewerkers";

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
