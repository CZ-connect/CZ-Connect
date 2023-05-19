import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String message = 'Aandrachten ophalen vanuit de backend is mislukt.';

    return Scaffold(
        key: const Key('error_screen'),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(child: Text('Error: $message')),
        ));
  }
}
