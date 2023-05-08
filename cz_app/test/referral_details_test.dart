import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';

void main() {
  setUpAll(() {
    nock.defaultBase = "http://localhost:3000/api";
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });
  Widget referralDashboard = MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Scaffold(
            body: ReferralDashboardTemplate(
              header: ReferralDashboardTopWidget(),
              body: ReferralDashboardBottomWidget(
                child: ReferralDashboardContainerWidget(
                  child: ReferralDashboardIndexWidget(),
                ),
              ),
            ),
          ),
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
    },
  );
  const expectedJsonResponse =
      '{"referrals":[{"id":50,"participantName":"Vera Meijer","status":"Approved","participantEmail":"VeraMeijer@example.com","participantPhoneNumber":null,"registrationDate":"2022-08-31T00:00:00","employeeId":2,"employee":null},{"id":56,"participantName":"Liv van Dijk","status":"Denied","participantEmail":"LivvanDijk@example.com","participantPhoneNumber":null,"registrationDate":"2022-02-05T00:00:00","employeeId":2,"employee":null}],"completed":1,"pending":0}';
  group('Referral Details', () {
    testWidgets("Navigating to referral details page",
        (WidgetTester tester) async {
      final interceptor = nock.get("/referral/employee/2")
        ..reply(
          200,
          expectedJsonResponse,
        );

      nock.get("/referral/employee/2").reply(
            200,
            expectedJsonResponse,
          );

      nock.get("/referral/employee/2").reply(
            200,
            expectedJsonResponse,
          );
      //Load Async Widget
      await tester.runAsync(() async {
        await tester.pumpWidget(referralDashboard);
        await tester.pumpAndSettle();
      });
      //Expect the data is loaded
      expect(interceptor.isDone, true);
      //Find text within table and click it
      await tester.tap(find.text("Jesse Smit"));
      //Wait for next widget to open
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
    });
  });
}
