import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        appBar:
            AppBar(title: const Text('Referral Overzicht'), centerTitle: true),
        key: const Key('referral_overview'),
        body: ListView(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ),
        //extract it so that it is accessible in two places
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here)!
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Title"),
                  content: Text("Content"),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text("Kopiëer de link"),
                      onPressed:  () async {
                        const link = "https://www.example.com";
                        await Clipboard.setData(ClipboardData(text: link));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Link gekopieerd!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    ),
                  ],
                );
              },
            );

          },
          label: const Text('Deel je link'),
          icon: const Icon(Icons.share_outlined),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else {
      return Scaffold(
        appBar:
            AppBar(title: const Text('Referral Overzicht'), centerTitle: true),
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
