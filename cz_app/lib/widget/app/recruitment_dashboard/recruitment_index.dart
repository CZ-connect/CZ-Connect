import 'package:cz_app/widget/app/recruitment_dashboard/partials/dashboard_row.dart';
import 'package:flutter/material.dart';

void main() => runApp(const RecruitmentDashboardIndexWidget());

class RecruitmentDashboardIndexWidget extends StatelessWidget {
  const RecruitmentDashboardIndexWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
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
