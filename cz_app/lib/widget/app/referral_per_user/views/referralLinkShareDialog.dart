import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferralLinkShareDialog extends StatelessWidget {
  const ReferralLinkShareDialog({Key? key}) : super(key: key);
  final String link = "https://www.example.com";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Referentielink"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Gebruik de onderstaande referentielink om nieuwe gebruikers aan te brengen'),
          SizedBox(height: 8),
          Center(child:SelectableText(link)),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Kopiëer de link"),
          onPressed:  () async {
            //todo get user ID
            await Clipboard.setData(ClipboardData(text: link));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Link gekopieerd!"),
                duration: Duration(seconds: 1),
              ),
            );
            Navigator.of(context).pop();
          }
        ),
      ],
    );
  }
}