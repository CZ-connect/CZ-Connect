import 'package:cz_app/widget/app/recruitment_dashboard/recruitment_index.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(); // Load dotenv parameters
    nock.defaultBase = "http://localhost:3000/api";
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  Widget recruitmentDashboard = MaterialApp(initialRoute: '/', routes: {
    '/': (context) => const Scaffold(
          body: ReferralDashboardTemplate(
            header: ReferralDashboardTopWidget(),
            body: ReferralDashboardBottomWidget(
              child: ReferralDashboardContainerWidget(
                child: RecruitmentDashboardIndexWidget(),
              ),
            ),
          ),
        ),
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
  });
  // Mock response for /api/departments API call
  const departmentsMock =
      '[{"id":0,"departmentName":"Sales"},{"id":2,"departmentName":"Finance"},{"id":3,"departmentName":"Human Resources"},{"id":4,"departmentName":"Marketing"},{"id":5,"departmentName":"ICT"},{"id":6,"departmentName":"Recruitment"}]';

  // Mock response for /api/employees API call for department 1
  const employeeMock =
      '[{"employee":{"id":0,"employeeName":"Daan de Vries","employeeEmail":"DaandeVries@example.com","departmentId":1,"department":null,"role":"Admin"},"referralCount":6}]';
  const unlinkedReferralsMock =
      '{"referral_data":[{"id":1001,"participantName":"Bob de Vries","status":"Pending","participantEmail":"bobdevries@example.com","linkedin":null,"participantPhoneNumber":null,"registrationDate":"2023-05-15T09:03:41.896","employeeId":null,"employee":null},{"id":1002,"participantName":"test2","status":"Pending","participantEmail":"test@test.test","linkedin":null,"participantPhoneNumber":null,"registrationDate":"2023-05-15T09:03:46.483","employeeId":null,"employee":null}]}';
  group('Recruitment Dashboard', () {
    testWidgets('test the dashboard row widget', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      // Set up the mocks
      final departmentInterceptor = nock.get("/department")
        ..reply(200, departmentsMock);

      final employeeInterceptor = nock.get("/employee/department/1")
        ..reply(200, employeeMock);
      final unlinkedReferralsInterceptor = nock.get("/referral/unlinked")
        ..reply(200, unlinkedReferralsMock);
      // Build the widget
      await tester.pumpWidget(recruitmentDashboard);
      await tester.pumpAndSettle();

      expect(departmentInterceptor.isDone, true);
      expect(employeeInterceptor.isDone, true);
      expect(unlinkedReferralsInterceptor.isDone, true);

      // Verify that the widget displays the correct data
      expect(find.text('Sales'), findsOneWidget);
      expect(find.text('Finance'), findsOneWidget);
      expect(find.text('Bob de Vries'), findsOneWidget);
    });
  });
}
