import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferralLinkShareDialog extends StatelessWidget {
  ReferralLinkShareDialog({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.titleReferralLink),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppLocalizations.of(context)!.textReferralLink),
          const SizedBox(height: 8),
          Center(child:SelectableText("Persoonlijke link met id: " + UserPreferences.getUserId().toString())),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            child: Text(AppLocalizations.of(context)!.buttonCopyLink),
            onPressed:  () async {
              var host = dotenv.env['API_URL'];
              if(host!.isEmpty) {
                host = 'https://flutter-frontend.azurewebsites.net/';
              }

              await Clipboard.setData(ClipboardData(text: host+'/#/?referral=' + UserPreferences.getUserId().toString()));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.linkCopiedMessage),
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