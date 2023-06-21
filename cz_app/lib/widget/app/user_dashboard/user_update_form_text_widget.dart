import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserUpdateContainerTextWidget extends StatelessWidget {
  final BuildContext context;

  const UserUpdateContainerTextWidget({Key? key, required this.context})
      : super(key: key);

  String get str => AppLocalizations.of(context)!.editUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(str,
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 30)),
      ],
    );
  }
}