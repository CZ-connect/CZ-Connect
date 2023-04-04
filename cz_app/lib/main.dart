import 'package:cz_app/widget/app/models/Referral.dart';
import 'package:cz_app/widget/app/referral_dashboard/layout/bottom.dart';
import 'package:cz_app/widget/app/referral_dashboard/layout/container.dart';
import 'package:cz_app/widget/app/referral_dashboard/layout/template.dart';
import 'package:cz_app/widget/app/referral_dashboard/layout/top.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/layout/bottom.dart';
import 'package:cz_app/widget/app/referral_details/layout/container.dart';
import 'package:cz_app/widget/app/referral_details/layout/template.dart';
import 'package:cz_app/widget/app/referral_details/layout/top.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
import 'package:cz_app/widget/app/referral_form/appMainContainer.dart';
import 'package:cz_app/widget/app/referral_form/bottemAppLayout.dart';
import 'package:cz_app/widget/app/referral_form/form/storeInput.dart';
import 'package:cz_app/widget/app/referral_form/template/ScreenTemplate.dart';
import 'package:cz_app/widget/app/referral_form/topAppLayout.dart';
import 'package:cz_app/widget/app/referral_per_user/views/error.dart';
import 'package:cz_app/widget/app/referral_per_user/views/loading.dart';
import 'package:cz_app/widget/app/referral_per_user/views/referralOverview.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/referraldetail') {
          final Referral arg = settings.arguments as Referral;
        }
      },
      initialRoute: '/',
      routes: {
        '/referraldashboard': (context) => const Scaffold(
              body: ReferralIndexTemplate(
                header: ReferralIndexTopWidget(),
                body: ReferralIndexBottomWidget(
                  child: ReferralIndexContainerWidget(
                    child: OverViewWidget(),
                  ),
                ),
              ),
            ),
        '/referralOverview': (context) => const ReferralOverview(),
        '/referraldetail': (context) => const Scaffold(
              body: ReferralDetailTemplate(
                header: ReferralDetailTopWidget(),
                body: ReferralDetailBottomWidget(
                  child: ReferralDetailContainerWidget(
                    child: ReferralDetailWidget(),
                  ),
                ),
              ),
            ),
        '/loading': (context) => const LoadingWidget(),
        '/error': (context) => const ErrorScreen(),
        '/': (context) => Scaffold(
              body: ScreenTemplate(
                header: topAppWidget(),
                body: bottemAppWidget(
                  child: appMainContainer(
                    child: formWidget(),
                  ),
                ),
              ),
            ),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
