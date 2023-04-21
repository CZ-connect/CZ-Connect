import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RejectReferral {

  static Future<void> rejectRefferal(BuildContext context, dynamic referral) async {
    var id = referral.id.toString();
    var url = Uri.http('localhost:3000', '/api/referral/$id');

    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(referral.registrationDate.toString());
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Client error: ${response.statusCode}')),
        );
         throw Exception('Client error: ${response.statusCode}');
     } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
        throw Exception('Server error: ${response.statusCode}'); 
      }
    } catch (exception) {}
  }
}

