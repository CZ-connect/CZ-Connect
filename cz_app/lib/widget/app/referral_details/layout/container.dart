import 'package:cz_app/widget/app/referral_details/referral_details.dart';
import 'package:flutter/material.dart';

class ReferralDetailContainerWidget extends StatelessWidget {
  final Widget child;
  const ReferralDetailContainerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white60),
        width: MediaQuery.of(context).size.width - 350,
        height: MediaQuery.of(context).size.height - 250,
        child: const ReferralDetailWidget(),
      ),
    );
  }
}
