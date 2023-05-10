import 'package:cz_app/widget/app/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:cz_app/widget/app/referral_dashboard/data/referral_data.dart';
import 'package:go_router/go_router.dart';

import '../../models/referral.dart';
import '../../referral_dashboard/services/delete_referral.dart';

class WarningDialog extends StatefulWidget {
  final Referral referral;
  const WarningDialog({super.key,  required this.referral});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _WarningDialog();
}

class _WarningDialog extends State<WarningDialog> {

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
       // context.go("/referraldetail"); //wat extra toevoegen
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Ja, verwijderen"),
      onPressed:  () {
        deleteReferral(context, widget.referral.id);
        context.go('/referraldashboard');
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Referral Verwijderen"),
      content: const Text("Weet u zeker dat u deze referral wilt gaan verwijderen?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return alert;
  }
}