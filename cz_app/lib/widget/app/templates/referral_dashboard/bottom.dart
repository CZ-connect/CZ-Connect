import 'package:flutter/material.dart';

class ReferralDashboardBottomWidget extends StatelessWidget {
  final Widget child;
  const ReferralDashboardBottomWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white60),
        width: double.maxFinite,
        child: child,
      ),
    );
  }
}
