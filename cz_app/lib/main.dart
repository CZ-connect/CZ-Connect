import 'package:cz_app/widget/app/models/referral.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
import 'package:cz_app/widget/app/referral_form/appMainContainer.dart';
import 'package:cz_app/widget/app/referral_form/bottemAppLayout.dart';
import 'package:cz_app/widget/app/referral_form/form/storeInput.dart';
import 'package:cz_app/widget/app/referral_form/template/ScreenTemplate.dart';
import 'package:cz_app/widget/app/referral_form/topAppLayout.dart';
import 'package:cz_app/widget/app/referral_per_user/views/error.dart';
import 'package:cz_app/widget/app/referral_per_user/views/loading.dart';
import 'package:cz_app/widget/app/referral_per_user/views/referralOverview.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        return ReferralOverview(referrals: referrals);
      }
    ),
    GoRoute(
      path: '/referraldetail',
      builder: (context, state) => const Scaffold(
        body: ReferralDashboardTemplate(
          header: ReferralDashboardTopWidget(),
          body: ReferralDashboardBottomWidget(
            child: ReferralDashboardContainerWidget(
              child: ReferralDetailWidget(),
            ),
          ),
        ),
      ),
    ),
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingWidget(),
    ),
    GoRoute(
      path: '/error',
      builder: (context, state) => const ErrorScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state){
      String? referral = state.queryParams['referral'];
      return Scaffold(
        body: ScreenTemplate(
          header: topAppWidget(),
          body: bottemAppWidget(
            child: appMainContainer(
              child: formWidget(referral: referral)
            ),
          ),
        )
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
    );
  }
}