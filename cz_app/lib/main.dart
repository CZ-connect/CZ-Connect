//Referral Dashboard & Details
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_per_user/views/referral_overview.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
//Referral Overview
import 'package:cz_app/widget/app/referral_per_user/views/error.dart';
import 'package:cz_app/widget/app/referral_per_user/views/loading.dart';
import 'package:cz_app/widget/app/referral_per_user/views/menu.dart';
//Referral Form
import 'package:cz_app/widget/app/referral_form//store_input.dart';
import 'package:cz_app/widget/app/templates/referral_form/screen_template.dart';
import 'package:cz_app/widget/app/templates/referral_form/top_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_form/bottom_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_form/app_main_container.dart';
//General
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/referraldashboard': (context) => const Scaffold(
              body: ReferralDashboardTemplate(
                header: ReferralDashboardTopWidget(),
                body: ReferralDashboardBottomWidget(
                  child: ReferralDashboardContainerWidget(
                    child: ReferralDashboardIndexWidget(),
                  ),
                ),
              ),
            ),
        '/referralMenu': (context) => const Menu(),
        '/referralOverview': (context) => const ReferralOverview(),
        '/referraldetail': (context) => const Scaffold(
              body: ReferralDashboardTemplate(
                header: ReferralDashboardTopWidget(),
                body: ReferralDashboardBottomWidget(
                  child: ReferralDashboardContainerWidget(
                    child: ReferralDetailWidget(),
                  ),
                ),
              ),
            ),
        '/loading': (context) => const LoadingWidget(),
        '/error': (context) => const ErrorScreen(),
        '/': (context) => Scaffold(
              body: ScreenTemplate(
                header: const TopAppWidget(),
                body: BottemAppWidget(
                  child: AppMainContainer(
                    child: FormWidget(),
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
