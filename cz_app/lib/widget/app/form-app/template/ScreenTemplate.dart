import 'package:flutter/material.dart';

// top level ScreenTemplate
class ScreenTemplate extends StatelessWidget {
  final String title;

  // container for the header
  final Widget header;

  //container for the body
  final Widget body;

  //the widget that gets changed in the tempalte
  final Widget? leading;

  const ScreenTemplate({
    Key? key,
    required this.title,
    required this.header,
    required this.body,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: leading,
        //leading logic if needed
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            header,
            Column(children: [
              body,
            ]),
          ],
        ),
      ),
    );
  }
}
