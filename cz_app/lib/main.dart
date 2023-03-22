import 'package:cz_app/widget/app/app-template/appBackground.dart';
import 'package:cz_app/widget/app/formTextWidget.dart';
import 'package:cz_app/widget/app/storeInput.dart';
import 'package:cz_app/widget/app/views/error.dart';
import 'package:cz_app/widget/app/views/loading.dart';
import 'package:cz_app/widget/app/views/menu.dart';
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
        '/': (context) => Menu(),
        '/loading': (context) => LoadingWidget(),
        '/referralOverview': (context) => ReferralOverview(),
        '/error': (context) => GenericError()
        },
    );
  }
}
