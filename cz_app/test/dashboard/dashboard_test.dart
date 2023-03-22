import 'package:cz_app/widget/Dashboard/DashboardRow.dart';
import 'package:cz_app/widget/Dashboard/ReferralStatus.dart';
import 'package:cz_app/widget/Dashboard/UserRow.dart';
import 'package:cz_app/widget/Dashboard/mainDashboard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';

void main() {
  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();
  });

  group('OverViewWidget', () {
    testWidgets('renders UI components correctly', (WidgetTester tester) async {
      // Build the OverViewWidget
      await tester.pumpWidget(const OverViewWidget());

      // Verify that the app bar title is correct
      expect(find.text('CZ-Connect'), findsOneWidget);

      // Verify that the UserRow and ReferralStatus widgets are being rendered
      expect(find.byType(UserRow), findsOneWidget);
      expect(find.byType(ReferralStatus), findsOneWidget);

      // Verify that the DashboardRow widget is being rendered
      expect(find.byType(DashboardRow), findsOneWidget);
    });

    testWidgets('renders three rows', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(const OverViewWidget());

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
