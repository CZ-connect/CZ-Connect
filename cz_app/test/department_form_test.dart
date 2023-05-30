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
  late DepartmentForm departmentForm;
  setUpAll(() {
    nock.init();
    HttpOverrides.global = null;
  });

  setUp(() {
    departmentForm = DepartmentForm(DepartmentName: null);
    nock.cleanAll();
  });

  testWidgets('departmentForm builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(DepartmentCreationForm), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    Map<String, dynamic> jsonMap = {'DepartmentName': 'Test Department'};

    await tester.enterText(find.byKey(const Key('departmentNameField')),
        jsonMap['DepartmentName'].toString());

    departmentForm.DepartmentName = jsonMap['DepartmentName'].toString();

    await tester.tap(find.text('Afdeling aanmaken'));

    await tester.pump();

    expect(jsonMap['DepartmentName'].toString(), 'Test Department');
  });
}
