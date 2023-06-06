import 'dart:io';

import 'package:cz_app/widget/app/departments/edit.dart';
import 'package:cz_app/widget/app/departments/index.dart';
import 'package:cz_app/widget/app/models/department.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:cz_app/widget/app/templates/departments/bottom.dart';
import 'package:cz_app/widget/app/templates/departments/container.dart';
import 'package:cz_app/widget/app/templates/departments/template.dart';
import 'package:cz_app/widget/app/templates/departments/top.dart';
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
                child: DepartmentIndex(),
              ),
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: '/department/:id/edit',
      name: 'editDepartment',
      builder: (BuildContext context, GoRouterState state) {
        id:
        state.params['id'];

        Department department = state.extra as Department;
        return Scaffold(
          body: DepartmentTemplate(
            header: const DepartmentTopWidget(),
            body: DepartmentBottomWidget(
              child: DepartmentContainerWidget(
                child: DepartmentUpdateWidget(
                  department: department,
                ),
              ),
            ),
          ),
        );
      },
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
    HttpOverrides.global = null;
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(); // Load dotenv parameters
    nock.defaultBase = "http://localhost:3000/api";
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  group('Index page for Departments', () {
    const expectedDepartments =
        '[{"id":1,"departmentName":"Klantenservice"},{"id":2,"departmentName":"Financiën"},{"id":3,"departmentName":"Personeelszaken"},{"id":4,"departmentName":"Marketing"}, {"id":5,"departmentName":"Test Department"}]';

    testWidgets('Department Index Builds', (WidgetTester tester) async {
      final departmentInterceptor = nock.get('/department')
        ..reply(200, expectedDepartments);
      await tester.pumpWidget(const MyApp());
      expect(departmentInterceptor.isDone, true);
      expect(find.byKey(const Key('Department_index_key')), findsOneWidget);
    });
  });
}
