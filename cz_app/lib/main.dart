import 'package:flutter/material.dart';
import 'referral-leaderboard.dart';

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
          body: const OverViewWidget(),
        ));
  }
}

class OverViewWidget extends StatelessWidget {
  const OverViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FractionallySizedBox(
      widthFactor: 0.8,
      heightFactor: 0.3,
      alignment: FractionalOffset.center,
      child: DecoratedBox(
        decoration:
            BoxDecoration(border: Border.all(width: 2), color: Colors.grey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image.asset('./images/stadscafe.png', width: 70, height: 70),
            const Text("Coen van den Berge"),
          ],
        ),
      ),
    );

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
        children: const [Text("1")],
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
          children: const [Text("1")]),
    );

    final referral = FractionallySizedBox(
      widthFactor: 0.6,
      heightFactor: 0.3,
      alignment: FractionalOffset.center,
      child: DecoratedBox(
        decoration:
            BoxDecoration(border: Border.all(width: 2), color: Colors.grey),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [referralCompleted, const Text("Completed")]),
            Column(children: [referralPending, const Text("Pending")]),
          ],
        ),
      ),
    );

    final filter = FractionallySizedBox(
      widthFactor: 0.6,
      heightFactor: 0.8,
      alignment: FractionalOffset.center,
      child: DecoratedBox(
        decoration:
            BoxDecoration(border: Border.all(width: 2), color: Colors.grey),
      ),
    );

    final referralRowPhoto = Container(
      width: 70,
      height: 70,
      decoration:
          const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: Column(
        children: const [Text('1')],
      ),
    );

    const referralRowButton =
        TextButton(onPressed: onPressed, child: Text("KLIK MIJ"));

    final referralRowButtonContainer = Container(
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: referralRowButton,
    );

    // Row per deelnemer
    // per deelnemer: Foto, Naam, Functie, Status, Datum, Knop
    final referralRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        referralRowPhoto,
        const Text("NAAM DEELNEMER"),
        const Text("FUNCTIE"),
        const Text("STATUS"),
        const Text("DATUM"),
        referralRowButtonContainer
      ],
    );

    final referralContainerRow = Container(
      decoration: const BoxDecoration(color: Colors.grey),
      child: referralRow,
    );

    // Column van de deelnemer rows
    final referralsColumns = FractionallySizedBox(
      widthFactor: 0.6,
      heightFactor: 0.8,
      alignment: FractionalOffset.center,
      child: DecoratedBox(
        decoration:
            BoxDecoration(border: Border.all(width: 2), color: Colors.grey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            referralContainerRow,
            referralContainerRow,
            referralContainerRow,
            referralContainerRow
          ],
        ),
      ),
    );

    return Container(
      child: Column(
        children: [
          Flexible(
              child: Row(children: [
            Flexible(child: user),
            Flexible(child: referral),
          ])),
          Flexible(
            child: referralsColumns,
          )
        ],
      ),
    );
  }
}
