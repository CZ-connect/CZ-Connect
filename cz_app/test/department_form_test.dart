import 'dart:convert';
import 'dart:io';
import 'package:cz_app/widget/app/departments/index.dart';
import 'package:cz_app/widget/app/templates/departments/bottom.dart';
import 'package:cz_app/widget/app/templates/departments/container.dart';
import 'package:cz_app/widget/app/templates/departments/template.dart';
import 'package:cz_app/widget/app/templates/departments/top.dart';
import 'package:go_router/go_router.dart';
import 'package:cz_app/widget/app/departments/create.dart';
import 'package:cz_app/widget/app/models/department_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:nock/nock.dart';

GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Scaffold(
          body: DepartmentTemplate(
            header: DepartmentTopWidget(),
            body: DepartmentBottomWidget(
              child: DepartmentContainerWidget(
                child: DepartmentCreationForm(),
              ),
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: '/department/index',
      builder: (BuildContext context, GoRouterState state) {
        return const Scaffold(
          body: DepartmentTemplate(
            header: DepartmentTopWidget(),
            body: DepartmentBottomWidget(
              child: DepartmentContainerWidget(
                child: DepartmentIndex(),
              ),
            ),
          ),
        );
      },
    ),
  ],
);

class Department {
  String? DepartmentName;
  Department(this.DepartmentName);

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(json['DepartmentName'] as String?);
  }
}

class DepartmentData {
  Future<Department?> fetchDepartment() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/department/1'));
    if (response.statusCode == 200) {
      return Department.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load department');
    }
  }
}

class MockDepartmentData extends Mock implements DepartmentData {}

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
  late MockDepartmentData mockDepartmentData;
  final departmentForm = DepartmentForm(DepartmentName: null);

  setUpAll(() async {
    nock.defaultBase = "http://localhost:3000/api";
    nock.init();
    HttpOverrides.global = null;
  });

  setUp(() => mockDepartmentData = MockDepartmentData());
  const expectedDepartments =
      '[{"id":1,"departmentName":"Klantenservice"},{"id":2,"departmentName":"Financiën"},{"id":3,"departmentName":"Personeelszaken"},{"id":4,"departmentName":"Marketing"}, {"id":5,"departmentName":"Test Department"}]';

  testWidgets('departmentForm builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(DepartmentCreationForm), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    Map<String, dynamic> jsonMap = {'DepartmentName': 'Test Department'};

    await tester.enterText(find.byKey(const Key('departmentNameField')),
        jsonMap['DepartmentName'].toString());
    departmentForm.DepartmentName = jsonMap['DepartmentName'].toString();

    await tester.tap(find.text('Afdeling aanmaken'));
    final interceptor = nock.get("/department")
      ..reply(200, expectedDepartments);

    expect(interceptor.isDone, true);
    await tester.pumpAndSettle();

    expect(jsonMap['DepartmentName'].toString(), 'Test Department');
  });
}
