import 'package:flutter/material.dart';
import '../navigation_menu.dart';

// top level ScreenTemplate
class DepartmentTemplate extends StatelessWidget {
  // container for the header
  final Widget header;

  //container for the body
  final Widget body;

  //the widget that gets changed in the tempalte
  final Widget? leading;

  const DepartmentTemplate({
    Key? key,
    required this.header,
    required this.body,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationMenu(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
      ),
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // margin top of 20 pixels
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
