import 'package:cz_app/widget/app/Dashboard/mainDashboard.dart';
import 'package:cz_app/widget/app/app-template/topAppLayout.dart';
import 'package:cz_app/widget/app/views/error.dart';
import 'package:cz_app/widget/app/views/loading.dart';
import 'package:cz_app/widget/app/views/menu.dart';
import 'package:cz_app/widget/app/views/referralOverview.dart';
import 'package:cz_app/widget/app/form-app/appMainContainer.dart';
import 'package:cz_app/widget/app/form-app/bottemAppLayout.dart';
import 'package:cz_app/widget/app/form-app/form/storeInput.dart';
import 'package:cz_app/widget/app/form-app/template/ScreenTemplate.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/referraldashboard': (context) => const OverViewWidget(),
        '/loading': (context) => const LoadingWidget(),
        '/referralMenu': (context) => const Menu(),
        '/referralOverview': (context) => const ReferralOverview(),
        '/error': (context) => const ErrorScreen(),
        '/': (context) => Scaffold(
              body: ScreenTemplate(
                header: topAppWidget(),
                body: bottemAppWidget(
                    child: appMainContainer(
                  child: formWidget(),
                )),
              ),
            ),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
