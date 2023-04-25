import 'package:cz_app/widget/app/models/employee.dart';

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
    referrals = ReferralData().fetchReferrals(2);
    super.initState();
  }

  final referralRowPhoto = Container(
    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    child: Image.asset(
      'assets/images/profile_placeholder.png',
      width: 70,
      height: 50,
    ),
  );

  List<DataRow> buildRows(List<Referral> referrals) {
    return List.generate(referrals.length, (index) {
      final color = index % 2 == 0 ? Colors.grey[300] : Colors.white;
      return DataRow(
        color: MaterialStateProperty.all<Color>(color!),
        cells: <DataCell>[
          DataCell(referralRowPhoto),
          DataCell(Text(referrals[index].status)),
          DataCell(
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: Text(
                  referrals[index].participantName,
                  style: const TextStyle(color: Colors.blueAccent),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/referraldetail",
                      arguments: referrals[index]);
                },
              ),
            ),
          ),
          DataCell(Text(referrals[index].participantEmail)),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Employee? employee;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      employee = ModalRoute.of(context)?.settings.arguments as Employee;
      referrals = ReferralData().fetchReferrals(employee.id);
    } else {
      referrals = ReferralData().fetchReferrals(2);
    }
    return FutureBuilder<List<Referral>>(
      future: referrals,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<Referral> referrals = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  columnSpacing: 100,
                  dataRowHeight: 75,
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.grey),
                  // ignore: prefer_const_literals_to_create_immutables
                  columns: <DataColumn>[
                    const DataColumn(
                      label: Expanded(child: Text("")),
                    ),
                    const DataColumn(
                      label: Expanded(child: Text("Status")),
                    ),
                    const DataColumn(
                      label: Expanded(child: Text("Naam sollicitant")),
                    ),
                    const DataColumn(
                      label: Expanded(child: Text("Email sollicitant")),
                    ),
                  ],
                  rows: buildRows(referrals),
                ),
              ),
            );
          } else {
            return const Text("No data found.");
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
