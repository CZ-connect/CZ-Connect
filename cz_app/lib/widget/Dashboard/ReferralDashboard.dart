import 'package:cz_app/models/Referral.dart';
import 'package:flutter/material.dart';
import 'package:cz_app/data/ReferralData.dart';

class ReferralDashBoard extends StatefulWidget {
  const ReferralDashBoard({super.key});

  @override
  State<StatefulWidget> createState() => _ReferralDashBoard();
}

class _ReferralDashBoard extends State<ReferralDashBoard> {
  late Future<List<Referral>> referrals;

  @override
  void initState() {
    referrals = ReferralData().fetchReferrals();
    super.initState();
  }

  final referralRowPhoto = Container(
    width: 70,
    height: 70,
    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    child: Image.asset(
      './images/stadscafe.png',
      width: 70,
      height: 70,
    ),
  );

  Widget referralRowButtonContainer() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: const TextButton(onPressed: onPressed, child: Text("KLIK MIJ")),
    );
  }

  Widget getReferralsRow(Referral referral) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        referralRowPhoto,
        Text(referral.status),
        Text(referral.participantName),
        Text(referral.participantEmail),
        referralRowButtonContainer()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Referral>>(
      future: ReferralData().fetchReferrals(),
      builder: (context, snapshot) {
        List<Referral>? referrals = snapshot.data;
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: referrals!.length - 1,
            itemBuilder: (context, index) {
              return getReferralsRow(snapshot.data![index]);
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

void onPressed() {}
