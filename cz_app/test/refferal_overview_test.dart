import 'package:cz_app/widget/app/referral_per_user/views/error.dart';
import 'package:cz_app/widget/app/referral_per_user/views/loading.dart';
import 'package:cz_app/widget/app/referral_per_user/views/referral_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';

void main() {
  setUpAll(() {
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  Widget myapp = MaterialApp(
    title: 'CZ_connect',
    initialRoute: '/loading',
    routes: {
      '/loading': (context) => const LoadingWidget(),
      '/referralOverview': (context) => const ReferralOverview(),
      '/error': (context) => const ErrorScreen(),
    },
  );

  const expectedJsonResponse =
      '[{"id":13,"participantName":"John Doe","participantEmail":"john.doe@email.com","status":"New","registrationDate":"2022-01-01T00:00:00","employeeId":1,"employee":null},{"id":14,"participantName":"Jane Smith","participantEmail":"jane.smith@email.com","status":"Pending","registrationDate":"2022-02-15T00:00:00","employeeId":1,"employee":null}]';

  group('Refferal Overview', () {
    testWidgets('Navigating to referral overview, displaying 2 referrals',
        (WidgetTester tester) async {
      final interceptor = nock("http://localhost:3000/api").get("/referral/1")
        ..reply(200, expectedJsonResponse);
      await tester.pumpWidget(myapp);

      await tester.tap(find.text('Referrals overzicht'));
      await tester.pumpAndSettle();
      expect(interceptor.isDone, true);
      expect(find.byKey(const ValueKey('referral_overview')), findsOneWidget);
      expect(find.byType(Card).evaluate().length,
          equals(2)); // Replace "2" with the expected number of cards
    });

    testWidgets('Navigating to referral overview, displaying 0 referrals',
        (WidgetTester tester) async {
      final interceptor = nock("http://localhost:3000/api").get("/referral/1")
        ..reply(200, '[]');
      await tester.pumpWidget(myapp);

      await tester.tap(find.text('Referrals overzicht'));
      await tester.pumpAndSettle();
      expect(interceptor.isDone, true);
      expect(find.byKey(const ValueKey('referral_overview')), findsOneWidget);
      expect(find.byType(Card).evaluate().length,
          equals(0)); // Replace "2" with the expected number of cards
    });

    testWidgets(
        'Navigating to referral overview, failing to get referrals, displaying error, navigating back to the menu',
        (WidgetTester tester) async {
      final interceptor = nock("http://localhost:3000/api").get("/referral/1")
        ..reply(500, '');
      await tester.pumpWidget(myapp);

      await tester.tap(find.text('Referrals overzicht'));
      await tester.pumpAndSettle();
      expect(interceptor.isDone, true);
      expect(find.text('Error: Referrals konden niet worden opgehaald'),
          findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('Referrals overzicht'), findsOneWidget);
    });
  });
}
