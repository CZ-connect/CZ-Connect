import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:flutter/material.dart';

class ReferralIndexContainerWidget extends StatelessWidget {
  final Widget child;
  const ReferralIndexContainerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white60),
        width: MediaQuery.of(context).size.width - 350,
        height: MediaQuery.of(context).size.height - 250,
        child: const OverViewWidget(),
      ),
    );
  }
}
