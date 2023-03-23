import 'package:cz_app/widget/Dashboard/mainDashboard.dart';
import 'package:cz_app/widget/app/form-app//appBackground.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CZ_connect',
      initialRoute: '/',
      routes: {
        '/dashboard': (context) => const OverViewWidget(),
        '/': (context) => Scaffold(
              body: backgroundWidget(),
            ),
      },
    );
  }
}
