import 'package:cz_app/widget/app/app-template/bottemAppLayout.dart';
import 'package:cz_app/widget/app/app-template/topAppLayout.dart';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter/material.dart';

import '../app-template/appBackground.dart';

class ReferralOverview extends StatelessWidget {
  @override


  Widget build(BuildContext context) {

    var arr = [
      Referral(id: 1, status: "Aangemeld", participantName: "Jos Jos", reimbursable: true, participantEmail: "jos@jos.nl"),
      Referral(id: 2, status: "Aangemeld", participantName: "Kjoen Kjoen", reimbursable: false, participantEmail: "kjoen@kjoen.nl"),
      Referral(id: 3, status: "Aangemeld", participantName: "Marijn Marijn", reimbursable: true, participantEmail: "marijn@marijn.nl")
    ];
    return Column(
      children: [
        for(var referral in arr )
          Card(
              margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            color: Colors.orangeAccent,
               child: Padding(
                   padding: const EdgeInsets.all(12.0),
               child:Column(
                 children: [
                   Row(
               children: [
                     Text('Naam ${referral.participantName}'),
                     Text('Email ${referral.participantEmail}'),
                   ]),
                   Row(
                       children: [
                         Text('Status ${referral.status}'),
                         Text('Recht op vergoeding ${referral.reimbursable}'),
                       ])
                 ],
               )
          )
          )
      ],
    );

    }
  }

