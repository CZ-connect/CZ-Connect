import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:cz_app/widget/app/referral_dashboard/data/referral_data.dart';
import 'package:go_router/go_router.dart';

class ReferralStatus extends StatefulWidget {
  final Employee? employee;
  const ReferralStatus({super.key, this.employee});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _ReferralStatus();
}

class _ReferralStatus extends State<ReferralStatus> {
  late Future<int> completedCounter;
  late Future<int> pendingCounter;

  void setupReference() async {
    try {
      if (widget.employee == null) {
        completedCounter = ReferralData().completedCounter(
            UserPreferences.getUserId()); // TO-DO CHANGE 2 TO LOGGED IN USER
        pendingCounter = ReferralData().pendingCounter(
            UserPreferences.getUserId()); // TO-DO CHANGE 2 TO LOGGED IN USER
      } else {
        completedCounter = ReferralData().completedCounter(widget.employee!.id);
        pendingCounter = ReferralData().pendingCounter(widget.employee!.id);
      }
    } catch (e) {
      context.go(Uri(path: '/error').toString(),
          extra: {'message': 'Aandrachten inladen mislukt.'});
    }
  }

  @override
  void initState() {
    setupReference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final referralCompleted = Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          border: Border.all(width: 2),
          shape: BoxShape.circle,
          color: Colors.redAccent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: completedCounter,
            builder: (context, snapshot) {
              return Text("${snapshot.data}");
            },
          ),
        ],
      ),
    );

    final referralPending = Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          border: Border.all(width: 2),
          shape: BoxShape.circle,
          color: Colors.redAccent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: pendingCounter,
            builder: (context, snapshot) {
              return Text("${snapshot.data}");
            },
          ),
        ],
      ),
    );

    return FractionallySizedBox(
      widthFactor: 1.0,
      heightFactor: 0.3,
      alignment: FractionalOffset.center,
      child: DecoratedBox(
        decoration:
            BoxDecoration(border: Border.all(width: 2), color: Colors.white24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(child: referralCompleted),
                  const Text('Goedgekeurd')
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: referralPending),
                  const Text('In Afwachting')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
