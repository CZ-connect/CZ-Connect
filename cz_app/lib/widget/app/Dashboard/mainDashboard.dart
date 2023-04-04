import 'package:flutter/material.dart';
import 'UserRow.dart';
import 'ReferralStatus.dart';
import 'DashboardRow.dart';

void main() => runApp(const OverViewWidget());

class OverViewWidget extends StatelessWidget {
  const OverViewWidget({super.key});

  static const String _title = 'CZ-Connect';

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
          child: const _OverViewWidget(),
        ),
      ),
    );
  }
}

class _OverViewWidget extends StatelessWidget {
  const _OverViewWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          Flexible(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Flexible(child: UserRow()),
                const Flexible(child: ReferralStatus()),
              ],
            ),
          ),
          Flexible(
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Flexible(child: DashboardRow()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
