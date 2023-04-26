import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'services/reject_refferal.dart';
import 'services/accept_refferal.dart';

class ReferralDetailWidget extends StatefulWidget {
  final Referral? referral;
  const ReferralDetailWidget({super.key, this.referral});

  @override
  State<ReferralDetailWidget> createState() => _ReferralDetailState();
}

class _ReferralDetailState extends State<ReferralDetailWidget> {
  @override
  Widget build(BuildContext context) {

    if (widget.referral != null) {
      Referral referral = widget.referral!;
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
                              context.go("/referraldashboard");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (referral.status == "Pending")
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: ElevatedButton(
                          key: const Key('reject_key'),
                          onPressed: () {
                            setState(() {
                              referral?.status = "Denied";
                              rejectRefferal(context, referral);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Referral afkeuren'),
                              ),
                            );
                          },
                          child: const Text("Afkeuren"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: ElevatedButton(
                          key: const Key('approved_key'),
                          onPressed: () {
                            setState(() {
                              referral?.status = "Approved";
                              acceptReffal(context, referral);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Referral goedkeuren'),
                              ),
                            );
                          },
                          child: const Text("Goedkeuren"),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
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
                  context.go("/referraldashboard");
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
