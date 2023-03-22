import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:
        AppBar(title: const Text('CZConnect'), centerTitle: true),
    body: ListView(
    children: [
    TextButton(
    style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    ),
    onPressed: () {  Navigator.pushNamed(context, '/loading'); },
    child: Text('Refferals overzicht'),
    )
    ]));
    }
}
