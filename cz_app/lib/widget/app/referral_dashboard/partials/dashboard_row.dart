import 'package:cz_app/widget/app/models/employee_referral.dart';
import 'package:go_router/go_router.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import '../../models/referral.dart' show Referral;
import 'package:flutter/material.dart';
import 'package:cz_app/widget/app/referral_dashboard/data/referral_data.dart';

class DashboardRow extends StatefulWidget {
  final Employee? employee;
  const DashboardRow({super.key, this.employee});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _DashboardRow();
}

class _DashboardRow extends State<DashboardRow> {
  late Future<List<Referral>> referrals;

  @override
  void initState() {
    if (widget.employee != null) {
      referrals = ReferralData().fetchReferrals(widget.employee!.id);
    } else {
      referrals = ReferralData().fetchReferrals(2);
    }
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
                  context.go("/referraldetail", extra: EmployeeReferralViewModel(widget.employee, referrals[index]));
                },
              ),
            ),
          ),
          DataCell(Text(referrals[index].participantEmail ?? "-")),
          DataCell(Text(referrals[index].participantPhoneNumber ?? "-")),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  key: const Key('dashboard_table'),
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
                    const DataColumn(
                      label:
                          Expanded(child: Text("Telefoonnummer")),
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
