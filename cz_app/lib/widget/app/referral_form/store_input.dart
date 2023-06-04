import 'dart:convert';
import 'package:cz_app/widget/app/referral_form/partials/form_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/form.model.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class FormWidget extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ModelForm modelForm = ModelForm(null, null);
  String? referral;
  FormWidget({super.key, this.referral});
  bool emailNumberFlag = false;
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
                const ContainerTextWidget(),
                TextFormField(
                  key: const Key('nameField'),
                  decoration: const InputDecoration(
                    hintText: 'Naam',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'De naam is een verplicht veld.';
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
                    if (!EmailValidator.validate(value!) && value.isNotEmpty) {
                      return 'Voer een geldig emailadres in';
                    } else if (modelForm.phoneNumber!.isEmpty &&
                        value.isEmpty) {
                      return 'Het emailadress of het telefoonnummer is een verplicht veld.';
                    }
                    emailNumberFlag = true;
                    return null;
                  },
                  onSaved: (String? value) {
                    modelForm.email = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '0612345678',
                  ),
                  validator: (String? value) {
                    RegExp regex = RegExp(
                        r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
                    if (!regex.hasMatch(value!) && value.isNotEmpty) {
                      return 'Voer een geldig telefoonnummer in.';
                    } else if (modelForm.email!.isEmpty && value.isEmpty) {
                      return 'Het emailadress of het telefoonnummer is een verplicht veld.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    modelForm.phoneNumber = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Website/Linkedin',
                  ),
                  validator: (String? value) {
                    RegExp regex = RegExp(
                        r"[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)");
                    if (!regex.hasMatch(value!) && value.isNotEmpty) {
                      return 'Dat is geen valide url.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    modelForm.linkedin = value;
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.save();
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
    var url = Uri.http(dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net', '/api/referral');
    Map<String, dynamic> jsonMap = {
      'participantName': modelForm.name.toString(),
      'participantEmail': modelForm.email.toString(),
      'status': 'Pending',
      'registrationDate': DateTime.now().toIso8601String(),
      'participantPhoneNumber': modelForm.phoneNumber.toString().isEmpty
          ? null
          : modelForm.phoneNumber.toString(),
      'employeeId': (referral != null) ? referral! : null,
      'linkedin': modelForm.linkedin.toString().isEmpty
          ? null
          : modelForm.linkedin.toString(),
    };

    var body = json.encode(jsonMap);
    try {
      var response = await http.post(url,
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
      // return response.body;
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
