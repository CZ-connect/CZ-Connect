import 'dart:convert';
import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:cz_app/widget/app/models/login_form.dart';
import 'package:cz_app/widget/app/auth/login_form_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginWidget extends StatelessWidget {
  GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  LoginForm modelForm = LoginForm(null, null);
  LoginWidget({Key? key}) : super(key: key);

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
              const LoginContainerTextWidget(),
              TextFormField(
                key: const Key('email'),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.emailHint,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.emailRequired;
                  }
                  return null;
                },
                onSaved: (String? value) {
                  modelForm.email = value;
                },
              ),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.passwordHint,
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)?.passwordRequired;
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
                  if (_formKeyLogin.currentState!.validate()) {
                    _formKeyLogin.currentState?.save();
                    sendForm(context);
                  }
                },
                child: Text(AppLocalizations.of(context)!.loginButton),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendForm(BuildContext context) async {
    var url = Uri.http('localhost:3000', '/api/employee/login');
    Map<String, dynamic> jsonMap = {
      'email': modelForm.email.toString(),
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
        throw Exception('Applicatie error: ${response.statusCode}');
      } else if (response.statusCode == 200) {
        await UserPreferences.setUserFromToken(response.body);
        if (!UserPreferences.isLoggedIn()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: iets ging verkeerd')),
          );
        } else {
          context.go('/');
        }
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Applicatie error: ${response.statusCode}')),
        );
        throw Exception('Applicatie error: ${response.statusCode}');
      }
      // return response.body;
    } catch (exception) {}
  }
}
