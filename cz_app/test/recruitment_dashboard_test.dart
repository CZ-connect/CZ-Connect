import 'package:cz_app/widget/app/recruitment_dashboard/recruitment_index.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
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
  group('Recruitment Dashboard', () {
    const expectedReferrals =
        '{"referrals":[{"id":30,"participantName":"Fleur Koster","participantEmail":"FleurKoster@example.com","status":"Goedgekeurd","registrationDate":"2022-08-08T00:00:00","employeeId":2,"employee":null},{"id":62,"participantName":"Mila van der Wal","participantEmail":"MilavanderWal@example.com","status":"Afgewezen","registrationDate":"2023-03-06T00:00:00","employeeId":2,"employee":null}],"completed":1,"pending":0}';
    const expectedDepartment =
        '[{"id":1,"departmentName":"Sales"},{"id":2,"departmentName":"Finance"},{"id":3,"departmentName":"Human Resources"},{"id":4,"departmentName":"Marketing"},{"id":5,"departmentName":"ICT"},{"id":6,"departmentName":"Recruitment"}]';
    testWidgets('Renders Departments correctly', (WidgetTester tester) async {
      final interceptorReferrals = nock.get("/referral/employee/2")
        ..reply(200, expectedReferrals);

      final interceptorDepartments = nock.get("/department")
        ..reply(200, expectedDepartment);

      await tester.pumpWidget(recruitmentDashboard);
      expect(interceptorReferrals.isDone, true);
      expect(interceptorDepartments.isDone, true);
    });
  });
}
