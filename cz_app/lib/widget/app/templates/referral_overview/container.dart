import 'package:flutter/material.dart';

class ReferralOverviewContainerWidget extends StatelessWidget {
  final Widget child;
  const ReferralOverviewContainerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white24),
        width: MediaQuery.of(context).size.width - 150,
        height: MediaQuery.of(context).size.height - 250,
        child: child,
      ),
    );
  }
}