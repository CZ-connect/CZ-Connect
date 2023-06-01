import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ReferralLinkShareDialog extends StatelessWidget {
  const ReferralLinkShareDialog({Key? key}) : super(key: key);
  final String link = "https://flutter-backend.azurewebsites.net/#/?referral=";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Referentielink"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Gebruik de onderstaande referentielink om nieuwe gebruikers aan te brengen'),
          const SizedBox(height: 8),
          Center(child:SelectableText(link + UserPreferences.getUserId().toString())),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            child: const Text("Kopiëer de link"),
            onPressed:  () async {
              await Clipboard.setData(ClipboardData(text: link + UserPreferences.getUserId().toString()));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Link gekopieerd!"),
                  duration: Duration(seconds: 1),
                ),
              );
              context.pop();
            }
        ),
      ],
    );
  }
}