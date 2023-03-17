import 'package:cz_app/models/Referral.dart';
import 'package:flutter/material.dart';

class ReferralDashBoard extends StatelessWidget {
  const ReferralDashBoard({super.key});
  @override
  Widget build(BuildContext context) {
    final r = Referral(
        id: 1,
        status: "done",
        participantEmail: "coenvdberge@outlook.com",
        participantName: "Coen",
        registrationDate: DateTime.now());
    final referralRowPhoto = Container(
      width: 70,
      height: 70,
      decoration:
          const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: Image.asset(
        './images/stadscafe.png',
        width: 70,
        height: 70,
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
        Text(r.status),
        Text(r.participantName),
        Text(r.participantEmail),
        referralRowButtonContainer
      ],
    );

    final referralContainerRow = Container(
      decoration: const BoxDecoration(color: Colors.grey),
      child: referralRow,
    );

    // Column van de deelnemer rows
    return FractionallySizedBox(
      widthFactor: 1.0,
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
  }
}

void onPressed() {}
