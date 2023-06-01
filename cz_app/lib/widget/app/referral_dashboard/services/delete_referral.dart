import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<void> deleteReferral(BuildContext context, int id) async {
  var url = Uri.https('flutter-backend.azurewebsites.net', '/api/referral/$id');

  try {
    var response = await http.delete(url, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });

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
  } catch (exception) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $exception')),
    );
  }
}
