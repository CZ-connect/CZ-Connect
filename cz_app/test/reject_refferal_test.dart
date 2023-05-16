import 'package:cz_app/widget/app/models/employee_referral.dart';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
import 'package:cz_app/widget/app/referral_details/services/accept_refferal.dart';
import 'package:cz_app/widget/app/referral_details/services/reject_refferal.dart';
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
          EmployeeReferralViewModel? employeeReferral = state.extra as EmployeeReferralViewModel?;
          return Scaffold(
            body: ReferralDashboardTemplate(
              header: ReferralDashboardTopWidget(),
              body: ReferralDashboardBottomWidget(
                child: ReferralDashboardContainerWidget(
                  child: ReferralDetailWidget(employeeReferral: employeeReferral),
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

  Widget myapp = const MyApp();
  const referral =
      '{"id":1,"participantName":"Coen","participantEmail":"koen@mail.com","status":"Pending","participantPhoneNumber":null,"registrationDate":"2023-03-22T00:00:00","employeeId":0,"employee":null}';
  const expectedJsonResponse =
      '{"referrals":[{"id":15,"participantName":"Jesse Smit","status":"Pending","participantEmail":"JesseSmit@example.com","participantPhoneNumber":null,"registrationDate":"2022-11-02T00:00:00","employeeId":0,"employee":null},{"id":16,"participantName":"Noa van Beek","status":"Pending","participantEmail":"NoavanBeek@example.com","participantPhoneNumber":null,"registrationDate":"2022-01-24T00:00:00","employeeId":2,"employee":null},{"id":37,"participantName":"Noud Smits","status":"Pending","participantEmail":"NoudSmits@example.com","participantPhoneNumber":null,"registrationDate":"2022-06-11T00:00:00","employeeId":2,"employee":null},{"id":63,"participantName":"Thijs Kuijpers","status":"Approved","participantEmail":"ThijsKuijpers@example.com","participantPhoneNumber":null,"registrationDate":"2022-08-06T00:00:00","employeeId":2,"employee":null},{"id":65,"participantName":"Mees van Beek","status":"Approved","participantEmail":"MeesvanBeek@example.com","participantPhoneNumber":null,"registrationDate":"2022-09-02T00:00:00","employeeId":2,"employee":null},{"id":67,"participantName":"Sem Peters","status":"Approved","participantEmail":"SemPeters@example.com","participantPhoneNumber":null,"registrationDate":"2023-03-08T00:00:00","employeeId":2,"employee":null},{"id":70,"participantName":"Tess Vermeer","status":"Approved","participantEmail":"TessVermeer@example.com","participantPhoneNumber":null,"registrationDate":"2023-02-10T00:00:00","employeeId":2,"employee":null}],"completed":4,"pending":3}';
  const deniedReferralJsonResponse =
      '{"referrals":[{"id":15,"participantName":"Jesse Smit","status":"Denied","participantEmail":"JesseSmit@example.com","participantPhoneNumber":null,"registrationDate":"2022-11-02T00:00:00","employeeId":0,"employee":null},{"id":16,"participantName":"Noa van Beek","status":"Pending","participantEmail":"NoavanBeek@example.com","participantPhoneNumber":null,"registrationDate":"2022-01-24T00:00:00","employeeId":2,"employee":null},{"id":37,"participantName":"Noud Smits","status":"Pending","participantEmail":"NoudSmits@example.com","participantPhoneNumber":null,"registrationDate":"2022-06-11T00:00:00","employeeId":2,"employee":null},{"id":63,"participantName":"Thijs Kuijpers","status":"Approved","participantEmail":"ThijsKuijpers@example.com","participantPhoneNumber":null,"registrationDate":"2022-08-06T00:00:00","employeeId":2,"employee":null},{"id":65,"participantName":"Mees van Beek","status":"Approved","participantEmail":"MeesvanBeek@example.com","participantPhoneNumber":null,"registrationDate":"2022-09-02T00:00:00","employeeId":2,"employee":null},{"id":67,"participantName":"Sem Peters","status":"Approved","participantEmail":"SemPeters@example.com","participantPhoneNumber":null,"registrationDate":"2023-03-08T00:00:00","employeeId":2,"employee":null},{"id":70,"participantName":"Tess Vermeer","status":"Approved","participantEmail":"TessVermeer@example.com","participantPhoneNumber":null,"registrationDate":"2023-02-10T00:00:00","employeeId":2,"employee":null}],"completed":4,"pending":3}';
  group('Reject Referral', () {
    testWidgets('Click on a Referral succeeds', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      final interceptor = nock.get("/referral/employee/0")
        ..reply(
          200,
          expectedJsonResponse,
        );
      nock.get("/referral/employee/0").reply(
            200,
            expectedJsonResponse,
          );
      nock.get("/referral/employee/0").reply(
            200,
            expectedJsonResponse,
          );

      await tester.pumpWidget(myapp);
      await tester.pumpAndSettle();

      await tester.tap(find.text("Jesse Smit"));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('reject_key')));
      await tester.pumpAndSettle();

      expect(interceptor.isDone, true);
      expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
    });

    testWidgets('Can not reject a already denied referral ',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      final interceptor = nock.get("/referral/employee/0")
        ..reply(
          200,
          deniedReferralJsonResponse,
        );
      nock.get("/referral/employee/0").reply(
            200,
            deniedReferralJsonResponse,
          );
      nock.get("/referral/employee/0").reply(
            200,
            deniedReferralJsonResponse,
          );

      _router.go("/");
      await tester.runAsync(() async {
        await tester.pumpWidget(myapp);
        await tester.pumpAndSettle();
      });

      expect(interceptor.isDone, true);

      await tester.tap(find.text("Jesse Smit"));
      await tester.pumpAndSettle();

      expect(interceptor.isDone, true);
      expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
      expect(find.text("Afkeuren"), findsNothing);
    });

    testWidgets('Reject Referral service succeeds ',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      Referral ref = Referral(
          id: 1,
          status: "Pending",
          participantName: "Jesse Smit",
          employeeId: 0,
          registrationDate: DateTime.parse("2023-03-22T00:00:00"), linkedin: '');
      final interceptor = nock.get("/referral/employee/0")
        ..reply(
          200,
          expectedJsonResponse,
        );
      nock.get("/referral/employee/0").reply(
            200,
            expectedJsonResponse,
          );
      nock.get("/referral/employee/0").reply(
            200,
            expectedJsonResponse,
          );
      nock.put("/referral/1", referral).reply(200, {});

      _router.go("/");
      await tester.runAsync(() async {
        await tester.pumpWidget(myapp);
        await tester.pumpAndSettle();
      });

      expect(interceptor.isDone, true);

      await tester.tap(find.text("Jesse Smit"));
      await tester.pumpAndSettle();

      final BuildContext context = tester
          .element(find.byKey(const Key('reject_key'), skipOffstage: false));
      await rejectRefferal(context, ref);
      await tester.pumpAndSettle();
      expect(find.text('Server Error: 500'), findsNothing);
      expect(find.text('Client Error: 400'), findsNothing);
      expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
    });

    testWidgets('Reject Referral service bad request ',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      Referral ref = Referral(
          id: 1,
          employeeId: 0,
          status: "Pending",
          participantName: "Jesse Smit",
          registrationDate: DateTime.parse("2023-03-22T00:00:00"), linkedin: '');

      final interceptor = nock.get("/referral/employee/0")
        ..reply(
          200,
          expectedJsonResponse,
        );
      nock.get("/referral/employee/0").reply(
            200,
            expectedJsonResponse,
          );
      nock.get("/referral/employee/0").reply(
            200,
            expectedJsonResponse,
          );
      nock.put("/referral/1", referral).reply(400, {});

      _router.go("/");
      await tester.pumpWidget(myapp);
      await tester.pumpAndSettle();

      expect(interceptor.isDone, true);

      await tester.tap(find.text("Jesse Smit"));
      await tester.pumpAndSettle();

      final BuildContext context = tester
          .element(find.byKey(const Key('reject_key'), skipOffstage: false));
      await rejectRefferal(context, ref);
      await tester.pumpAndSettle();
      expect(find.text('Server Error: 500'), findsNothing);
      expect(find.text('Client Error: 400'), findsNothing);
      expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
    });
  });
  testWidgets('accept Referral service succeeds ', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    Referral ref = Referral(
        id: 1,
        status: "Pending",
        participantName: "Jesse Smit",
        employeeId: 0,
        registrationDate: DateTime.parse("2023-03-22T00:00:00"), linkedin: '');
    final interceptor = nock.get("/referral/employee/0")
      ..reply(
        200,
        expectedJsonResponse,
      );
    nock.get("/referral/employee/0").reply(
          200,
          expectedJsonResponse,
        );
    nock.get("/referral/employee/0").reply(
          200,
          expectedJsonResponse,
        );
    nock.put("/referral/1", referral).reply(200, {});

    _router.go("/");
    await tester.runAsync(() async {
      await tester.pumpWidget(myapp);
      await tester.pumpAndSettle();
    });

    expect(interceptor.isDone, true);

    await tester.tap(find.text("Jesse Smit"));
    await tester.pumpAndSettle();

    final BuildContext context = tester
        .element(find.byKey(const Key('approved_key'), skipOffstage: false));
    await acceptReffal(context, ref);
    await tester.pumpAndSettle();
    expect(find.text('Server Error: 500'), findsNothing);
    expect(find.text('Client Error: 400'), findsNothing);
    expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
  });

  testWidgets('Reject Referral service bad request ',
      (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    Referral ref = Referral(
        id: 1,
        employeeId: 0,
        status: "Pending",
        participantName: "Jesse Smit",
        registrationDate: DateTime.parse("2023-03-22T00:00:00"), linkedin: '');

    final interceptor = nock.get("/referral/employee/0")
      ..reply(
        200,
        expectedJsonResponse,
      );
    nock.get("/referral/employee/0").reply(
          200,
          expectedJsonResponse,
        );
    nock.get("/referral/employee/0").reply(
          200,
          expectedJsonResponse,
        );
    nock.put("/referral/1", referral).reply(400, {});

    _router.go("/");
    await tester.pumpWidget(myapp);
    await tester.pumpAndSettle();

    expect(interceptor.isDone, true);

    await tester.tap(find.text("Jesse Smit"));
    await tester.pumpAndSettle();
    final BuildContext context = tester
        .element(find.byKey(const Key('approved_key'), skipOffstage: false));
    await acceptReffal(context, ref);
    await tester.pumpAndSettle();
    expect(find.text('Server Error: 500'), findsNothing);
    expect(find.text('Client Error: 400'), findsNothing);
    expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
  });
}
