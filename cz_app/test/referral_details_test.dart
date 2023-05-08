import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';

void main() {
  setUpAll(() {
    nock.defaultBase = "http://localhost:3000/api";
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });
  Widget referralDashboard = MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Scaffold(
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
      '{"referrals":[{"id":15,"participantName":"Jesse Smit","status":"Pending","participantEmail":"JesseSmit@example.com","participantPhoneNumber":null,"registrationDate":"2022-11-02T00:00:00","employeeId":2,"employee":null},{"id":16,"participantName":"Noa van Beek","status":"Pending","participantEmail":"NoavanBeek@example.com","participantPhoneNumber":null,"registrationDate":"2022-01-24T00:00:00","employeeId":2,"employee":null},{"id":37,"participantName":"Noud Smits","status":"Pending","participantEmail":"NoudSmits@example.com","participantPhoneNumber":null,"registrationDate":"2022-06-11T00:00:00","employeeId":2,"employee":null},{"id":63,"participantName":"Thijs Kuijpers","status":"Approved","participantEmail":"ThijsKuijpers@example.com","participantPhoneNumber":null,"registrationDate":"2022-08-06T00:00:00","employeeId":2,"employee":null},{"id":65,"participantName":"Mees van Beek","status":"Approved","participantEmail":"MeesvanBeek@example.com","participantPhoneNumber":null,"registrationDate":"2022-09-02T00:00:00","employeeId":2,"employee":null},{"id":67,"participantName":"Sem Peters","status":"Approved","participantEmail":"SemPeters@example.com","participantPhoneNumber":null,"registrationDate":"2023-03-08T00:00:00","employeeId":2,"employee":null},{"id":70,"participantName":"Tess Vermeer","status":"Approved","participantEmail":"TessVermeer@example.com","participantPhoneNumber":null,"registrationDate":"2023-02-10T00:00:00","employeeId":2,"employee":null}],"completed":4,"pending":3}';
  group('Referral Details', () {
    testWidgets("Navigating to referral details page",
        (WidgetTester tester) async {
      final interceptor = nock.get("/referral/employee/2")
        ..reply(
          200,
          expectedJsonResponse,
        );

      nock.get("/referral/employee/2").reply(
            200,
            expectedJsonResponse,
          );

      nock.get("/referral/employee/2").reply(
            200,
            expectedJsonResponse,
          );
      //Load Async Widget
      await tester.runAsync(() async {
        await tester.pumpWidget(referralDashboard);
        await tester.pumpAndSettle();
      });
      //Expect the data is loaded
      expect(interceptor.isDone, true);
      //Find text within table and click it
      final firstRow = find.byType(DataRow).first;
      final widgetsInFirstRow = tester.widgetList(firstRow).toList();
      final clickableWidget =
          widgetsInFirstRow.firstWhere((widget) => widget is GestureDetector);

      // Tap on the clickable widget
      await tester.tap(find.byWidget(clickableWidget));
      //Wait for next widget to open
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('referral_details')), findsOneWidget);
    });
  });
}
