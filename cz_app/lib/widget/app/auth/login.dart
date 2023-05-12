import 'dart:convert';
import 'dart:developer';
import 'package:cz_app/widget/app/auth/auth_preferences.dart';
import 'package:cz_app/widget/app/auth/login_form_text_widget.dart';
import 'package:cz_app/widget/app/models/login_form.dart';
import 'package:cz_app/widget/app/referral_form/partials/form_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:go_router/go_router.dart';
import '../models/form.model.dart';
import 'package:http/http.dart' as http;

final _formKey = GlobalKey<FormState>();

class LoginWidget extends StatelessWidget {
  LoginForm modelForm = LoginForm(null, null);
  LoginWidget({super.key});

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
                const LoginContainerTextWidget(),
                TextFormField(
                  key: const Key('username'),
                  decoration: const InputDecoration(
                    hintText: 'Gebruikersnaam',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Het gebruikersnaamveld is een verplicht veld';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    modelForm.username = value;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Wachtwoord',
                  ),
                  validator: (String? value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Het wachtwoordveld is een verplicht veld';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    modelForm.password = value;
                  },
                ),
               const Padding(padding: EdgeInsets.all(8.0)),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      sendform(context);
                    }
                  },
                  child: const Text('Inloggen'),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> sendform(BuildContext context) async {
    var url = Uri.http('localhost:3000', '/api/employee/login');
    Map<String, dynamic> jsonMap = {
      'Username': modelForm.username.toString(),
      'Password': modelForm.password.toString(),
    };

    var body = json.encode(jsonMap);
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode >= 400 && response.statusCode <= 499) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
        throw Exception('Client error: ${response.statusCode}');
      }
     else if (response.statusCode == 200) {
        await UserPreferences.setUserFromToken(response.body);
        if (!UserPreferences.isLoggedIn()) {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: recieved token is invalid')),
        );
        } else {
          context.go('/');
        }
      }
      else if (response.statusCode >= 500 && response.statusCode <= 599) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
        throw Exception('Server error: ${response.statusCode}');
      }
      // return response.body;
    } catch (exception) {}
  }
}
