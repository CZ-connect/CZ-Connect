import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:cz_app/widget/app/referral_per_user/services/referral_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  void setupReference() async {
    ReferralService instance =
        ReferralService(userId: UserPreferences.getUserId());
    try {
      await instance.getData();
      // ignore: use_build_context_synchronously
      context.go(Uri(path: '/referralOverview').toString(),
          extra: instance.referrals);
    } catch (e) {
      context.go(Uri(path: '/error').toString(),
          extra: {'message': AppLocalizations.of(context)!.failedToRetrieveDepartments});
    }
  }

  @override
  void initState() {
    super.initState();
    setupReference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(50.0),
            child: Center(child: Text(AppLocalizations.of(context)!.loadingData))));
  }
}
