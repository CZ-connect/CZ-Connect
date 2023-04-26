import 'package:cz_app/widget/app/models/referral.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nock/nock.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';

GoRouter _router = GoRouter(
  routes: [
    GoRoute(
        path: '/referraldetail',
        builder: (context, state) {
          Referral referral = state.extra as Referral;
          return Scaffold(
            body: ReferralDashboardTemplate(
              header: ReferralDashboardTopWidget(),
              body: ReferralDashboardBottomWidget(
                child: ReferralDashboardContainerWidget(
                  child: ReferralDetailWidget(referral: referral),
                ),
              ),
            ),
          );
        }
    ),
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state){
          return const Scaffold(
            body: ReferralDashboardTemplate(
              header: ReferralDashboardTopWidget(),
              body: ReferralDashboardBottomWidget(
                child: ReferralDashboardContainerWidget(
                  child: ReferralDashboardIndexWidget(),
                ),
              ),
            ),
          );}
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
  setUpAll(() {
    nock.defaultBase = "http://localhost:3000/api";
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });
  const expectedJsonResponse =
      '{"referrals":[{"id":1,"participantName":"Coen","participantEmail":"koen@mail.com","status":"Goedgekeurd","registrationDate":"2023-03-22T00:00:00","employeeId":1,"employee":null},{"id":2,"participantName":"Koen van den Heuvel","participantEmail":"jos@exmaple.com","status":"Goedgekeurd","registrationDate":"2023-03-22T00:00:00","employeeId":1,"employee":null},{"id":3,"participantName":"Koen van den Heuvel","participantEmail":"koen@mail.com","status":"Goedgekeurd","registrationDate":"2023-03-22T00:00:00","employeeId":1,"employee":null},{"id":4,"participantName":"Willem Bollekam","participantEmail":"willi@mail.com","status":"In Afwachting","registrationDate":"2023-02-08T00:00:00","employeeId":1,"employee":null},{"id":5,"participantName":"Martijn van den Woud","participantEmail":"mvdw@mail.com","status":"Afgewezen","registrationDate":"2023-01-05T00:00:00","employeeId":1,"employee":null},{"id":6,"participantName":"Marin Kieplant","participantEmail":"plantje@mail.com","status":"In Afwachting","registrationDate":"2022-08-18T00:00:00","employeeId":2,"employee":null}],"completed":3,"pending":2}';
  group('Referral Details', () {
    testWidgets("Navigating to referral details page",
        (WidgetTester tester) async {
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
      //Load Async Widget
      await tester.runAsync(() async {
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
      });
      //Expect the data is loaded
      expect(interceptor.isDone, true);
      //Find text within table and click it
      await tester.tap(find.text("Coen"));
      //Wait for next widget to open
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
    });
  });
}
