
import 'package:cz_app/widget/app/form-app//appBackground.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CZ_connect',
      home: Scaffold(
        body: backgroundWidget(),
      ),

    );
  }
}
