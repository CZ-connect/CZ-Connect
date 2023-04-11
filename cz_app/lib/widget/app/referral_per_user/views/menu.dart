import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('CZConnect'), centerTitle: true),
        body: ListView(children: [
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/loading');
            },
            child: const Text('Referrals overzicht'),
          )
        ]));
  }
}
