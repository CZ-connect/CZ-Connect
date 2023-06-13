import 'package:cz_app/widget/app/auth/login.dart';
import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:nock/nock.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Create a MockClient using the Mock class provided by the Mockito package.
class MockClient extends Mock implements http.Client {}

GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(body: LoginWidget());
      })
]);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserPreferences.init();
    return MaterialApp.router(
      routerConfig: _router,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('nl'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}

void main() {
  const login = {"email": "andrew@gmail.com", "Password": "jello123"};
  setUpAll(() {
    nock.defaultBase = "http://localhost:3000/api";
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  // Test to check if the widget renders correctly
  testWidgets('LoginWidget should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(LoginWidget), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  // Test to check if the form validation works
  testWidgets('Form validation should work', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Try to submit form without filling fields
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify error messages
    expect(find.text('Het e-mailveld is verplicht'), findsOneWidget);
    expect(find.text('Het wachtwoordveld is verplicht'), findsOneWidget);

    // Fill form
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), '');
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
