import 'package:cz_app/widget/app/models/referral.dart';
import 'package:cz_app/widget/app/referral_per_user/views/error.dart';
import 'package:cz_app/widget/app/referral_per_user/views/loading.dart';
import 'package:cz_app/widget/app/referral_per_user/views/referral_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nock/nock.dart';

GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoadingWidget(),
    ),
    GoRoute(
        path: '/referralOverview',
        builder: (context, state) {
          List<Referral> referrals = state.extra as List<Referral>;
          return ReferralOverview(referrals: referrals);
        }),
    GoRoute(
      path: '/error',
      builder: (context, state) => const ErrorScreen(),
    ),
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
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(); // Load dotenv parameters
    var host = dotenv.env['API_URL'];
    if(host!.isEmpty) {
      nock.defaultBase = "https://flutter-backend.azurewebsites.net/api";
    } else {
      nock.defaultBase = "http://localhost:3000/api";
    }
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  const expectedJsonResponse =
      '[{"id":52,"participantName":"Lynn van der Poel","status":"Pending","participantEmail":"EvivanVeen@example.com","linkedin":null,"participantPhoneNumber":null,"registrationDate":"2023-04-02T00:00:00","employeeId":1,"employee":null}]';
  MyApp myapp = const MyApp();

  group('Refferal Overview', () {
    testWidgets('Navigating to referral overview, displaying 2 referrals',
        (WidgetTester tester) async {
      final interceptor = nock
          .get("/employee/referral/0")
        ..reply(200, expectedJsonResponse);
      await tester.pumpWidget(myapp);
      await tester.pumpAndSettle();
      expect(interceptor.isDone, true);
      expect(find.byKey(const ValueKey('referral_overview')), findsOneWidget);
      expect(find.byType(Card).evaluate().length,
          equals(1)); // Replace "2" with the expected number of cards
    });

    testWidgets('Navigating to referral overview, displaying 0 referrals',
        (WidgetTester tester) async {
      final interceptor = nock
          .get("/employee/referral/0")
        ..reply(200, '[]');
      _router.go("/");
      await tester.pumpWidget(myapp);
      await tester.pumpAndSettle();
      expect(interceptor.isDone, true);
      expect(find.byKey(const ValueKey('referral_overview')), findsOneWidget);
      expect(find.byType(Card).evaluate().length,
          equals(0)); // Replace "2" with the expected number of cards
    });

    testWidgets(
        'Navigating to referral overview, failing to get referrals and displaying error',
        (WidgetTester tester) async {
      final interceptor = nock
          .get("/employee/referral/0")
        ..reply(404, '');
      _router.go("/");
      await tester.pumpWidget(myapp);
      expect(interceptor.isDone, true);
      await tester.pumpAndSettle();
      expect(find.byType(ErrorScreen), findsOneWidget);
    });

    testWidgets(
        'Navigating to referral overview, failing to get referrals, displaying error, navigating back to the menu',
        (WidgetTester tester) async {
      final interceptor = nock
          .get("/employee/referral/0")
        ..reply(200, expectedJsonResponse);
      _router.go("/");
      await tester.pumpWidget(myapp);
      await tester.pumpAndSettle();
      expect(interceptor.isDone, true);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(
          find.descendant(
              of: find.byType(Dialog), matching: find.text("Referentielink")),
          findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
    });
  });
}
