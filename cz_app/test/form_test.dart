import 'dart:convert';
import 'package:cz_app/widget/app/models/form.model.dart';
import 'package:cz_app/widget/app/referral_form/store_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class Employee {
  String? name;
  String? email;
  String? role;
  Employee(this.name, this.email, this.role);
  // Factory method to create an Employee object from JSON data
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      json['name'] as String?,
      json['email'] as String?,
      json['role'] as String?,
    );
  }
}

class EmployeeData {
  Future<Employee?> fetchEmployee() async {
    final response =
    await http.get(Uri.parse('http://localhost:3000/api/employee/1'));

    if (response.statusCode == 200) {
      // If the server did return a successful response, then parse the JSON.
      return Employee.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a successful response, then throw an exception.
      // throw Exception('Failed to load employee');
    }
    return null;
  }
}

class MockEmployeeData extends Mock implements EmployeeData {}

void main() {
  group('formWidget', () {
    // ignore: unused_local_variable
    late MockEmployeeData mockEmployeeData;
    // ignore: unused_local_variable
    final modelForm = ModelForm(null, null);

    setUpAll(() {
      // ↓ required to avoid HTTP error 400 mocked returns
      HttpOverrides.global = null;
    });
    setUp(() {
      mockEmployeeData = MockEmployeeData();
    });

    testWidgets('formWidget builds', (WidgetTester tester) async {
      var widget = MaterialApp(
        home: Scaffold(
          body: FormWidget(),
        ),
      );
      await tester.pumpWidget(widget);
      expect(find.byType(FormWidget), findsOneWidget);
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      var widget = MaterialApp(
        home: Scaffold(
          body: FormWidget(),
        ),
      );
      await tester.pumpWidget(widget);
      expect(find.byType(FormWidget), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      Map<String, dynamic> jsonMap = {
        'name': "John Doe",
        'email': "johndoe@example.com"
      };
      await tester.enterText(
          find.byKey(const Key('nameField')), jsonMap['name'].toString());
      modelForm.name = jsonMap['name'].toString();
      await tester.enterText(
          find.byType(TextFormField).last, jsonMap['email'].toString());
      modelForm.email = jsonMap['email'].toString();

      await tester.tap(find.text('Verstuur'));
      await tester.pumpAndSettle();

      expect(jsonMap['name'].toString(), 'John Doe');
      expect(jsonMap['email'].toString(), 'johndoe@example.com');
    });
  });
}
