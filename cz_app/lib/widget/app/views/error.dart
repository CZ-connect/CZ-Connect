import 'dart:async';
import 'package:flutter/material.dart';

class GenericError extends StatefulWidget {
  const GenericError({super.key});

  @override
  State<GenericError> createState() => _GenericErrorState();
}

class _GenericErrorState extends State<GenericError> {
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
        body: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Center(child: Text('Error: $message')),
    ));
  }
}
