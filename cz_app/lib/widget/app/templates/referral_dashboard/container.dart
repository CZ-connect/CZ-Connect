import 'package:flutter/material.dart';

class ReferralDashboardContainerWidget extends StatelessWidget {
  final Widget child;
  const ReferralDashboardContainerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white24),
        width: MediaQuery.of(context).size.width - 350,
        height: MediaQuery.of(context).size.height,
        child: child,
      ),
    );
  }
}
