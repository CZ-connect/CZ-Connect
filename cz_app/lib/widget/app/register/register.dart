import 'dart:convert';
import 'package:cz_app/widget/app/models/register_form.dart';
import 'package:cz_app/widget/app/register/register_form_text_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../models/roles.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _formKeyLogin = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  RegisterForm modelForm = RegisterForm(null, null, null, null, null);
  List<String> departmentNames = [];
  String? selectedDepartment;

  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  Future<void> fetchDepartments() async {
    var url = Uri.http(dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net', '/api/department');
    final response =
        await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> departmentsJson = jsonDecode(response.body);
      setState(() {
        departmentNames = departmentsJson
            .map((department) => department['departmentName'] as String)
            .toList();
      });
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Form(
          key: _formKeyLogin,
          child: Column(
            children: <Widget>[
              const RegisterContainerTextWidget(),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Voornaam', // Last Name
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Het voornaamveld is verplicht';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  modelForm.firstname = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Achternaam', // Surname
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Het achternaamveld is verplicht';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  modelForm.lastname = value;
                },
              ),
              TextFormField(
                key: const Key('email'),
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Het e-mailveld is verplicht';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Voer een geldig e-mailadres in';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  modelForm.email = value;
                },
              ),
              TextFormField(
                obscureText: !_isPasswordVisible,
                enableSuggestions: false,
                autocorrect: false,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Wachtwoord', // Password
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: togglePasswordVisibility,
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Het wachtwoordveld is verplicht';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  modelForm.password = value;
                },
              ),
              TextFormField(
                obscureText: !_isPasswordVisible,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Herhaal Wachtwoord',
                ),
                validator: (String? value) {
                  if (value != passwordController.text) {
                    return 'De wachtwoorden komen niet overeen';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedDepartment,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDepartment = newValue;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Selecteer Afdeling',
                ),
                items: departmentNames.map((String departmentName) {
                  return DropdownMenuItem<String>(
                    value: departmentName,
                    child: Text(departmentName),
                  );
                }).toList(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Een afdeling moet worden geselecteerd';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  modelForm.department = value;
                },
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              ElevatedButton(
                onPressed: () {
                  if (_formKeyLogin.currentState!.validate()) {
                    _formKeyLogin.currentState?.save();
                    sendform(context);
                  }
                },
                child: const Text('Registeren'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> sendform(BuildContext context) async {
    var url = Uri.http(dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net', '/api/employee/register');
    Map<String, dynamic> jsonMap = {
      'email': modelForm.email.toString(),
      'password': modelForm.password.toString(),
      'name': "${modelForm.firstname} ${modelForm.lastname}",
      'department': modelForm.department,
      'role': Roles.Employee.name,
      'verified': false,
    };

    var body = json.encode(jsonMap);
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode >= 400 && response.statusCode <= 499) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
        throw Exception('Applicatie error: ${response.statusCode}');
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Applicatie error: ${response.statusCode}')),
        );
        throw Exception('Applicatie error: ${response.statusCode}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Aanmelding is successvol! Wacht nu tot uw account is geverifieerd.')),
        );
      }
    } catch (exception) {}
  }
}
