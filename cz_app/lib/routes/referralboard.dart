import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cz_app/models/Referral.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Referral>> fetchReferrals() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/referrals/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return Referral.fromJson(jsonDecode(response.body));
    var referralObjsJson = jsonDecode(response.body)['data'] as List;
    List<Referral> referralObjs = referralObjsJson
        .map((referralJson) => Referral.fromJson(referralJson))
        .toList();
    return referralObjs;
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

List<Widget> getReferralsRowWidgetListList(List<Referral> referrals) {
  List<Widget> myList = [];
  myList.add(getReferralsRowWidgetList(referrals));
  return myList;
}

Widget getReferralsRowWidgetList(List<Referral> referrals) {
  return Column(
      children: referrals.map((item) => getReferralsRow(item)).toList());
}

Widget getReferralsRow(Referral referral) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(referral.status),
      Text(referral.participantName),
      Text(referral.participantEmail),
    ],
  );
}

class _ReferralWidgetState extends State<ReferralWidget> {
  late Future<List<Referral>> futureReferral;

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
            child: FutureBuilder<List<Referral>>(
          future: futureReferral,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                  children: getReferralsRowWidgetListList(snapshot.data!));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )),
      ),
    );
  }
}
