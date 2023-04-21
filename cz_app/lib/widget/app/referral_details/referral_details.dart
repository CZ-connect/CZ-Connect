import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const ReferralDetailWidget());

class ReferralDetailWidget extends StatelessWidget {
  const ReferralDetailWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final Referral? referral;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      referral = ModalRoute.of(context)?.settings.arguments as Referral;
    } else {
      referral = null;
    }

    if (referral != null) {
      return SizedBox.expand(
        key: const Key("referral_details"),
        child: Column(
          children: [
            FractionallySizedBox(
              alignment: Alignment.topCenter,
              widthFactor: 1.0,
              child: DataTable(
                showCheckboxColumn: false,
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.white12),
                columns: <DataColumn>[
                  const DataColumn(
                    label: Expanded(
                      child: Text(
                        "Informatie over:",
                        key: Key('info'),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(referral.participantName),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text("Naam:")),
                      DataCell(Text(referral.participantName))
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text("Email:")),
                      DataCell(Text(referral.participantEmail ?? "-"))
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text("Telefoonnummer:")),
                      DataCell(Text(referral.participantPhoneNumber ?? "-"))
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text("Status:")),
                      DataCell(Text(referral.status))
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text("Datum:")),
                      DataCell(Text(DateFormat('d, MMM, yyyy')
                          .format(referral.registrationDate)))
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text("")),
                      DataCell(
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            child: const Text(
                              "Terug naar overzicht",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/referraldashboard");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox.expand(
        key: const Key("referral_details"),
        child: Column(
          children: [
            const Text("No data found"),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: const Text(
                  "Terug naar overzicht",
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/referraldashboard");
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
