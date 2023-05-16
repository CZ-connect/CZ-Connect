import 'package:cz_app/widget/app/auth/login.dart';
import 'package:cz_app/widget/app/referral_form/store_input.dart';
import 'package:cz_app/widget/app/templates/referral_form/app_main_container.dart';
import 'package:cz_app/widget/app/templates/referral_form/bottom_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_form/screen_template.dart';
import 'package:cz_app/widget/app/templates/referral_form/top_app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nock/nock.dart';

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state){
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
                  child: LoginWidget(),
                ),
              ),
            ),
          ),
        );}
  ),
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
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
        );
      }),
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
        '{"referrals":[{"id":0,"employeeName":"CZ-Medewerker","participantEmail":"cmberge@avans.nl","participantName":"Coen","registrationDate":"2023-03-23T13:18:26.3107564","status":"Afgerond"},{"id":2,"employeeName":"CZ-Medewerker","participantEmail":"m1@avans.nl","participantName":"Marijn 1","registrationDate":"2023-03-23T13:18:26.3107634","status":"In afwachting"},{"id":3,"employeeName":"CZ-Medewerker","participantEmail":"m2@avans.nl","participantName":"Marijn 2","registrationDate":"2023-03-23T13:18:26.3107638","status":"Afgerond"},{"id":4,"employeeName":"CZ-Medewerker","participantEmail":"jos@example.com","participantName":"Jos","registrationDate":"2023-03-23T13:18:26.3107643","status":"Afgerond"},{"id":5,"employeeName":"CZ-Medewerker","participantEmail":"jedrek@avans.nl","participantName":"Jedrek","registrationDate":"2023-03-23T13:18:26.3107647","status":"Afgerond"},{"id":6,"employeeName":"CZ-Medewerker","participantEmail":"wballeko@avans.nl","participantName":"William","registrationDate":"2023-03-23T13:18:26.3107652","status":"In afwachting"}],"completed":3,"pending":2}';
    testWidgets('Go to the dashboard by menu', (WidgetTester tester) async {
      nock.get("/referral/employee/0").reply(
        200,
        expectedJsonResponse,
      );
      nock.get("/referral/employee/0").reply(
        200,
        expectedJsonResponse,
      );
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('login_menu_item')));
      await tester.pumpAndSettle();
      expect(find.text('Inloggen voor CZ-medewerkers'), findsOneWidget);
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