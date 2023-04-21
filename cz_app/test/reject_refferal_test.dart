import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:flutter/material.dart';
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

  Widget myapp = MaterialApp(
    title: 'CZ_connect',
    initialRoute: '/referraldashboard',
    routes: {
        '/referraldashboard': (context) => const Scaffold(
              body: ReferralDashboardTemplate(
                header: ReferralDashboardTopWidget(),
                body: ReferralDashboardBottomWidget(
                  child: ReferralDashboardContainerWidget(
                    child: ReferralDashboardIndexWidget(),
                  ),
                ),
              ),
            ),
        '/referraldetail': (context) => const Scaffold(
            body: ReferralDashboardTemplate(
              header: ReferralDashboardTopWidget(),
              body: ReferralDashboardBottomWidget(
                child: ReferralDashboardContainerWidget(
                  child: ReferralDetailWidget(),
                ),
              ),
            ),
          ),
    },
  );

   const expectedJsonResponse =
      '{"referrals":[{"id":1,"participantName":"Coen","participantEmail":"koen@mail.com","status":"Pending","registrationDate":"2023-03-22T00:00:00","employeeId":1,"employee":null},{"id":2,"participantName":"Koen van den Heuvel","participantEmail":"jos@exmaple.com","status":"Goedgekeurd","registrationDate":"2023-03-22T00:00:00","employeeId":1,"employee":null},{"id":3,"participantName":"Koen van den Heuvel","participantEmail":"koen@mail.com","status":"Goedgekeurd","registrationDate":"2023-03-22T00:00:00","employeeId":1,"employee":null},{"id":4,"participantName":"Willem Bollekam","participantEmail":"willi@mail.com","status":"In Afwachting","registrationDate":"2023-02-08T00:00:00","employeeId":1,"employee":null},{"id":5,"participantName":"Martijn van den Woud","participantEmail":"mvdw@mail.com","status":"Afgewezen","registrationDate":"2023-01-05T00:00:00","employeeId":1,"employee":null},{"id":6,"participantName":"Marin Kieplant","participantEmail":"plantje@mail.com","status":"In Afwachting","registrationDate":"2022-08-18T00:00:00","employeeId":2,"employee":null}],"completed":3,"pending":2}';
  const deniedReferralJsonResponse =
      '{"referrals":[{"id":1,"participantName":"Coen","participantEmail":"koen@mail.com","status":"Denied","registrationDate":"2023-03-22T00:00:00","employeeId":1,"employee":null},{"id":2,"participantName":"Koen van den Heuvel","participantEmail":"jos@exmaple.com","status":"Goedgekeurd","registrationDate":"2023-03-22T00:00:00","employeeId":1,"employee":null},{"id":3,"participantName":"Koen van den Heuvel","participantEmail":"koen@mail.com","status":"Goedgekeurd","registrationDate":"2023-03-22T00:00:00","employeeId":1,"employee":null},{"id":4,"participantName":"Willem Bollekam","participantEmail":"willi@mail.com","status":"In Afwachting","registrationDate":"2023-02-08T00:00:00","employeeId":1,"employee":null},{"id":5,"participantName":"Martijn van den Woud","participantEmail":"mvdw@mail.com","status":"Afgewezen","registrationDate":"2023-01-05T00:00:00","employeeId":1,"employee":null},{"id":6,"participantName":"Marin Kieplant","participantEmail":"plantje@mail.com","status":"In Afwachting","registrationDate":"2022-08-18T00:00:00","employeeId":2,"employee":null}],"completed":3,"pending":2}';

  group('Reject Referral', () {
    testWidgets('Click on a Referral succeeds',
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

      await tester.pumpWidget(myapp);
      await tester.pumpAndSettle();

      expect(interceptor.isDone, true);

      await tester.tap(find.text("Coen"));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('reject_key')));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
      expect(find.text("Denied"), findsOneWidget);
    });

    testWidgets('Can not reject a already denied referral ',
               (WidgetTester tester) async {
      final interceptor = nock.get("/referral")
        ..reply(
          200,
          deniedReferralJsonResponse,
        );
      nock.get("/referral").reply(
            200,
            deniedReferralJsonResponse,
      );
      nock.get("/referral").reply(
            200,
            deniedReferralJsonResponse,
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(myapp);
        await tester.pumpAndSettle();
      });

      expect(interceptor.isDone, true);

      await tester.tap(find.text("Coen"));
      await tester.pumpAndSettle();

      expect(interceptor.isDone, true);
      expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
      expect(find.text("Afkeuren"), findsNothing);
    });
  });
}
