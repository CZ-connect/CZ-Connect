import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/dashboard_row.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/user_row.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/referral_status.dart';
import 'package:flutter/material.dart';

class ReferralDashboardIndexWidget extends StatelessWidget {
  final Employee? employee;
  const ReferralDashboardIndexWidget({super.key, this.employee});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          Flexible(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Flexible(child: UserRow(employee: employee)),
                Flexible(child: ReferralStatus(employee: employee)),
              ],
            ),
          ),
          Flexible(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Flexible(child: DashboardRow(employee: employee)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
