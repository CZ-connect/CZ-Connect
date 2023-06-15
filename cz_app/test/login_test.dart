import 'package:cz_app/widget/app/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:nock/nock.dart';

// Create a MockClient using the Mock class provided by the Mockito package.
class MockClient extends Mock implements http.Client {}

void main() {
  const login = {"email": "andrew@gmail.com", "Password": "jello123"};
  setUpAll(() {
    nock.defaultBase = "https://flutter-backend.azurewebsites.net/api";
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  // Test to check if the widget renders correctly
  testWidgets('LoginWidget should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: LoginWidget())));
    expect(find.byType(LoginWidget), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  // Test to check if the form validation works
  testWidgets('Form validation should work', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: LoginWidget())));

    // Try to submit form without filling fields
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify error messages
    expect(find.text('Het emailveld is een verplicht veld'), findsOneWidget);
    expect(
        find.text('Het wachtwoordveld is een verplicht veld'), findsOneWidget);

    // Fill form
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), '');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Wachtwoord'), 's');
    await tester.pump();

    // Try to submit form again
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify no error messages
    expect(find.text('Het gebruikersnaamveld is een verplicht veld'),
        findsNothing);
    expect(find.text('Het wachtwoordveld is een verplicht veld'), findsNothing);
  });

  // Test to check if the form submission works
  testWidgets('Form submission should work', (WidgetTester tester) async {
    nock.post("/employee/login", login).reply(200, {});
    // // Verify the mock http client was called
    expect(find.text('Applicatie Error: 500'), findsNothing);
    expect(find.text('Applicatie Error: 400'), findsNothing);
    expect(find.text('Error: iets ging verkeerd'), findsNothing);

    var recordedRequest = nock.activeMocks.first;
    expect(recordedRequest, isNotNull);
    expect(recordedRequest.statusCode, 200);
  });
}
