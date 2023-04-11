import 'package:cz_app/widget/app/referral_dashboard/partials/DashboardRow.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/ReferralStatus.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/UserRow.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ReferralDashboardIndexWidget());

class ReferralDashboardIndexWidget extends StatelessWidget {
  const ReferralDashboardIndexWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          Flexible(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Flexible(child: UserRow()),
                const Flexible(child: ReferralStatus()),
              ],
            ),
          ),
          Flexible(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Flexible(child: DashboardRow()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
