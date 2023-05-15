import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ReferralLinkShareDialog extends StatelessWidget {
  const ReferralLinkShareDialog({Key? key}) : super(key: key);
  final String link = "localhost:5555/#/?referral=1";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Referentielink"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
              'Gebruik de onderstaande referentielink om nieuwe gebruikers aan te brengen'),
          const SizedBox(height: 8),
          Center(child: SelectableText(link)),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            child: const Text("Kopiëer de link"),
            onPressed: () async {
              //todo get user ID
              await Clipboard.setData(ClipboardData(text: link));
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Link gekopieerd!"),
                  duration: Duration(seconds: 1),
                ),
              );
              // ignore: use_build_context_synchronously
              context.pop();
            }),
      ],
    );
  }
}
