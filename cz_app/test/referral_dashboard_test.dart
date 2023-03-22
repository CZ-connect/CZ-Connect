import 'package:cz_app/widget/Dashboard/DashboardRow.dart';
import 'package:cz_app/widget/Dashboard/ReferralStatus.dart';
import 'package:cz_app/widget/Dashboard/UserRow.dart';
import 'package:cz_app/widget/Dashboard/mainDashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';

void main() {
  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();
  });

  group('OverViewWidget', () {
    testWidgets('renders app bar with correct title',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(const OverViewWidget());

      // Find the app bar widget
      final appBarFinder = find.byType(AppBar);

      // Verify that the app bar widget is displayed
      expect(appBarFinder, findsOneWidget);

      // Find the app bar title widget
      final titleFinder = find.text('CZ-Connect');

      // Verify that the app bar title widget is displayed with the correct text
      expect(titleFinder, findsOneWidget);
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
