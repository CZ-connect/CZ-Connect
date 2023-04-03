import 'package:flutter/material.dart';

class ReferralDetailTopWidget extends StatelessWidget {
  const ReferralDetailTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.red),
        width: double.maxFinite,
        height: 50.0,
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
