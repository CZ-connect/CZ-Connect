import 'package:flutter/material.dart';

final referralRowPhoto = Container(
  width: 70,
  height: 70,
  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
  child: Column(
    children: const [Text('1')],
  ),
);

const referralRowButton =
    TextButton(onPressed: onPressed, child: const Text("KLIK MIJ"));

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
final referralsColumns = Column(
  children: [
    referralContainerRow,
    referralContainerRow,
    referralContainerRow,
    referralContainerRow
  ],
);

class ReferralLeaderboard extends StatelessWidget {
  const ReferralLeaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referral Leaderboard'),
      ),
      body: Container(
        child: referralsColumns,
      ),
    );
  }
}

void onPressed() {}
