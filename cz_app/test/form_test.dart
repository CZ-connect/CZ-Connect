import 'package:cz_app/widget/app/form-app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import '../lib/widget/app/models/employee.dart';
import '../lib/widget/app/models/form.model.dart';
import '../lib/widget/app/referral_form/form/storeInput.dart';
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
