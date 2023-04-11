import 'package:flutter/material.dart';

class ReferralDashboardBottomWidget extends StatelessWidget {
  final Widget child;
  const ReferralDashboardBottomWidget({Key? key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white24),
        margin: const EdgeInsets.all(15.0),
        width: double.maxFinite,
        child: child,
      ),
    );
  }
}
