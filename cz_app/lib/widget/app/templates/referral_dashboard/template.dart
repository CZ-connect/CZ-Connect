import 'package:flutter/material.dart';

// top level ScreenTemplate
class ReferralDashboardTemplate extends StatelessWidget {
  // container for the header
  final Widget header;

  //container for the body
  final Widget body;

  //the widget that gets changed in the tempalte
  final Widget? leading;

  const ReferralDashboardTemplate({
    Key? key,
    required this.header,
    required this.body,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: Column(
          children: [ // margin top of 20 pixels
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
