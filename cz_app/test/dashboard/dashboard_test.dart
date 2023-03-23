import 'package:cz_app/widget/Dashboard/DashboardRow.dart';
import 'package:cz_app/widget/Dashboard/ReferralStatus.dart';
import 'package:cz_app/widget/Dashboard/UserRow.dart';
import 'package:cz_app/widget/Dashboard/mainDashboard.dart';
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
        '{"referrals":[{"id":1,"participantEmail":"cmberge@avans.nl","participantName":"Coen","registrationDate":"2023-03-22T12:24:13.922536","status":"Completed"},{"id":2,"participantEmail":"m1@avans.nl","participantName":"Marijn 1","registrationDate":"2023-03-22T12:24:13.9225435","status":"Completed"},{"id":3,"participantEmail":"m2@avans.nl","participantName":"Marijn 2","registrationDate":"2023-03-22T12:24:13.9225442","status":"Completed"},{"id":4,"participantEmail":"jos@avans.nl","participantName":"Jos","registrationDate":"2023-03-22T12:24:13.9225449","status":"Completed"},{"id":5,"participantEmail":"jedrek@avans.nl","participantName":"Jedrek","registrationDate":"2023-03-22T12:24:13.9225455","status":"Pending"},{"id":6,"participantEmail":"wballeko@avans.nl","participantName":"William","registrationDate":"2023-03-22T12:24:13.9225461","status":"Pending"}],"completed":4,"pending":2}';

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
  });
}
