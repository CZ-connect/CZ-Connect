import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/models/employee_referral.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nock/nock.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';

GoRouter _router = GoRouter(
  routes: [
    GoRoute(
        path: '/referraldetail',
        builder: (context, state) {
          EmployeeReferralViewModel? employeeReferral =
              state.extra as EmployeeReferralViewModel?;
          return Scaffold(
            body: ReferralDashboardTemplate(
              header: const ReferralDashboardTopWidget(),
              body: ReferralDashboardBottomWidget(
                child: ReferralDashboardContainerWidget(
                  child:
                      ReferralDetailWidget(employeeReferral: employeeReferral),
                ),
              ),
            ),
          );
        }),
    GoRoute(
        path: '/',
        builder: (context, state) {
          Employee? employee = state.extra as Employee?;
          return Scaffold(
            body: ReferralDashboardTemplate(
              header: const ReferralDashboardTopWidget(),
              body: ReferralDashboardBottomWidget(
                child: ReferralDashboardContainerWidget(
                  child: ReferralDashboardIndexWidget(employee: employee),
                ),
              ),
            ),
          );
        }),
  ],
);

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
  const expectedJsonResponse =
      '{"referrals":[{"id":1,"participantName":"Vera Meijer","status":"pending","participantEmail":"VeraMeijer@example.com","participantPhoneNumber":null,"registrationDate":"2022-08-31T00:00:00","employeeId":0,"employee":null}],"completed":1,"pending":0}';

  group('Referral Details', () {
    testWidgets("Navigating to referral details page",
        (WidgetTester tester) async {
      final interceptor = nock.get("/referral/employee/0")
        ..reply(
          200,
          expectedJsonResponse,
        );

      nock.get("/referral/employee/0").reply(
            200,
            expectedJsonResponse,
          );

      nock.get("/referral/employee/0").reply(
            200,
            expectedJsonResponse,
          );
      //Load Async Widget
      await tester.runAsync(() async {
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
      });
      //Expect the data is loaded
      expect(interceptor.isDone, true);
      //Find text within table and click it
      expect(find.text("Vera Meijer"), findsOneWidget);
      await tester.tap(find.text("Vera Meijer"), warnIfMissed: true);
      //Wait for next widget to open
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
    });
  });
}
