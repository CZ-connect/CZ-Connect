import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:cz_app/widget/app/services/referralService.dart';

class LoadingWidget extends StatefulWidget {
  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}
class _LoadingWidgetState extends State<LoadingWidget> {

  void setupReference() async {
   Referral instance = Referral(userId: 1);
   await instance.getData();
   // ignore: use_build_context_synchronously
   Navigator.pushReplacementNamed(context, '/referralOverview', arguments: {
     'referrals': instance.Refferals
   });
  }

  @override
  void initState() {
    super.initState();
    setupReference();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(padding: EdgeInsets.all(50.0),
      child: Text("Ophalen van gegevens..."),),
    );
  }
}
