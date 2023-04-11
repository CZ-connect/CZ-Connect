import 'package:flutter/material.dart';

import 'appMainContainer.dart';

class bottemAppWidget extends StatelessWidget {
  final Widget child;
  const bottemAppWidget({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
          ),
          color: Colors.white24),
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: child,
    );
  }
}
