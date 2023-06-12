import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContainerTextWidget extends StatelessWidget {
  const ContainerTextWidget({Key? key, required this.context}) : super(key: key);
  final BuildContext context;

  String get h1 => AppLocalizations.of(context)!.signUpHereLabel;
  String get h2 => AppLocalizations.of(context)!.useFormToApplyLabel;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(h1,
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 40)),
        Text(h2,
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 32))
      ],
    );
  }
}
