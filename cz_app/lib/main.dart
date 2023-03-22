import 'package:cz_app/widget/app/views/loading.dart';
import 'package:cz_app/widget/app/views/referralOverview.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingWidget(),
        '/referralOverview': (context) => ReferralOverview()
        },
    );
  }
}
