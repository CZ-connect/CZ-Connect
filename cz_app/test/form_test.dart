import 'package:cz_app/widget/app/form-app/data/data.dart';
import 'package:cz_app/widget/app/form-app/form/storeInput.dart';
import 'package:cz_app/widget/app/form-app/model/form.model.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/storeInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

class MockEmployeeData extends Mock implements EmployeeData {}

void main() {
  group('formWidget', () {
    late MockEmployeeData mockEmployeeData;
    final employee =
        Employee.fromJson({'name': 'John Doe', 'email': 'test@gmail.com'});
    final modelForm = ModelForm(null, null, null);

    setUp(() {
      mockEmployeeData = MockEmployeeData();
    });

    testWidgets('formWidget builds', (WidgetTester tester) async {
      const widget = MaterialApp(
        home: Scaffold(
          body: FormWidget(),
        ),
      );
      await tester.pumpWidget(widget);
      expect(find.byType(FormWidget), findsOneWidget);
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      const widget = MaterialApp(
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
          find.byKey(const Key('nameField')),
          jsonMap['name'].toString()
      );
      modelForm.name = jsonMap['name'].toString();
      await tester.enterText(
          find.byType(TextFormField).last, jsonMap['email'].toString());
      modelForm.email = jsonMap['email'].toString();

      await tester.tap(find.text('Verstuur'));
      await tester.pumpAndSettle();

      expect(jsonMap['name'].toString(), 'John Doe');
      expect(jsonMap['email'].toString(), 'johndoe@example.com');
    });


    // testWidgets('displays error message if API request fails',
    //     (WidgetTester tester) async {
    //   when(mockEmployeeData.fetchEmployee())
    //       .thenAnswer((_) => Future.value(employee));
    //   final client = MockClient((request) async {
    //     return http.Response('Error', 400);
    //   });
    //
    //   await tester.pumpWidget(MaterialApp(
    //     home: Scaffold(body: FormWidget()),
    //   ));
    //
    //   // Fill in form data
    //   final nameField = find.widgetWithText(TextFormField, 'Naam');
    //   await tester.enterText(nameField, 'Test Name');
    //   final emailField =
    //       find.widgetWithText(TextFormField, 'voorbeeld@email.nl');
    //   await tester.enterText(emailField, 'test@email.com');
    //
    //   // Submit form
    //   final submitButton = find.widgetWithText(ElevatedButton, 'Verstuur');
    //   await tester.tap(submitButton);
    //   await tester.pump();
    // });
  });
}
