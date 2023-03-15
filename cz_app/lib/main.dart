import 'package:cz_app/widget/app/app-template/appBackground.dart';
import 'package:cz_app/widget/app/formTextWidget.dart';
import 'package:cz_app/widget/app/storeInput.dart';
import 'package:cz_app/widget/app/views/referralOverview.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CZ_connect',
      home: Scaffold(
        body: ReferralOverview()
      ),
    );
  }
}
