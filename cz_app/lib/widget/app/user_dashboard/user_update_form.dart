import 'dart:convert';
import 'package:cz_app/widget/app/models/register_form.dart';
import 'package:cz_app/widget/app/models/user_form.dart';
import 'package:cz_app/widget/app/register/register_form_text_widget.dart';
import 'package:cz_app/widget/app/user_dashboard/user_update_form_text_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



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
  UserForm modelForm = UserForm(null, null,  null, null);
  List<String> departmentNames = [];
  String? selectedDepartment;

  @override
  void initState() {
    super.initState();
    fetchDepartments();
    modelForm.department = widget.user.department;
    modelForm.role = widget.user.role;
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
       context.go('/userdashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return
       Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Form(
          key: _formKeyLogin,
          child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              UserUpdateContainerTextWidget(context: context),
              TextFormField(
                initialValue: widget.user.name,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.nameHintText,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.nameRequiredError;
                  }
                  return null;
                },
                onSaved: (String? value) {
                  modelForm.name = value;
                },
              ),
              TextFormField(
                initialValue: widget.user.email,
                key: const Key('email'),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.emailHintText,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.emailRequired;
                  }
                  if (!EmailValidator.validate(value)) {
                    return AppLocalizations.of(context)!.emailInvalidError;
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
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.selectDepartmentHint,
                ),
                items: departmentNames.map((String departmentName) {
                  return DropdownMenuItem<String>(
                    value: departmentName,
                    child: Text(departmentName),
                  );
                }).toList(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.selectDepartmentError;
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
                    modelForm.role = newValue?.name;
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
                    return AppLocalizations.of(context)!.selectRoleError;
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
                        Navigator.of(context).pop(false);
                      },
                      child: Text(AppLocalizations.of(context)!.cancelLabel),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKeyLogin.currentState!.validate()) {
                          _formKeyLogin.currentState?.save();
                          await sendform(context);
                          Navigator.of(context).pop(true);
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.editButton),
                    ),
                  ),
                ],
              )
            ],
        ),
    ));
  }

  Future<bool> sendform(BuildContext context) async {
    var url = Uri.http('localhost:3000', '/api/employee/${widget.user.id}');
    print(widget.user.id.toString());
    Map<String, dynamic> jsonMap = {
      'email': modelForm.email,
      'name': modelForm.name,
      'department': modelForm.department,
      'role': modelForm.role,
      'verified': widget.user.verified,
    };

    var body = json.encode(jsonMap);
    try {
      var response = await http.put(url,
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode >= 400 && response.statusCode <= 499) {
        ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}')),
        );
        throw Exception('Applicatie error: ${response.statusCode}');
      } else if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.userUpdatedSnackBar)),
          );
          return true;
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.userUpdatedSnackBar)),
        );
        throw Exception('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}');
      }
    } catch (exception) {
      return false;
    }
    return false;
  }
}
