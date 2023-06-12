import 'dart:io';

import 'package:cz_app/widget/app/referral_form/store_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cz_app/widget/app/models/form.model.dart';

void main() {
  group('Form Widget', () {
    setUpAll(() async {
      // ↓ required to avoid HTTP error 400 mocked returns
      HttpOverrides.global = null;
      TestWidgetsFlutterBinding.ensureInitialized();
      await dotenv.load(fileName: "env", isOptional: true); // Load dotenv parameters
    });
    
    late ModelForm modelForm;
    setUp(() {
      modelForm = ModelForm(null, null);
    });

    testWidgets('testing form for formdata', (WidgetTester tester) async {
      Widget widget = MaterialApp(
        home: Scaffold(
          body: FormWidget(),
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
      Widget widget = MaterialApp(
        home: Scaffold(
          body: FormWidget(),
        ),
      );
      await tester.pumpWidget(widget);

      await tester.tap(find.text('Verstuur'));
      await tester.pump();

      expect(find.text('De naam is een verplicht veld.'), findsOneWidget);
      expect(
          find.text(
              'Het emailadress of het telefoonnummer is een verplicht veld.'),
          findsWidgets);
    });

    test('Email validation', () {
      expect(EmailValidator.validate('johndoe@example.com'), true);
      expect(EmailValidator.validate('johndoe@example.'), false);
      expect(EmailValidator.validate('johndoe'), false);
    });
  });
}
