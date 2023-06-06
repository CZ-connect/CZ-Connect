import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<void> deleteReferral(BuildContext context, int id) async {
  var host = dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net';
  var route = '/api/referral/$id';
  var url = Uri.http(host, route);
  if(host != dotenv.env['API_URL']) {
    url = Uri.https(host, route);
  }

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
