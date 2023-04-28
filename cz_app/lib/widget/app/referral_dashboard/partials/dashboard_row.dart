import 'package:go_router/go_router.dart';

import '../../models/referral.dart' show Referral;
import 'package:flutter/material.dart';
import 'package:cz_app/widget/app/referral_dashboard/data/referral_data.dart';

class DashboardRow extends StatefulWidget {
  const DashboardRow({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardRow();
}

class _DashboardRow extends State<DashboardRow> {
  late Future<List<Referral>> referrals;

  @override
  void initState() {
    referrals = ReferralData().fetchReferrals();
    super.initState();
  }

  void reloadData() {
    referrals = ReferralData().fetchReferrals();
  }

  final referralRowPhoto = Container(
    width: 70,
    height: 70,
    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    child: Image.asset(
      'assets/images/profile_placeholder.png',
      width: 70,
      height: 70,
    ),
  );

  DataRow getReferralsRow(Referral referral) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) => Colors.white24),
      cells: <DataCell>[
        DataCell(
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: Text(
                referral.participantName,
                style: const TextStyle(color: Colors.blueAccent),
              ),
              onTap: () {
                context.go("/referraldetail",
                    extra: referral);
              },
            ),
          ),
        ),
        DataCell(Text(referral.participantEmail ?? "-")),
        DataCell(Text(referral.participantPhoneNumber ?? "-")),
        DataCell(Text(referral.status)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Referral>>(
      future: referrals,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: DataTable(
                    showCheckboxColumn: false,
                    headingRowColor:
                        MaterialStateColor.resolveWith((states) => Colors.white24),
                    // ignore: prefer_const_literals_to_create_immutables
                    columns: <DataColumn>[
                      const DataColumn(
                        label: Expanded(child: Text("Naam sollicitant")),
                      ),
                      const DataColumn(
                        label: Expanded(child: Text("Email")),
                      ),
                      const DataColumn(
                        label: Expanded(child: Text("Telefoonnummer")),
                      ),
                      const DataColumn(
                        label: Expanded(child: Text("Status")),
                      ),
                    ],
                    rows: snapshot.data!.map<DataRow>(
                      (referral) {
                        return getReferralsRow(referral);
                      },
                    ).toList(),
                  ),
                ),
              ],
            );
          } else {
            return const Text('No data found!');
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
