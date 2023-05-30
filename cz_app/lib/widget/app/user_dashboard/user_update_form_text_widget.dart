import 'package:flutter/material.dart';

class UserUpdateContainerTextWidget extends StatelessWidget {
  const UserUpdateContainerTextWidget({Key? key}) : super(key: key);
  String get str => "Gebruiker aanpassen";

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
