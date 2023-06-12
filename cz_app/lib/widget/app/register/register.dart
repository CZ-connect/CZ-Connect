import 'dart:convert';
import 'package:cz_app/widget/app/models/register_form.dart';
import 'package:cz_app/widget/app/register/register_form_text_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final response =
    await http.get(Uri.http('localhost:3000', '/api/department'));
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
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.registerFirstname ?? "",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.registerFirstNameRequired ?? "";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  modelForm.firstname = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.registerLastname ?? "",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    var registerLastNameRequired;
                    return AppLocalizations.of(context)?.registerLastNameRequired ?? "";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  modelForm.lastname = value;
                },
              ),
              TextFormField(
                key: const Key('email'),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.registerEmail ?? "",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.registerEmailRequired ?? "";
                  }
                  if (!EmailValidator.validate(value)) {
                    return AppLocalizations.of(context)?.registerValidEmail ?? "";
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
                  hintText: AppLocalizations.of(context)?.registerPassword ?? "",
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
                    return AppLocalizations.of(context)?.registerPasswordRequired ?? "";
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
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.registerRepeatPassword ?? "",
                ),
                validator: (String? value) {
                  if (value != passwordController.text) {
                    return AppLocalizations.of(context)?.registerPasswordsDoNotMatch ?? "";
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
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.registerSelectDepartment ?? "",
                ),
                items: departmentNames.map((String departmentName) {
                  return DropdownMenuItem<String>(
                    value: departmentName,
                    child: Text(departmentName),
                  );
                }).toList(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.registerDepartmentRequired ?? "";
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
                    sendForm(context);
                  }
                },
                child: Text(AppLocalizations.of(context)?.registerButton ?? ""),
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

  Future<void> sendForm(BuildContext context) async {
    var url = Uri.http('localhost:3000', '/api/employee/register');
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
          SnackBar(content: Text('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}')),
        );
        throw Exception('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}');
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}')),
        );
        throw Exception('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  AppLocalizations.of(context)?.registerSuccessMessage ?? "")),
        );
      }
    } catch (exception) {}
  }
}
