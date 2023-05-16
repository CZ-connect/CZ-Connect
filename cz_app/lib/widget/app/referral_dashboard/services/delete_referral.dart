import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<void> deleteReferral(BuildContext context, int id) async {
  var url = Uri.http('localhost:3000', '/api/referral/$id');

  try {
    var response = await http.delete(url,
        headers: {"Accept": "application/json","Content-Type": "application/json"});

    if (response.statusCode >= 400 && response.statusCode <= 499) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Client error: ${response.statusCode}')),
      );
      throw Exception('Client error: ${response.statusCode}');
    } else if (response.statusCode >= 500 && response.statusCode <= 599) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server error: ${response.statusCode}')),
      );
      throw Exception('Server error: ${response.statusCode}');
    }
  } catch (exception) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $exception')),
    );
  }
}