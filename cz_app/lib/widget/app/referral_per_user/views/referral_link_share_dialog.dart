import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

class ReferralLinkShareDialog extends StatelessWidget {
  ReferralLinkShareDialog({Key? key}) : super(key: key);



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
          Center(child:SelectableText("Persoonlijke link met id: " + UserPreferences.getUserId().toString())),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            child: const Text("Kopiëer de link"),
            onPressed:  () async {
              var host = dotenv.env['API_URL'];
              if(host!.isEmpty) {
                host = 'https://flutter-frontend.azurewebsites.net/';
              }

              await Clipboard.setData(ClipboardData(text: host+'/#/?referral=' + UserPreferences.getUserId().toString()));
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