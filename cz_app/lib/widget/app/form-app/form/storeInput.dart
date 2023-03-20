import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'formTextWidget.dart';
import 'model/form.model.dart';

final _formKey = GlobalKey<FormState>();
final dio = Dio();

class formWidget extends StatelessWidget {
  ModelForm modelForm = ModelForm(null, null);

//TODO implement dio on the backend architecture -> https://pub.dev/packages/dio#sending-formdata
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
                  onPressed: ()  {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
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
    final formData = FormData.fromMap({
      'name': modelForm.name,
      'email': modelForm.email,
    });
    
    final response = await dio.post('/api/applicantform', data: formData);
  }
}
