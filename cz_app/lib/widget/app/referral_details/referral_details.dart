import 'package:cz_app/widget/app/models/employee_referral.dart';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:cz_app/widget/app/referral_dashboard/services/delete_referral.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/employee.dart';
import 'services/reject_refferal.dart';
import 'services/accept_refferal.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferralDetailWidget extends StatefulWidget {
  final EmployeeReferralViewModel? employeeReferral;
  const ReferralDetailWidget({super.key, this.employeeReferral});

  @override
  State<ReferralDetailWidget> createState() => _ReferralDetailState();
}

class _ReferralDetailState extends State<ReferralDetailWidget> {
  @override
  Widget build(BuildContext context) {
    Referral? referral = widget.employeeReferral?.referral;
    Employee? employee = widget.employeeReferral?.employee;
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
                DataColumn(
                  label: Expanded(
                   child: Text(AppLocalizations.of(context)?.infoLabel ?? "",
                      key: Key('info'),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(referral?.participantName ?? ""),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(AppLocalizations.of(context)?.nameLabel ?? "")),
                    DataCell(Text(referral?.participantName ?? ""))
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(AppLocalizations.of(context)?.emailLabel ?? "")),
                    DataCell(Text(referral?.participantEmail ?? "-"))
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(AppLocalizations.of(context)?.phoneNumberLabel ?? "")),
                    DataCell(Text(referral?.participantPhoneNumber ?? "-"))
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    const DataCell(Text("Linkedin:")),
                    DataCell(Text(AppLocalizations.of(context)?.linkedinLabel ?? "")),
                    DataCell(
                      Text(referral?.linkedin ?? "-"),
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: referral?.linkedin ?? ""));
                        ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context)?.linkCopiedMessage ?? ""),
                        ));
                      },
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(AppLocalizations.of(context)?.statusLabel ?? "")),
                    DataCell(Text(referral?.translateStatus() ?? "")),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(AppLocalizations.of(context)?.dateLabel ?? "")),
                    DataCell(Text(DateFormat('d, MMM, yyyy')
                        .format(referral?.registrationDate ?? new DateTime(1992))))
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    const DataCell(Text("")),
                    DataCell(
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            child: Text(AppLocalizations.of(context)?.backToOverviewLabel ?? "",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onTap: () {
                            if (widget.employeeReferral?.employee != null) {
                              context.go("/referraldashboard", extra: employee);
                            } else {
                              context.go("/recruitmentdashboard");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 40.0),
                    child: ElevatedButton(
                      key: const Key('delete_referral_key'),
                      child: Text(AppLocalizations.of(context)?.deleteLabel ?? ""),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(AppLocalizations.of(context)?.deleteReferralTitle ?? ""),
                              content: Text(
                              AppLocalizations.of(context)?.deleteReferralConfirmation ?? ""),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                              actions: [
                                TextButton(
                                  child: Text(AppLocalizations.of(context)?.cancelLabel ?? ""),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: Text(AppLocalizations.of(context)?.deleteLabel ?? ""),
                                  onPressed: () {
                                    deleteReferral(context, referral?.id ?? 0);
                                    if (widget.employeeReferral?.employee !=
                                        null) {
                                      context.go("/referraldashboard",
                                          extra: employee);
                                    } else {
                                      context.go("/recruitmentdashboard");
                                    }
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  if (referral?.status == "Pending") ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: ElevatedButton(
                        key: const Key('reject_key'),
                        onPressed: () {
                          setState(
                            () {
                              referral?.status = "Denied";
                              rejectRefferal(context, referral);
                            },
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:Text(AppLocalizations.of(context)?.rejectReferralMessage ?? ""),
                              ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)?.rejectLabel ?? ""),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: ElevatedButton(
                        key: const Key('approved_key'),
                        onPressed: () {
                          setState(
                            () {
                              referral?.status = "Approved";
                              acceptReffal(context, referral);
                            },
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)?.approveReferralMessage ?? ""),
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)?.approveLabel ?? ""),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
