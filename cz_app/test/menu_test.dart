import 'package:cz_app/widget/app/models/referral.dart';
import 'package:cz_app/widget/app/referral_dashboard/graphs/graph_widget.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/referral_status.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/user_row.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/dashboard_row.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
import 'package:cz_app/widget/app/referral_form/store_input.dart';
import 'package:cz_app/widget/app/referral_per_user/views/error.dart';
import 'package:cz_app/widget/app/referral_per_user/views/loading.dart';
import 'package:cz_app/widget/app/referral_per_user/views/referralOverview.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:cz_app/widget/app/templates/referral_form/app_main_container.dart';
import 'package:cz_app/widget/app/templates/referral_form/bottom_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_form/screen_template.dart';
import 'package:cz_app/widget/app/templates/referral_form/top_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_overview/container.dart';
import 'package:cz_app/widget/app/templates/referral_overview/template.dart';
import 'package:cz_app/widget/app/templates/referral_overview/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nock/nock.dart';


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
            List<Referral>? referrals = state.extra as List<Referral>?;
            if(referrals == null){
              context.go('/loading');
            }
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
            Referral? referral = state.extra as Referral?;
            if (referral == null) {
              context.go('/referraldashboard');
              return const Scaffold();
            }
            return Scaffold(
              body: ReferralDashboardTemplate(
                header: ReferralDashboardTopWidget(),
                body: ReferralDashboardBottomWidget(
                  child: ReferralDashboardContainerWidget(
                    child: ReferralDetailWidget(referral: referral!),
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
                      child: FormWidget(referral: referral),
                    ),
                  ),
                ),
              ),
            );}
      ),
    ]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

void main() {
  setUpAll(() {
    nock.defaultBase = "http://localhost:3000/api";
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  group('Menu test', () {

    const expectedJsonResponse =
        '{"referrals":[{"id":1,"employeeName":"CZ-Medewerker","participantEmail":"cmberge@avans.nl","participantName":"Coen","registrationDate":"2023-03-23T13:18:26.3107564","status":"Afgerond"},{"id":2,"employeeName":"CZ-Medewerker","participantEmail":"m1@avans.nl","participantName":"Marijn 1","registrationDate":"2023-03-23T13:18:26.3107634","status":"In afwachting"},{"id":3,"employeeName":"CZ-Medewerker","participantEmail":"m2@avans.nl","participantName":"Marijn 2","registrationDate":"2023-03-23T13:18:26.3107638","status":"Afgerond"},{"id":4,"employeeName":"CZ-Medewerker","participantEmail":"jos@example.com","participantName":"Jos","registrationDate":"2023-03-23T13:18:26.3107643","status":"Afgerond"},{"id":5,"employeeName":"CZ-Medewerker","participantEmail":"jedrek@avans.nl","participantName":"Jedrek","registrationDate":"2023-03-23T13:18:26.3107647","status":"Afgerond"},{"id":6,"employeeName":"CZ-Medewerker","participantEmail":"wballeko@avans.nl","participantName":"William","registrationDate":"2023-03-23T13:18:26.3107652","status":"In afwachting"}],"completed":3,"pending":2}';
    testWidgets('Go to the dashboard by menu', (WidgetTester tester) async {
      final interceptor = nock.get("/referral")
        ..reply(
          200,
          expectedJsonResponse,
        );

      nock.get("/referral").reply(
            200,
            expectedJsonResponse,
          );

      nock.get("/referral").reply(
            200,
            expectedJsonResponse,
          );
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('referral_dashboard_menu_item')));
      await tester.pumpAndSettle();

      expect(interceptor.isDone, true);
      expect(find.text('CZ-connect-dashboard'), findsOneWidget);
      expect(find.byType(UserRow), findsOneWidget);
      expect(find.byType(ReferralStatus), findsOneWidget);
      expect(find.byType(DashboardRow), findsOneWidget);
    });
  });
}

void ignoreOverflowErrors(
    FlutterErrorDetails details, {
      bool forceReport = false,
    }) {
  bool ifIsOverflowError = false;
  bool isUnableToLoadAsset = false;

  // Detect overflow error.
  var exception = details.exception;
  if (exception is FlutterError) {
    ifIsOverflowError = !exception.diagnostics.any(
          (e) => e.value.toString().startsWith("A RenderFlex overflowed by"),
    );
    isUnableToLoadAsset = !exception.diagnostics.any(
          (e) => e.value.toString().startsWith("Unable to load asset"),
    );
  }

  // Ignore if is overflow error.
  if (ifIsOverflowError || isUnableToLoadAsset) {
    debugPrint('Ignored Error');
  } else {
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
  }
}
