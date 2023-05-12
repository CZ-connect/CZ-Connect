import 'package:cz_app/widget/app/referral_per_user/views/referral_link_share_dialog.dart';
import 'package:flutter/material.dart';

class ReferralLinkShareButton extends StatelessWidget {
  const ReferralLinkShareButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ReferralLinkShareDialog();
          },
        );
      },
      label: const Text('Deel je link'),
      icon: const Icon(Icons.share_outlined),
      backgroundColor: Colors.redAccent,
    );
  }
}
