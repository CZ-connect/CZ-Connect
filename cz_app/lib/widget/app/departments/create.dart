import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:cz_app/widget/app/models/department_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DepartmentCreationForm extends StatefulWidget {
  const DepartmentCreationForm({super.key});

  @override
  State<StatefulWidget> createState() => _DepartmentCreationForm();
}

class _DepartmentCreationForm extends State<DepartmentCreationForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DepartmentForm departmentForm = DepartmentForm(DepartmentName: null);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
          Text(
          AppLocalizations.of(context)!.createNewDepartmentText,
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        TextFormField(
          key: const Key('departmentNameField'),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)?.newDepartmentNameHint,
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)?.newDepartmentNameRequired ?? '';
            }
            return null;
          },
          onSaved: (String? value) {
            departmentForm.DepartmentName = value;
          },
        ),
        Padding(padding: EdgeInsets.all(8.0)),
        ElevatedButton(
          onPressed: () {
            formKey.currentState?.save();
            if (formKey.currentState!.validate()) {
              formKey.currentState?.save();
              sendForm(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.departmentCreatedSnackbarMessage),
                ),
              );
            }
            context.go('/department/index');
          },
          child: Text(AppLocalizations.of(context)!.createDepartmentButtonText),
      ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendForm(BuildContext context) async {
    var url = Uri.http('localhost:3000', '/api/department');
    Map<String, dynamic> jsonMap = {
      'departmentName': departmentForm.DepartmentName.toString(),
    };

    var body = json.encode(jsonMap);
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode >= 400 && response.statusCode <= 499) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}')),
        );
        throw Exception('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}');
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}')),
        );
        throw Exception('${AppLocalizations.of(context)?.appErrorPrefix}  ${response.statusCode}');
      }
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
