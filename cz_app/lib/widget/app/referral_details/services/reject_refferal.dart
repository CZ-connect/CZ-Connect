import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> rejectRefferal(BuildContext context, dynamic referral) async {
    var id = referral.id.toString();
    var url = Uri.http('localhost:3000', '/api/referral/$id');

    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(referral.registrationDate.toString());
    String formattedDateString = dateTime.toString().replaceFirst(' ', 'T');
    var phone;
    if(referral.participantPhoneNumber != null) {
      phone = referral.participantPhoneNumber.toString();
    }

    Map<String, dynamic> jsonMap = {
      'id': referral.id.toString(),
      'participantName': referral.participantName.toString(),
      'participantEmail': referral.participantEmail.toString(),
      'participantPhoneNumber': phone,
      'status': referral.status.toString(),
      'registrationDate': formattedDateString,
      'employeeId': referral.employeeId.toString(),
      'employee': null
    };

    var body = json.encode(jsonMap);

    try {
      var response = await http.put(url,
          headers: {"Accept": "application/json","Content-Type": "application/json"}, body: body);

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
