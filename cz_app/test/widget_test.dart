import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cz_app/widget/app/form-app/form/formTextWidget.dart';
import 'package:cz_app/widget/app/form-app/form/model/form.model.dart';
import 'package:cz_app/widget/app/form-app/form/storeInput.dart';

void main() {
  group('Form Widget', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late ModelForm modelForm;
    late GlobalKey<FormState> formKey;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      modelForm = ModelForm(null, null);
      formKey = GlobalKey<FormState>();
    });

    testWidgets('testing form for formdata', (WidgetTester tester) async {
      final formData = FormData.fromMap({
        'name': 'John Doe',
        'email': 'johndoe@example.com',
      });


      final widget = MaterialApp(
        home: Scaffold(
          body: formWidget(),
        ),
      );
      await tester.pumpWidget(widget);

      await tester.enterText(
          find.byType(TextFormField).first, formData.fields[0].value);
      modelForm.name = formData.fields[0].value;
      await tester.enterText(
          find.byType(TextFormField).last, formData.fields[1].value);
      modelForm.email = formData.fields[1].value;

      await tester.tap(find.text('Submit'));
      await tester.pump();
      expect(modelForm.name, 'John Doe');
      expect(modelForm.email, 'johndoe@example.com');
    });

    testWidgets('Submitting invalid form should show error message',
        (WidgetTester tester) async {
      final widget = MaterialApp(
        home: Scaffold(
          body: formWidget(),
        ),
      );
      await tester.pumpWidget(widget);

      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(find.text('The name is required'), findsOneWidget);
      expect(find.text('The email address is invalid'), findsOneWidget);
    });

    test('Email validation', () {
      expect(EmailValidator.validate('johndoe@example.com'), true);
      expect(EmailValidator.validate('johndoe@example.'), false);
      expect(EmailValidator.validate('johndoe'), false);
    });
  });
}
