import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:cz_app/widget/app/models/department.dart';
import 'package:cz_app/widget/app/models/department_form.dart';
import 'package:flutter/material.dart';

class DepartmentUpdateWidget extends StatefulWidget {
  final Department department;
  const DepartmentUpdateWidget({Key? key, required this.department})
      : super(key: key);

  @override
  _DepartmentUpdateWidget createState() => _DepartmentUpdateWidget();
}

class _DepartmentUpdateWidget extends State<DepartmentUpdateWidget> {
  final _formKeyDepartment = GlobalKey<FormState>();
  DepartmentForm departmentForm = DepartmentForm(DepartmentName: null);

  @override
  void initState() {
    departmentForm.DepartmentName = widget.department.departmentName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Form(
          key: _formKeyDepartment,
          child: Column(
            children: <Widget>[
              Text("Maak hier een nieuwe afdeling.",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
              TextFormField(
                key: const Key('departmentNameField'),
                initialValue: widget.department.departmentName,
                decoration:
                    const InputDecoration(hintText: 'Naam van de afdeling'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Een naam voor de afdeling is verplicht.';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  departmentForm.DepartmentName = value;
                },
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              ElevatedButton(
                onPressed: () {
                  _formKeyDepartment.currentState?.save();
                  if (_formKeyDepartment.currentState!.validate()) {
                    _formKeyDepartment.currentState?.save();
                    sendForm(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Afdeling aangepast.'),
                      ),
                    );
                  }
                  context.go('/department/index');
                },
                child: const Text('Afdeling aanpassen'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendForm(BuildContext context) async {
    var url =
        Uri.http(dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net', '/api/department/${widget.department.id}');
    Map<String, dynamic> jsonMap = {
      'departmentName': departmentForm.DepartmentName.toString(),
    };

    var body = json.encode(jsonMap);
    try {
      var response = await http.put(url,
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode >= 400 && response.statusCode <= 499) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Applicatie error: ${response.statusCode}')),
        );
        throw Exception('Applicatie error: ${response.statusCode}');
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Applicatie error: ${response.statusCode}')),
        );
        throw Exception('Applicatie error: ${response.statusCode}');
      }
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
