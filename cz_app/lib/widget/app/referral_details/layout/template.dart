import 'package:flutter/material.dart';

// top level ScreenTemplate
class ReferralDetailTemplate extends StatelessWidget {
  // container for the header
  final Widget header;

  //container for the body
  final Widget body;

  //the widget that gets changed in the tempalte
  final Widget? leading;

  const ReferralDetailTemplate({
    Key? key,
    required this.header,
    required this.body,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
