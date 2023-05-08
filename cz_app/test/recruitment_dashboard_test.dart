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
  // Mock response for /api/departments API call
  const departmentsMock =
      '[{"id":1,"departmentName":"Sales"},{"id":2,"departmentName":"Finance"},{"id":3,"departmentName":"Human Resources"},{"id":4,"departmentName":"Marketing"},{"id":5,"departmentName":"ICT"},{"id":6,"departmentName":"Recruitment"}]';

  // Mock response for /api/employees API call for department 1
  const employeeMock =
      '[{"id":1,"employeeName":"Daan de Vries","employeeEmail":"DaandeVries@example.com","departmentId":1,"department":null,"role":"Admin"},{"id":2,"employeeName":"Sofie Jansen","employeeEmail":"SofieJansen@example.com","departmentId":2,"department":null,"role":"Admin"},{"id":3,"employeeName":"Liam van der Berg","employeeEmail":"LiamvanderBerg@example.com","departmentId":2,"department":null,"role":"Admin"},{"id":4,"employeeName":"Emma van Dijk","employeeEmail":"EmmavanDijk@example.com","departmentId":2,"department":null,"role":"Admin"},{"id":5,"employeeName":"Lucas de Boer","employeeEmail":"LucasdeBoer@example.com","departmentId":2,"department":null,"role":"Admin"},{"id":6,"employeeName":"Julia Peters","employeeEmail":"JuliaPeters@example.com","departmentId":2,"department":null,"role":"Admin"},{"id":7,"employeeName":"Milan Bakker","employeeEmail":"MilanBakker@example.com","departmentId":2,"department":null,"role":"Admin"},{"id":8,"employeeName":"Sara van der Meer","employeeEmail":"SaravanderMeer@example.com","departmentId":3,"department":null,"role":"Admin"},{"id":9,"employeeName":"Levi Visser","employeeEmail":"LeviVisser@example.com","departmentId":3,"department":null,"role":"Admin"},{"id":10,"employeeName":"Lotte de Jong","employeeEmail":"LottedeJong@example.com","departmentId":3,"department":null,"role":"Admin"},{"id":11,"employeeName":"Luuk van den Brink","employeeEmail":"LuukvandenBrink@example.com","departmentId":3,"department":null,"role":"Admin"},{"id":12,"employeeName":"Zoë Hendriks","employeeEmail":"ZoëHendriks@example.com","departmentId":3,"department":null,"role":"Admin"},{"id":13,"employeeName":"Bram van Leeuwen","employeeEmail":"BramvanLeeuwen@example.com","departmentId":3,"department":null,"role":"Admin"},{"id":14,"employeeName":"Anna van der Linden","employeeEmail":"AnnavanderLinden@example.com","departmentId":4,"department":null,"role":"Admin"},{"id":15,"employeeName":"Jesse Smit","employeeEmail":"JesseSmit@example.com","departmentId":4,"department":null,"role":"Admin"},{"id":16,"employeeName":"Noa van Beek","employeeEmail":"NoavanBeek@example.com","departmentId":4,"department":null,"role":"Admin"},{"id":17,"employeeName":"Thijs van der Velde","employeeEmail":"ThijsvanderVelde@example.com","departmentId":4,"department":null,"role":"Admin"},{"id":18,"employeeName":"Tess Mulder","employeeEmail":"TessMulder@example.com","departmentId":4,"department":null,"role":"Admin"},{"id":19,"employeeName":"Finn Janssen","employeeEmail":"FinnJanssen@example.com","departmentId":4,"department":null,"role":"Admin"},{"id":20,"employeeName":"Eva Vermeer","employeeEmail":"EvaVermeer@example.com","departmentId":5,"department":null,"role":"Admin"},{"id":21,"employeeName":"Tim de Graaf","employeeEmail":"TimdeGraaf@example.com","departmentId":5,"department":null,"role":"Admin"},{"id":22,"employeeName":"Isa Kuijpers","employeeEmail":"IsaKuijpers@example.com","departmentId":5,"department":null,"role":"Admin"},{"id":23,"employeeName":"Julian Jacobs","employeeEmail":"JulianJacobs@example.com","departmentId":5,"department":null,"role":"Admin"},{"id":24,"employeeName":"Lynn Schouten","employeeEmail":"LynnSchouten@example.com","departmentId":5,"department":null,"role":"Admin"},{"id":25,"employeeName":"Sem Hoekstra","employeeEmail":"SemHoekstra@example.com","departmentId":5,"department":null,"role":"Admin"},{"id":26,"employeeName":"Evi Willemsen","employeeEmail":"EviWillemsen@example.com","departmentId":6,"department":null,"role":"Admin"},{"id":27,"employeeName":"Ruben van der Laan","employeeEmail":"RubenvanderLaan@example.com","departmentId":6,"department":null,"role":"Admin"},{"id":28,"employeeName":"Sarah Groen","employeeEmail":"SarahGroen@example.com","departmentId":6,"department":null,"role":"Admin"},{"id":29,"employeeName":"Tygo van der Pol","employeeEmail":"TygovanderPol@example.com","departmentId":6,"department":null,"role":"Admin"},{"id":30,"employeeName":"Fleur Koster","employeeEmail":"FleurKoster@example.com","departmentId":6,"department":null,"role":"Admin"}]';

  group('Recruitment Dashboard', () {
    testWidgets('test the dashboard row widget', (WidgetTester tester) async {
      // Set up the mocks
      final departmentInterceptor = nock.get('/department')
        ..reply(200, departmentsMock);
      expect(departmentInterceptor.isDone, true);

      final employeeInterceptor = nock.get('/employee?department=1')
        ..reply(200, employeeMock);
      expect(employeeInterceptor.isDone, true);

      // Build the widget
      await tester.pumpWidget(recruitmentDashboard);

      // Verify that the widget displays the correct data
      expect(find.text('IT'), findsOneWidget);
      expect(find.text('Marketing'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('johndoe@example.com'), findsOneWidget);
      expect(find.text('Referrals: 2'), findsOneWidget);

      // Tap the Marketing department button
      await tester.tap(find.text('Marketing'));
      await tester.pump();

      // Verify that the widget displays the updated data
      expect(find.text('Bob Smith'), findsOneWidget);
      expect(find.text('bobsmith@example.com'), findsOneWidget);
      expect(find.text('Referrals: 1'), findsOneWidget);
    });
  });
}
