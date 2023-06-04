import 'dart:convert' show jsonDecode;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/referral.dart' show Referral;
import 'package:http/http.dart' as http;

class ReferralData {
  Future<List<Referral>> fetchReferrals(int id) async {
    var url = Uri.http(dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net', '/api/referral/employee/$id');
    final response = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        });

    if (response.statusCode == 200) {
      var referralObjsJson = jsonDecode(response.body)["referrals"] as List;
      List<Referral> referralObjs = referralObjsJson
          .map((referralJson) => Referral.fromJson(referralJson))
          .toList();
      return referralObjs;
    } else {
      throw Exception('Aandrachten ophalen vanuit de backend is mislukt.');
    }
  }

  Future<int> completedCounter(int id) async {
    var url = Uri.http(dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net', '/api/referral/employee/$id');
    final response = await http
        .get(url);

    return jsonDecode(response.body)["completed"];
  }

  Future<int> pendingCounter(int id) async {
    var url = Uri.http(dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net', '/api/referral/employee/$id');
    final response = await http
        .get(url);

    return jsonDecode(response.body)["pending"];
  }
}
