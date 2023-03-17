import 'dart:async';

import 'package:cz_app/widget/app/app-template/bottemAppLayout.dart';
import 'package:cz_app/widget/app/app-template/topAppLayout.dart';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';

class ReferralOverview extends StatefulWidget {
  @override
  State<ReferralOverview> createState() => _ReferralOverviewState();
}

class _ReferralOverviewState extends State<ReferralOverview> {
  @override
  Widget build(BuildContext context) {
    var arr = [
      Referral(
          id: 1,
          status: "Aangemeld",
          participantName: "Jos Jos",
          participantEmail: "jos@jos.nl",
          registrationDate: DateTime.now()
      ),
      Referral(
          id: 2,
          status: "Aangemeld",
          participantName: "Kjoen Kjoen",
          participantEmail: "kjoen@kjoen.nl",
          registrationDate: DateTime.now()
      ),
      Referral(
          id: 3,
          status: "Aangemeld",
          participantName: "Marijn Marijn",
          participantEmail: "marijn@marijn.nl",
          registrationDate: DateTime.now(),
      )
    ];
    return Scaffold(
        appBar:
            AppBar(title: const Text('Referral Overzicht'), centerTitle: true),
        body: ListView(
          children: [
            for (var referral in arr)
              Card(
                  margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  color: Colors.white24,
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        Row(
                          children: [
                            Expanded(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                  Text(
                                      'Referral voor ${referral.participantName}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(referral.status,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ])),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                  Text(
                                      'Opgegeven E-mail: ${referral.participantEmail}'),
                                  Text('Datum opgeving: ${DateFormat('dd-MM-yyyy').format(referral.registrationDate)}'),
                                ])),
                          ],
                        ),
                      ])))
          ],
        ));

  }
  Future<void> _pullRefresh() async {
    await fetchData();
    setState(() {
    });
  }
  Future<void> fetchData() =>
      // Imagine that this function is
  // more complex and slow.
  Future.delayed(
    const Duration(seconds: 1), () => print("getting data"),
  );
}

