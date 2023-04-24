import 'package:cz_app/widget/app/referral_dashboard/partials/referral_status.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/user_row.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/dashboard_row.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_form/store_input.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:cz_app/widget/app/templates/referral_form/app_main_container.dart';
import 'package:cz_app/widget/app/templates/referral_form/bottom_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_form/screen_template.dart';
import 'package:cz_app/widget/app/templates/referral_form/top_app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';

void main() {
  setUpAll(() {
    nock.defaultBase = "http://localhost:3000/api";
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  Widget myapp = MaterialApp(
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
        '/': (context) => Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE40429), Color(0xFFFF9200)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const ScreenTemplate(
                  header: TopAppWidget(),
                  body: BottemAppWidget(
                    child: AppMainContainer(
                      child: FormWidget(),
                    ),
                  ),
                ),
              ),
            ),
    },
  );
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

      await tester.pumpWidget(myapp);
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
