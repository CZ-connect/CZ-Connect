import 'package:flutter/material.dart';

class ReferralIndexTopWidget extends StatelessWidget {
  const ReferralIndexTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.red),
        width: double.maxFinite,
        height: 75.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("CZ-Connect"),
          ],
        ),
      ),
    );
  }
}
