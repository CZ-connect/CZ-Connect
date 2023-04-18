import 'package:flutter/material.dart';

class AppMainContainer extends StatelessWidget {
  final Widget child;
  const AppMainContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        margin: const EdgeInsets.only(top: 50),
        width: MediaQuery.of(context).size.width - 100,
        height: MediaQuery.of(context).size.height - 250,
        child: child,
      ),
    );
  }
}
