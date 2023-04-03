import 'dart:async';
import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  Map? data = {};

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    data = (data?.isNotEmpty ?? false)
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map?;
    String message = data?['message'] ?? 'Iets ging verkeerd';

    return Scaffold(
        key: const Key('error_screen'),
        body: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Center(child: Text('Error: $message')),
    ));
  }
}
