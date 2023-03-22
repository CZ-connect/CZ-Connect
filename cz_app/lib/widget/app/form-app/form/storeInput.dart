import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'formTextWidget.dart';
import 'model/form.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

final _formKey = GlobalKey<FormState>();

class formWidget extends StatelessWidget {
  ModelForm modelForm = ModelForm(null, null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                containerTextWidget(),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'John do',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'The name is required';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    modelForm.name = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'example@host.com',
                  ),
                  validator: (String? value) {
                    if (value == null ||
                        value.isEmpty ||
                        !EmailValidator.validate(value)) {
                      return 'The email address is invalid';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    modelForm.email = value;
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                     // _formKey.currentState?.save();
                      sendform();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> sendform() async {
    var url = Uri.http('localhost:3000', '/api/applicantform');
    Map<String, dynamic> jsonMap = {
      'name': modelForm.name.toString(),
      'email': modelForm.email.toString()
    };
    var body = json.encode(jsonMap);
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      // return response.body;
    } catch (exception) {
      print(exception.toString());
    }
  }
}
