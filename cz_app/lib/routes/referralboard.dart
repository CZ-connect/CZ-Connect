import 'dart:async';
import 'dart:convert';

import 'package:cz_app/models/Referral.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Referral> fetchReferrals() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/album/3'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Referral.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Referral');
  }
}

void main() => runApp(const ReferralWidget());

class ReferralWidget extends StatefulWidget {
  const ReferralWidget({super.key});

  @override
  State<ReferralWidget> createState() => _ReferralWidgetState();
}

class _ReferralWidgetState extends State<ReferralWidget> {
  late Future<Referral> futureReferral;

  @override
  void initState() {
    super.initState();
    futureReferral = fetchReferrals();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Referral>(
            future: futureReferral,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                    'Id: ${snapshot.data!.id} Name: ${snapshot.data!.participantName} Date: ${snapshot.data!.registrationDate}');
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
