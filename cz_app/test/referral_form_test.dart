import 'dart:io';

import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:cz_app/widget/app/referral_form/store_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cz_app/widget/app/models/form.model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(body: FormWidget());
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
        AppLocalizations.delegate,
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
      Widget widget = MyApp();
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

      await tester.tap(find.text('Versturen'));
      await tester.pump();
      expect(jsonMap['name'].toString(), 'John Doe');
      expect(jsonMap['email'].toString(), 'johndoe@example.com');
    });

    testWidgets('Submitting invalid form should show error message',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      await tester.tap(find.text('Versturen'));
      await tester.pump();

      expect(find.text('Naam is een verplicht veld.'), findsOneWidget);
      expect(find.text('E-mailadres of telefoonnummer is een verplicht veld.'),
          findsWidgets);
    });

    test('Email validation', () {
      expect(EmailValidator.validate('johndoe@example.com'), true);
      expect(EmailValidator.validate('johndoe@example.'), false);
      expect(EmailValidator.validate('johndoe'), false);
    });
  });
}
