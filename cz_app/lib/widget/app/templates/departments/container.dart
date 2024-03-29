import 'package:flutter/material.dart';

class DepartmentContainerWidget extends StatelessWidget {
  final Widget child;

  const DepartmentContainerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white24),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width - 350,
        child: child,
      ),
    );
  }
}
