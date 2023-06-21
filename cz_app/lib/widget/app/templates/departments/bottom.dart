import 'package:flutter/material.dart';

class DepartmentBottomWidget extends StatelessWidget {
  final Widget child;

  const DepartmentBottomWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white24),
        margin: const EdgeInsets.all(15.0),
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        child: child,
      ),
    );
  }
}
