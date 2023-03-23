import 'package:cz_app/widget/app/views/error.dart';
import 'package:cz_app/widget/app/views/loading.dart';
import 'package:cz_app/widget/app/views/menu.dart';
import 'package:cz_app/widget/app/views/referralOverview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Refferal Overview', () {
    testWidgets('clicking on "Refferals overzicht" should show the referral overview', (WidgetTester tester) async {
      // Build the widget tree
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const Menu(),
          '/loading': (context) => const LoadingWidget(),
          '/referralOverview': (context) => const ReferralOverview(),
          '/error': (context) => const GenericError(),
        },
      ));

      await tester.tap(find.text('Refferals overzicht'));
      await tester.pumpAndSettle();

     // Count the number of widget cards in the referral overview
      final cards = find.byType(Card);
      expect(cards, findsWidgets);
      expect(cards.evaluate().length, equals(2)); // Replace "2" with the expected number of cards
    });
  });
}