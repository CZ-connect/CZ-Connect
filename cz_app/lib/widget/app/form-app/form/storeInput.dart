import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'formTextWidget.dart';
import '../model/form.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

final _formKey = GlobalKey<FormState>();

class formWidget extends StatelessWidget {
  ModelForm modelForm = ModelForm(null, null);
  formWidget({super.key});

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
                    hintText: 'Naam',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'De naam is een verplicht veld';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    modelForm.name = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'voorbeeld@email.nl',
                  ),
                  validator: (String? value) {
                    if (value == null ||
                        value.isEmpty ||
                        !EmailValidator.validate(value)) {
                      return 'Het emailadres is een verplicht veld';
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
                      _formKey.currentState?.save();
                      sendform(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Informatie afhandelen')),
                      );
                    }
                  },
                  child: const Text('Verstuur'),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> sendform(BuildContext context) async {
    var url = Uri.http('localhost:3000', '/api/applicantform');
    Map<String, dynamic> jsonMap = {
      'name': modelForm.name.toString(),
      'email': modelForm.email.toString()
    };
    var body = json.encode(jsonMap);
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode >= 400 && response.statusCode <= 499) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Client error: ${response.statusCode}')),
        );
        throw Exception('Client error: ${response.statusCode}');
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
        throw Exception('Server error: ${response.statusCode}');
      }
      // return response.body;
    } catch (exception) {
      print(exception.toString());
    }
  }
}
