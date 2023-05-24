import 'dart:convert';
import 'package:cz_app/widget/app/models/register_form.dart';
import 'package:cz_app/widget/app/register/register_form_text_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../models/roles.dart';
import '../models/user.dart';

class UserUpdateWidget extends StatefulWidget {

  final User user;
  const UserUpdateWidget({Key? key, required this.user}) : super(key: key);

  @override
  _UserUpdateWidget createState() => _UserUpdateWidget();
}

class _UserUpdateWidget extends State<UserUpdateWidget> {
  final _formKeyLogin = GlobalKey<FormState>();
  RegisterForm modelForm = RegisterForm(null, null, null, null, null);
  List<String> departmentNames = [];
  String? selectedDepartment;

  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  Future<void> fetchDepartments() async {
    final response = await http.get(Uri.http('localhost:3000', '/api/department'));
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
    return
       Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        height: 300,
        child: Form(
          key: _formKeyLogin,
          child: Flexible(
            child:
          Column(
            children: <Widget>[
              const RegisterContainerTextWidget(),
              TextFormField(
                initialValue: widget.user.name,
                decoration: const InputDecoration(
                  hintText: 'Naam',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Het naam is verplicht';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  modelForm.firstname = value;
                },
              ),
              TextFormField(
                initialValue: widget.user.email,
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

              DropdownButtonFormField<String>(
                value: widget.user.department,
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
              DropdownButtonFormField<Roles>(
                value: Roles.values.firstWhere((element) => element.name == widget.user.role),
                onChanged: (Roles? newValue) {
                  setState(() {
                    //= newValue;
                  });
                },
                items: Roles.values.map<DropdownMenuItem<Roles>>((Roles role) {
                  return DropdownMenuItem<Roles>(
                    value: role,
                    child: Text(role.toString().split('.').last),
                  );
                }).toList(),
                validator: (Roles? value) {
                  if (value == null) {
                    return 'A value must be selected';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Anuleren'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKeyLogin.currentState!.validate()) {
                          _formKeyLogin.currentState?.save();
                          sendform(context);
                          Navigator.of(context).pop(true);
                        }
                      },
                      child: Text('Update'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
    ));
  }

  Future<void> sendform(BuildContext context) async {
    var url = Uri.http('localhost:3000', '/api/employee/${widget.user.id}');
    Map<String, dynamic> jsonMap = {
      'email': modelForm.email.toString(),
      'name': "$modelForm.firstname $modelForm.lastname",
      'department': modelForm.department,
      'role': Roles.Employee.name,
      'verified': widget.user.verified,
    };

    var body = json.encode(jsonMap);
    try {
      var response = await http.put(url,
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode >= 400 && response.statusCode <= 499) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
        throw Exception('Applicatie error: ${response.statusCode}');
      } else if (response.statusCode == 201) {
        print('asdfui');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Aanmelding is successvol! Wacht nu tot uw account is geverifieerd.')),
          );
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Applicatie error: ${response.statusCode}')),
        );
        throw Exception('Applicatie error: ${response.statusCode}');
      }
    } catch (exception) {
    }
  }
}
