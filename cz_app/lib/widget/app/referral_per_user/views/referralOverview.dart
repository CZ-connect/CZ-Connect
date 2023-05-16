import 'package:cz_app/widget/app/models/referral.dart';
import 'package:cz_app/widget/app/referral_per_user/views/ReferralLinkShareButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReferralOverview extends StatefulWidget {
  final List<Referral> referrals;
  const ReferralOverview({super.key, required this.referrals});

  @override
  State<ReferralOverview> createState() => _ReferralOverviewState();
}

class _ReferralOverviewState extends State<ReferralOverview> {
  @override
  Widget build(BuildContext context) {
    if (!widget.referrals.isEmpty) {
      return Scaffold(
          appBar: null,
          key: const Key('referral_overview'),
          body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                children: [
                  for (var referral in widget.referrals!)
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Referral voor ${referral.participantName}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          referral.status,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                            'Opgegeven E-mail: ${referral.participantEmail}'),
                                      ),
                                      Flexible(
                                        child: Text(
                                            'Datum opgeving: ${DateFormat('dd-MM-yyyy').format(referral.registrationDate)}'),
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
              )),
          //extract it so that it is accessible in two places
          floatingActionButton: const ReferralLinkShareButton());
    } else {
      return Scaffold(
          appBar: null,
          key: const Key('referral_overview'),
        body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
          child:Padding(
              padding: const EdgeInsets.all(50.0),
              child: Center(child: Text('Geen gegevens gevonden')),
            )),

          floatingActionButton: const ReferralLinkShareButton());
    }
  }
}
