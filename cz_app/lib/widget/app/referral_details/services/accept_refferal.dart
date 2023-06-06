import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> acceptReffal(BuildContext context, dynamic referral) async {
  var id = referral.id.toString();
  var host = dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net';
  var route = '/api/referral/accept/$id';
  var url = Uri.http(host, route);
  if(host != dotenv.env['API_URL']) {
    url = Uri.https(host, route);
  }

  DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss")
      .parse(referral.registrationDate.toString());
  String formattedDateString = dateTime.toString().replaceFirst(' ', 'T');

  var phone = "";
  if (referral.participantPhoneNumber != null) {
    phone = referral.participantPhoneNumber.toString();
  }

  Map<String, dynamic> jsonMap = {
    'id': referral.id.toString(),
    'participantName': referral.participantName.toString(),
    'participantEmail': referral.participantEmail.toString(),
    'participantPhoneNumber': phone,
    'status': referral.status.toString(),
    'registrationDate': formattedDateString,
    'employeeId': referral.employeeId,
    'employee': null
  };

  var body = json.encode(jsonMap);

  try {
    var response = await http.put(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);

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
