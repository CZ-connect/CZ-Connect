import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferralLinkShareDialog extends StatelessWidget {
  const ReferralLinkShareDialog({Key? key}) : super(key: key);
  final String link = "localhost:5555/#/?referral=";

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
          Center(child:SelectableText(link + UserPreferences.getUserId().toString())),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            child: Text(AppLocalizations.of(context)!.buttonCopyLink),
            onPressed:  () async {
              await Clipboard.setData(ClipboardData(text: link + UserPreferences.getUserId().toString()));
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