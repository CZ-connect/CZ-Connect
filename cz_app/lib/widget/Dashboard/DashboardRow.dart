import 'package:cz_app/models/Referral.dart';
import 'package:flutter/material.dart';
import 'package:cz_app/data/ReferralData.dart';

class DashboardRow extends StatefulWidget {
  const DashboardRow({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardRow();
}

class _DashboardRow extends State<DashboardRow> {
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
      './images/profile_placeholder.png',
      width: 70,
      height: 70,
    ),
  );

  Widget referralRowButtonContainer() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.red, foregroundColor: Colors.black),
        onPressed: () => print('Bewerk'),
        child: const Text("Bewerk"),
      ),
    );
  }

  DataRow getReferralsRow(Referral referral) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) => Colors.grey),
      cells: <DataCell>[
        DataCell(referralRowPhoto),
        DataCell(Text(referral.employeeName)),
        DataCell(Text(referral.status)),
        DataCell(Text(referral.participantName)),
        DataCell(Text(referral.participantEmail)),
        DataCell(referralRowButtonContainer()),
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
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: true,
                child: DataTable(
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.grey),
                  // ignore: prefer_const_literals_to_create_immutables
                  columns: <DataColumn>[
                    const DataColumn(
                      label: Text(""),
                    ),
                    const DataColumn(
                      label: Text("Medewerker"),
                    ),
                    const DataColumn(
                      label: Text("Status"),
                    ),
                    const DataColumn(
                      label: Text("Naam sollicitant"),
                    ),
                    const DataColumn(
                      label: Text("Email sollicitant"),
                    ),
                    const DataColumn(
                      label: Text("Actie"),
                    ),
                  ],
                  rows: snapshot.data!.map<DataRow>(
                    (referral) {
                      return getReferralsRow(referral);
                    },
                  ).toList(),
                ),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
