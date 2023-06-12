import 'dart:io';

import 'package:cz_app/widget/app/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nock/nock.dart';

void main() {

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: "env", isOptional: true); // Load dotenv parameters
    var host = dotenv.env['API_URL'];
    if(host!.isEmpty) {
      nock.defaultBase = "https://flutter-backend.azurewebsites.net/api";
    } else {
      nock.defaultBase = "http://localhost:3000/api";
    }
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('RegisterWidget Form submission successfull', (WidgetTester tester) async {

    final interceptor = nock
        .post("/employee/register")
      ..reply(201, "[]");

    final interceptorDeparments = nock
        .get("/department")
      ..reply(200, '[{"id":1,"departmentName":"Klantenservice"},{"id":2,"departmentName":"Financiën"},{"id":3,"departmentName":"Personeelszaken"},{"id":4,"departmentName":"Marketing"},{"id":5,"departmentName":"ICT"},{"id":6,"departmentName":"Recrutering"}]');

    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: RegisterWidget(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'John');
    await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
    await tester.enterText(find.byKey(const Key('email')), 'johndoe@example.com');
    await tester.enterText(find.byType(TextFormField).at(3), 'password');
    await tester.enterText(find.byType(TextFormField).at(4), 'password');

    final dropdown = find.byType(DropdownButtonFormField<String>);
    await tester.tap(dropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Klantenservice').last);
    await tester.pumpAndSettle();
    final registerButton = find.text('Registeren');
    await tester.tap(registerButton);
    await tester.pump();


    expect(interceptorDeparments.isDone, true);
    expect(find.text('Applicatie error'), findsNothing);


  });
}
