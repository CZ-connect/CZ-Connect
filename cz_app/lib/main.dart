import 'package:flutter/material.dart';
import 'widget/dashboard/UserRow.dart';
import 'widget/dashboard/FilterRow.dart';
import 'widget/dashboard/ReferralStatus.dart';
import 'widget/dashboard/ReferralDashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'CZ-Connect';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Container(
          margin: const EdgeInsets.only(left: 150.0, right: 150.0),
          child: const OverViewWidget(),
        ),
      ),
    );
  }
}

class OverViewWidget extends StatelessWidget {
  const OverViewWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          Flexible(
            child: Row(
              children: [
                Flexible(child: UserRow()),
                Flexible(child: ReferralStatus()),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Flexible(child: FilterRow()),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Flexible(child: ReferralDashBoard()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
