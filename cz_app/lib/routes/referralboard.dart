import 'dart:async';
import 'dart:convert';

import 'package:cz_app/models/Referral.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cz_app/widget/Dashboard/FilterRow.dart';
import 'package:cz_app/widget/Dashboard/ReferralDashboard.dart';
import 'package:cz_app/widget/Dashboard/ReferralStatus.dart';
import 'package:cz_app/widget/Dashboard/UserRow.dart';

Future<List<Referral>> fetchReferrals() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/referrals/'));

  if (response.statusCode == 200) {
    var referralObjsJson = jsonDecode(response.body)['data'] as List;
    List<Referral> referralObjs = referralObjsJson
        .map((referralJson) => Referral.fromJson(referralJson))
        .toList();
    return referralObjs;
  } else {
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
  late Future<List<Referral>> futureReferral;

  @override
  void initState() {
    super.initState();
    futureReferral = fetchReferrals();
  }

  Widget getReferralsRowWidgetList(List<Referral> referrals) {
    return Column(
        children: referrals.map((item) => getReferralsRow(item)).toList());
  }

  final referralRowPhoto = Container(
      width: 70,
      height: 70,
      decoration:
          const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: Image.asset(
        './images/stadscafe.png',
        width: 70,
        height: 70,
      ));

  Widget referralRowButton() {
    return const TextButton(onPressed: onPressed, child: Text("KLIK MIJ"));
  }

  Widget referralRowButtonContainer() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: referralRowButton(),
    );
  }

  Widget getReferralsRow(Referral referral) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        referralRowPhoto,
        Text(referral.status),
        Text(referral.participantName),
        Text(referral.participantEmail),
        referralRowButtonContainer()
      ],
    );
  }

  Widget getFutureBuilder() {
    return FutureBuilder<List<Referral>>(
      future: futureReferral,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(children: referralDashBoard(snapshot.data!));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget referralContainerRow(Referral referral) {
    return Container(
      decoration: const BoxDecoration(color: Colors.grey),
      child: getReferralsRow(referral),
    );
  }

  List<Widget> referralDashBoard(List<Referral> referrals) {
    return [
      FractionallySizedBox(
        widthFactor: 1.0,
        alignment: FractionalOffset.center,
        child: DecoratedBox(
          decoration:
              BoxDecoration(border: Border.all(width: 2), color: Colors.grey),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // ignore: prefer_const_literals_to_create_immutables
            children: [getReferralsRowWidgetList(referrals)],
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CZ-Connect',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CZ-Connect'),
        ),
        body: SizedBox.expand(
          child: Column(
            children: [
              Flexible(
                child: Row(
                  children: const [
                    Flexible(child: UserRow()),
                    Flexible(child: ReferralStatus()),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  children: const [
                    Flexible(child: FilterRow()),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  children: [
                    Flexible(child: getFutureBuilder()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
