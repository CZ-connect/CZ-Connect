//Referral Dashboard & Details
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
<<<<<<< HEAD
import 'package:cz_app/widget/app/referral_per_user/views/referral_overview.dart';
=======
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
import 'package:cz_app/widget/app/referral_form/appMainContainer.dart';
import 'package:cz_app/widget/app/referral_form/bottemAppLayout.dart';
import 'package:cz_app/widget/app/referral_form/form/storeInput.dart';
import 'package:cz_app/widget/app/referral_form/storeInput.dart';
import 'package:cz_app/widget/app/referral_form/template/ScreenTemplate.dart';
import 'package:cz_app/widget/app/referral_per_user/views/error.dart';
import 'package:cz_app/widget/app/referral_per_user/views/loading.dart';
import 'package:cz_app/widget/app/referral_per_user/views/referralOverview.dart';
>>>>>>> main
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
<<<<<<< HEAD
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
//Referral Overview
import 'package:cz_app/widget/app/referral_per_user/views/error.dart';
import 'package:cz_app/widget/app/referral_per_user/views/loading.dart';
import 'package:cz_app/widget/app/referral_per_user/views/menu.dart';
//Referral Form
import 'package:cz_app/widget/app/referral_form/partials/store_input.dart';
import 'package:cz_app/widget/app/templates/referral_form/screen_template.dart';
import 'package:cz_app/widget/app/templates/referral_form/top_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_form/bottom_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_form/app_main_container.dart';
//General
=======
import 'package:cz_app/widget/app/templates/topAppLayout.dart';
>>>>>>> main
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
<<<<<<< HEAD
        '/referralMenu': (context) => const Menu(),
=======
          ),
        ),
>>>>>>> main
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
<<<<<<< HEAD
        '/': (context) => const Scaffold(
              body: ScreenTemplate(
                header: TopAppWidget(),
                body: BottemAppWidget(
                  child: AppMainContainer(
                    child: FormWidget(),
                  ),
                ),
=======
        '/': (context) => Scaffold(

          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE40429), Color(0xFFFF9200)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
>>>>>>> main
              ),
            ),
            child: ScreenTemplate(
              header: topAppWidget(),
              body: bottemAppWidget(
                child: appMainContainer(
                  child: formWidget(),
                ),
              ),
            ),
          ),
        ),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
