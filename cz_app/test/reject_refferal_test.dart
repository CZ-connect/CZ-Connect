import 'package:cz_app/widget/app/views/error.dart';
import 'package:cz_app/widget/app/views/loading.dart';
import 'package:cz_app/widget/app/views/menu.dart';
import 'package:cz_app/widget/app/views/referralOverview.dart';
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
    initialRoute: '/',
    routes: {
      '/': (context) => const Menu(),
      '/loading': (context) => const LoadingWidget(),
      '/referralOverview': (context) => const ReferralOverview(),
      '/error': (context) => const ErrorScreen(),
    },
  );

  const expectedJsonResponse =
      '[{"id":13,"participantName":"John Doe","participantEmail":"john.doe@email.com","status":"New","registrationDate":"2022-01-01T00:00:00","employeeId":1,"employee":null},{"id":14,"participantName":"Jane Smith","participantEmail":"jane.smith@email.com","status":"Pending","registrationDate":"2022-02-15T00:00:00","employeeId":1,"employee":null}]';
  const expectedJsonResponseAlreadyRejected = 
      '[{"id":13,"participantName":"John Doe","participantEmail":"john.doe@email.com","status":"Afgekeurd","registrationDate":"2022-01-01T00:00:00","employeeId":1,"employee":null},{"id":14,"participantName":"Jane Smith","participantEmail":"jane.smith@email.com","status":"Afgekeurd","registrationDate":"2022-02-15T00:00:00","employeeId":1,"employee":null}]';

  group('Reject Referral', () {
    testWidgets('Click on a Referral succeeds',
        (WidgetTester tester) async {
      final interceptor = nock("http://localhost:3000/api").get("/referral/1")
        ..reply(200, expectedJsonResponse);
      await tester.pumpWidget(myapp);

      await tester.tap(find.text('Referrals overzicht'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();

      expect(interceptor.isDone, true);
      expect(find.byKey(const ValueKey('referral_overview')), findsOneWidget);
      expect(find.text("Afgekeurd"), findsOneWidget);
      
    });

    testWidgets('Can not find a referral ',
        (WidgetTester tester) async {
      final interceptor = nock("http://localhost:3000/api").get("/referral/1")
        ..reply(200, expectedJsonResponseAlreadyRejected);
      await tester.pumpWidget(myapp);

      await tester.tap(find.text('Referrals overzicht'));
      await tester.pumpAndSettle();

      expect(interceptor.isDone, true);
      expect(find.byKey(const ValueKey('referral_overview')), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
      expect(find.text("Afkeuren"), findsNothing);
    });
  });
}
