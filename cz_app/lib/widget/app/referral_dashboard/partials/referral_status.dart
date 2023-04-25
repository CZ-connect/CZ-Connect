import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
import 'package:flutter/material.dart';
import 'package:cz_app/widget/app/referral_dashboard/data/referral_data.dart';

class ReferralStatus extends StatefulWidget {
  const ReferralStatus({super.key});

  @override
  State<StatefulWidget> createState() => _ReferralStatus();
}

class _ReferralStatus extends State<ReferralStatus> {
  @override
  Widget build(BuildContext context) {
    final Employee? employee;
    late Future<int> completedCounter;
    late Future<int> pendingCounter;

    if (ModalRoute.of(context)?.settings.arguments != null) {
      employee = ModalRoute.of(context)?.settings.arguments as Employee;
      completedCounter = ReferralData().completedCounter(employee.id);
      pendingCounter = ReferralData().pendingCounter(employee.id);
    } else {
      employee = null;
      completedCounter = ReferralData()
          .completedCounter(2); // TO-DO CHANGE 2 TO LOGGED IN USER
      pendingCounter =
          ReferralData().pendingCounter(2); // TO-DO CHANGE 2 TO LOGGED IN USER
    }

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
                child: Column(children: [
              Expanded(child: referralCompleted),
              const Text('Goedgekeurd')
            ])),
            Expanded(
                child: Column(children: [
              Expanded(child: referralPending),
              const Text('In Afwachting')
            ])),
          ],
        ),
      ),
    );
  }
}
