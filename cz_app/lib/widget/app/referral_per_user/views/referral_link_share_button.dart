import 'package:cz_app/widget/app/referral_per_user/views/referral_link_share_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferralLinkShareButton extends StatelessWidget {
  const ReferralLinkShareButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ReferralLinkShareDialog();
          },
        );
      },
      label: Text(AppLocalizations.of(context)!.labelShareLink),
      icon: const Icon(Icons.share_outlined),
      backgroundColor: Colors.redAccent,
    );
  }
}
