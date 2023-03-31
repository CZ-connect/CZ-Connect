import 'package:cz_app/widget/app/form-app/appMainContainer.dart';
import 'package:cz_app/widget/app/form-app/bottemAppLayout.dart';
import 'package:cz_app/widget/app/form-app/form/storeInput.dart';
import 'package:cz_app/widget/app/form-app/template/ScreenTemplate.dart';
import 'package:cz_app/widget/app/form-app/topAppLayout.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CZ_connect',
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
              body: ScreenTemplate(
                title: 'formulier voor een open solicatie',
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
