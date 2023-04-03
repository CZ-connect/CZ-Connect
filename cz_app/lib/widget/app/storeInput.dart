import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'formTextWidget.dart';

final _formKey = GlobalKey<FormState>();

class formWidget extends StatefulWidget {
  const formWidget({Key? key}) : super(key: key);

  @override
  State<formWidget> createState() => _formWidgetState();
}

class _formWidgetState extends State<formWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( body :Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                containerTextWidget(),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  validator: (String? value) {
                    if (value == null ||
                        value.isEmpty ||
                        !EmailValidator.validate(value)) {
                      return 'The email address is invalid';
                    }
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
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
    ));
  }
}
