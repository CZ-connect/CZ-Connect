import 'package:cz_app/widget/app/models/referral.dart';
import 'package:cz_app/widget/app/referral_dashboard/graphs/graph_widget.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
import 'package:cz_app/widget/app/referral_form/store_input.dart';
import 'package:cz_app/widget/app/referral_per_user/views/error.dart';
import 'package:cz_app/widget/app/referral_per_user/views/loading.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:cz_app/widget/app/templates/referral_form/app_main_container.dart';
import 'package:cz_app/widget/app/templates/referral_form/top_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_form/bottom_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_form/screen_template.dart';
import 'package:cz_app/widget/app/templates/referral_overview/container.dart';
import 'package:cz_app/widget/app/templates/referral_overview/template.dart';
import 'package:cz_app/widget/app/templates/referral_overview/top.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widget/app/referral_per_user/views/referralOverview.dart';

void main() => runApp(const MyApp());

/// The route configuration.

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/referraldashboard',
      builder: (context, state) => const Scaffold(
        body: ReferralDashboardTemplate(
          header: ReferralDashboardTopWidget(),
          body: ReferralDashboardBottomWidget(
            child: ReferralDashboardContainerWidget(
              child: ReferralDashboardIndexWidget(),
            ),
          ),
        ),
      ),
    ),
    GoRoute(
      path: '/referralOverview',
      builder: (context, state){
        List<Referral> referrals = state.extra as List<Referral>;

        return Scaffold(
            body: ReferralOverviewTemplate(
              header: const ReferralOverviewTopWidget(),
              body: ReferralOverviewContainerWidget(
                  child: ReferralOverview(referrals: referrals)
              ),
            ));
      }
    ),
    GoRoute(
      path: '/referraldetail',
      builder: (context, state) {
        Referral referral = state.extra as Referral;
        return Scaffold(
          body: ReferralDashboardTemplate(
            header: ReferralDashboardTopWidget(),
            body: ReferralDashboardBottomWidget(
              child: ReferralDashboardContainerWidget(
                child: ReferralDetailWidget(referral: referral),
              ),
            ),
          ),
        );
      }
    ),
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingWidget(),
    ),
    GoRoute(
      path: '/error',
      builder: (context, state) => const ErrorScreen(),
    ),
    GoRoute(path: '/graph',
      builder: (context, state) => const Scaffold(
      body: ReferralDashboardTemplate(
      header: ReferralDashboardTopWidget(),
      body: ReferralDashboardBottomWidget(
      child: ReferralDashboardContainerWidget(
      child: LineChartSample(),
      ),
      ),
      )
      )
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state){
      String? referral = state.queryParams['referral'];
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE40429), Color(0xFFFF9200)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ScreenTemplate(
            header: const TopAppWidget(),
            body: BottemAppWidget(
              child: AppMainContainer(
                child: FormWidget(),
              ),
            ),
            ),
          ),
      );}
    ),
]);
/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
        theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
    )));
  }
}
/*

=======
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {

        '/referralOverview': (context) => const Scaffold(
          body: ReferralOverviewTemplate(
              header: ReferralOverviewTopWidget(),
              body: ReferralOverviewContainerWidget(
                child: ReferralOverview()
              ),
          ),
        ),

      },

      ),
>>>>>>> origin/main
    );
 */