import 'dart:convert';
import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:cz_app/widget/app/models/form.model.dart';
import 'package:cz_app/widget/app/referral_form/store_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    late MockEmployeeData mockEmployeeData;
    final modelForm = ModelForm(null, null);

    setUpAll(() {
      HttpOverrides.global = null;
    });
    setUp(() {
      mockEmployeeData = MockEmployeeData();
    });

    testWidgets('formWidget builds', (WidgetTester tester) async {
      var widget = MyApp();
      await tester.pumpWidget(widget);
      expect(find.byType(FormWidget), findsOneWidget);
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      var widget = MyApp();
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

      await tester.tap(find.text('Versturen'));
      await tester.pumpAndSettle();

      expect(jsonMap['name'].toString(), 'John Doe');
      expect(jsonMap['email'].toString(), 'johndoe@example.com');
    });
  });
}
