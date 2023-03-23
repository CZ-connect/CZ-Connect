import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReferralOverview extends StatefulWidget {
  const ReferralOverview({super.key});

  @override
  State<ReferralOverview> createState() => _ReferralOverviewState();
}

class _ReferralOverviewState extends State<ReferralOverview> {
  Map? data = {};

  @override
  Widget build(BuildContext context) {
    data = (data?.isNotEmpty ?? false)
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map?;

    return Scaffold(
        appBar:
            AppBar(title: const Text('Referral Overzicht'), centerTitle: true),
        body: ListView(
          children: [
            for (var referral in data?['referrals'])
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
                                  Text(
                                      'Datum opgeving: ${DateFormat('dd-MM-yyyy').format(referral.registrationDate)}'),
                                ])),
                          ],
                        ),
                      ])))
          ],
        ));
  }
}
