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
    if (data != null) {
      return Scaffold(
        key: const Key('referral_overview'),
        body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                      children: [
                        for (var referral in data?['referrals'])
                          Card(
                            margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                            color: Colors.white24,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'Referral voor ${referral.participantName}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                referral.status,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                   Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                'Opgegeven E-mail: ${referral.participantEmail}'
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                'Datum opgeving: ${DateFormat('dd-MM-yyyy').format(referral.registrationDate)}'
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
       appBar: null,
        key: const Key('referral_overview'),
        body: ListView(
          children: const [
            Text('No data found.'),
          ],
        ),
      );
    }
  }
}