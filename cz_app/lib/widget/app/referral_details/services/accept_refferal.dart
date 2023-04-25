import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AcceptRefferal {
  static Future<void> acceptRefferal(
      BuildContext context, dynamic referral) async {
    var id = referral.id.toString();
    var url = Uri.http('localhost:3000', '/api/referral/accept/$id');

    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(referral.registrationDate.toString());
    String formattedDateString = dateTime.toString().replaceFirst(' ', 'T');

    Map<String, dynamic> jsonMap = {
      'id': 4,
      'participantName': referral.participantName.toString(),
      'participantEmail': referral.participantEmail.toString(),
      'status': referral.status.toString(),
      'registrationDate': formattedDateString,
      'employeeId': 1,
      'employee': null
    };

    var body = json.encode(jsonMap);

    try {
      var response = await http.put(url,
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode >= 400 && response.statusCode <= 499) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Client error: ${response.statusCode}')),
        );
        throw Exception('Client error: ${response.statusCode}');
      }
    } catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Client error: $exception')),
      );
    }
  }
}
