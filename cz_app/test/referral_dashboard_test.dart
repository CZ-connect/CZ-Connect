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
import 'package:nock/nock.dart';

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
  group('OverViewWidget', () {
    const expectedJsonResponse =
        '{"referrals":[{"id":63,"participantName":"Thijs Kuijpers","status":"Denied","participantEmail":"ThijsKuijpers@example.com","participantPhoneNumber":null,"registrationDate":"2023-03-31T00:00:00","employeeId":2,"employee":null},{"id":78,"participantName":"Isa van der Velde","status":"Approved","participantEmail":"IsavanderVelde@example.com","participantPhoneNumber":null,"registrationDate":"2022-07-20T00:00:00","employeeId":2,"employee":null},{"id":87,"participantName":"Luuk Willemsen","status":"Approved","participantEmail":"LuukWillemsen@example.com","participantPhoneNumber":null,"registrationDate":"2022-03-02T00:00:00","employeeId":2,"employee":null},{"id":98,"participantName":" Mees van Dijk","status":"Denied","participantEmail":"MeesvanDijk@example.com","participantPhoneNumber":null,"registrationDate":"2023-04-07T00:00:00","employeeId":2,"employee":null}],"completed":2,"pending":0}';
    testWidgets('renders UI components correctly', (WidgetTester tester) async {
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

      // Build the OverViewWidget
      await tester.pumpWidget(referralDashboard);
      await tester.pumpAndSettle();
      expect(interceptor.isDone, true);

      // Verify that the app bar title is correct
      expect(find.text('CZ Connect - Dashboard'), findsOneWidget);

      // Verify that the UserRow and ReferralStatus widgets are being rendered
      expect(find.byType(UserRow), findsOneWidget);

      expect(find.byType(ReferralStatus), findsOneWidget);

      // Verify that the DashboardRow widget is being rendered
      expect(find.byType(DashboardRow), findsOneWidget);
    });

    testWidgets('renders three rows', (WidgetTester tester) async {
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

      // Build the widget
      await tester.pumpWidget(referralDashboard);
      await tester.pumpAndSettle();
      expect(interceptor.isDone, true);

      // Find the three row widgets
      final userRowFinder = find.byType(UserRow);
      final referralStatusFinder = find.byType(ReferralStatus);
      final dashboardRowFinder = find.byType(DashboardRow);

      // Verify that all three row widgets are displayed
      expect(userRowFinder, findsOneWidget);
      expect(referralStatusFinder, findsOneWidget);
      expect(dashboardRowFinder, findsOneWidget);
    });

    testWidgets('renders async data', (WidgetTester tester) async {
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

      // Build the widget
      await tester.runAsync(() async {
        await tester.pumpWidget(referralDashboard);
        await tester.pumpAndSettle();
      });

      expect(interceptor.isDone, true);

      // Display the amount of completed and pending referrals
      await expectLater(find.text("2", skipOffstage: false), findsWidgets);
      await expectLater(find.text("0", skipOffstage: false), findsWidgets);

      // Display the name and email of some referrals
      await expectLater(
          find.text("Thijs Kuijpers", skipOffstage: false), findsWidgets);
      await expectLater(
          find.text("ThijsKuijpers@example.com", skipOffstage: false),
          findsWidgets);
    });
  });
}
