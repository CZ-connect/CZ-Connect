import 'package:cz_app/widget/app/models/referral.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/referral_status.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/user_row.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/dashboard_row.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nock/nock.dart';

GoRouter _router = GoRouter(
  routes: [
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
        }),
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold(
            body: ReferralDashboardTemplate(
              header: ReferralDashboardTopWidget(),
              body: ReferralDashboardBottomWidget(
                child: ReferralDashboardContainerWidget(
                  child: ReferralDashboardIndexWidget(),
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

  group('Delete referrals', () {
    const expectedJsonResponse =
        '{"referrals":[{"id":15,"participantName":"Jesse Smit","status":"Pending","participantEmail":"JesseSmit@example.com","participantPhoneNumber":null,"registrationDate":"2022-11-02T00:00:00","employeeId":2,"employee":null},{"id":16,"participantName":"Noa van Beek","status":"Pending","participantEmail":"NoavanBeek@example.com","participantPhoneNumber":null,"registrationDate":"2022-01-24T00:00:00","employeeId":2,"employee":null},{"id":37,"participantName":"Noud Smits","status":"Pending","participantEmail":"NoudSmits@example.com","participantPhoneNumber":null,"registrationDate":"2022-06-11T00:00:00","employeeId":2,"employee":null},{"id":63,"participantName":"Thijs Kuijpers","status":"Approved","participantEmail":"ThijsKuijpers@example.com","participantPhoneNumber":null,"registrationDate":"2022-08-06T00:00:00","employeeId":2,"employee":null},{"id":65,"participantName":"Mees van Beek","status":"Approved","participantEmail":"MeesvanBeek@example.com","participantPhoneNumber":null,"registrationDate":"2022-09-02T00:00:00","employeeId":2,"employee":null},{"id":67,"participantName":"Sem Peters","status":"Approved","participantEmail":"SemPeters@example.com","participantPhoneNumber":null,"registrationDate":"2023-03-08T00:00:00","employeeId":2,"employee":null},{"id":70,"participantName":"Tess Vermeer","status":"Approved","participantEmail":"TessVermeer@example.com","participantPhoneNumber":null,"registrationDate":"2023-02-10T00:00:00","employeeId":2,"employee":null}],"completed":4,"pending":3}';
    testWidgets('Delete refferal', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
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
      nock.delete("/referral/15").reply(
        200,
        "{}"
      );

      // Build the OverViewWidget
      await tester.runAsync(() async {
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
      });
      //Expect the data is loaded
      expect(interceptor.isDone, true);
      expect(find.text("Jesse Smit"), findsOneWidget);
      await tester.tap(find.text("Jesse Smit"));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Verwijderen").first, warnIfMissed: true);
      await tester.pumpAndSettle();
      expect(find.text("Jesse Smit"), findsNothing);
    });
  });
}
