import 'dart:convert';
import 'package:http/http.dart' as http;
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
                      const Divider(),
                        referral.status.toString() != "Approved" && referral.status.toString() != "Denied"
                          ? Row(
                              children: [
                                  Expanded(
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                              Flexible(
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                            referral.status = "Denied";
                                                        });
                                                        rejectRefferal(context, referral);
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          const SnackBar(content: Text('Referral afkeuren')),
                                                        );
                                                      },
                                                      child: const Text("Afkeuren"),
                                                  ),
                                              ),
                                          ],
                                      ),
                                  ),
                                ],
                            )
                            : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
          ],
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
Future<void> rejectRefferal(BuildContext context, dynamic referral) async {
    var id = referral.id;
    var url = Uri.http('localhost:3000', '/api/referral/individual/$id');
    referral.status = "Afgekeurd";

    Map<String, dynamic> jsonMap = {
      'id': referral.id.toString(),
      'participantName': referral.participantName.toString(),
      'participantEmail': referral.participantEmail.toString(),
      'status': referral.status.toString(),
      'registrationDate': referral.registrationDate.toString(),
      'employeeId': 1,
      'employee': null
    };

    var body = json.encode(jsonMap);

    try {
      var response = await http.put(url, 
      headers: {"Content-Type": "application/json"}, body: body);

     if (response.statusCode >= 400 && response.statusCode <= 499) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Client error: ${response.statusCode}')),
        );
         throw Exception('Client error: ${response.statusCode}');
     } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
        throw Exception('Server error: ${response.statusCode}'); 
      }
    } catch (exception) {}
  }