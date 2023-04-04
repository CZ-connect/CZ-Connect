import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cz_app/widget/app/form-app/model/form.model.dart';
import 'package:cz_app/widget/app/form-app/form/storeInput.dart';

void main() {
  group('Form Widget', () {
    late ModelForm modelForm;
    setUp(() {
      modelForm = ModelForm(null, null);
    });

    testWidgets('testing form for formdata', (WidgetTester tester) async {
      final widget = MaterialApp(
        home: Scaffold(
          body: formWidget(),
        ),
      );
      await tester.pumpWidget(widget);
      Map<String, dynamic> jsonMap = {
        'name': "John Doe",
        'email': "johndoe@example.com"
      };
      await tester.enterText(
          find.byType(TextFormField).first, jsonMap['name'].toString());
      modelForm.name = jsonMap['name'].toString();
      await tester.enterText(
          find.byType(TextFormField).last, jsonMap['email'].toString());
      modelForm.email = jsonMap['email'].toString();

      await tester.tap(find.text('Verstuur'));
      await tester.pump();
      expect(jsonMap['name'].toString(), 'John Doe');
      expect(jsonMap['email'].toString(), 'johndoe@example.com');
    });

    testWidgets('Submitting invalid form should show error message',
        (WidgetTester tester) async {
      final widget = MaterialApp(
        home: Scaffold(
          body: formWidget(),
        ),
      );
      await tester.pumpWidget(widget);

      await tester.tap(find.text('Verstuur'));
      await tester.pump();

      expect(find.text('De naam is een verplicht veld'), findsOneWidget);
      expect(find.text('Het emailadres is een verplicht veld'), findsOneWidget);
    });

    test('Email validation', () {
      expect(EmailValidator.validate('johndoe@example.com'), true);
      expect(EmailValidator.validate('johndoe@example.'), false);
      expect(EmailValidator.validate('johndoe'), false);
    });
  });
}
