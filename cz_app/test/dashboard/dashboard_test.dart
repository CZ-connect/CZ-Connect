import 'package:cz_app/widget/app/referral_dashboard/partials/ReferralStatus.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/UserRow.dart';
import 'package:cz_app/widget/app/referral_dashboard/partials/DashboardRow.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
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

  group('OverViewWidget', () {
    const expectedJsonResponse =
        '{"referrals":[{"id":1,"employeeName":"CZ-Medewerker","participantEmail":"cmberge@avans.nl","participantName":"Coen","registrationDate":"2023-03-23T13:18:26.3107564","status":"Afgerond"},{"id":2,"employeeName":"CZ-Medewerker","participantEmail":"m1@avans.nl","participantName":"Marijn 1","registrationDate":"2023-03-23T13:18:26.3107634","status":"In afwachting"},{"id":3,"employeeName":"CZ-Medewerker","participantEmail":"m2@avans.nl","participantName":"Marijn 2","registrationDate":"2023-03-23T13:18:26.3107638","status":"Afgerond"},{"id":4,"employeeName":"CZ-Medewerker","participantEmail":"jos@example.com","participantName":"Jos","registrationDate":"2023-03-23T13:18:26.3107643","status":"Afgerond"},{"id":5,"employeeName":"CZ-Medewerker","participantEmail":"jedrek@avans.nl","participantName":"Jedrek","registrationDate":"2023-03-23T13:18:26.3107647","status":"Afgerond"},{"id":6,"employeeName":"CZ-Medewerker","participantEmail":"wballeko@avans.nl","participantName":"William","registrationDate":"2023-03-23T13:18:26.3107652","status":"In afwachting"}],"completed":4,"pending":2}';
    testWidgets('renders UI components correctly', (WidgetTester tester) async {
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

      // Build the OverViewWidget
      await tester.pumpWidget(const OverViewWidget());
      expect(interceptor.isDone, true);

      // Verify that the app bar title is correct
      expect(find.text('CZ-Connect'), findsOneWidget);

      // Verify that the UserRow and ReferralStatus widgets are being rendered
      expect(find.byType(UserRow), findsOneWidget);

      expect(find.byType(ReferralStatus), findsOneWidget);

      // Verify that the DashboardRow widget is being rendered
      expect(find.byType(DashboardRow), findsOneWidget);
    });

    testWidgets('renders three rows', (WidgetTester tester) async {
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

      // Build the widget
      await tester.pumpWidget(const OverViewWidget());
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

      // Build the widget
      await tester.runAsync(() async {
        await tester.pumpWidget(const OverViewWidget());
        await tester.pumpAndSettle();
      });

      expect(interceptor.isDone, true);

      // Display the amount of completed and pending referrals
      await expectLater(find.text("4", skipOffstage: false), findsWidgets);
      await expectLater(find.text("2", skipOffstage: false), findsWidgets);

      // Display the name and email of some referrals
      await expectLater(find.text("Coen", skipOffstage: false), findsWidgets);
      await expectLater(
          find.text("jos@example.com", skipOffstage: false), findsWidgets);
    });
  });
}
