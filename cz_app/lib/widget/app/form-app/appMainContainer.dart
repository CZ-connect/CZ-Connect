import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'form/storeInput.dart';

class appMainContainer extends StatelessWidget {
  final Widget child;
  const appMainContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        margin: const EdgeInsets.only(top: 50),
        width:  MediaQuery
            .of(context)
            .size
            .width - 100,
        height: MediaQuery
            .of(context)
            .size
            .height - 250,
        child: formWidget(),
      ),

    );
  }
}