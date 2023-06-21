import 'dart:convert' show jsonDecode;
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/referral.dart' show Referral;
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferralData {
  Future<List<Referral>> fetchReferrals(int id, BuildContext context) async {
    var host = dotenv.env['API_URL'];
    var route = '/api/referral/employee/$id';
    var url = Uri.http(host!, route);
    if(host.isEmpty) {
      url = Uri.https('flutter-backend.azurewebsites.net', route);
    }

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
      throw Exception(AppLocalizations.of(context)?.failedToRetrieveDepartments);
    }
  }

  Future<int> completedCounter(int id) async {
    var host = dotenv.env['API_URL'];
    var route = '/api/referral/employee/$id';
    var url = Uri.http(host!, route);
    if(host.isEmpty) {
      url = Uri.https('flutter-backend.azurewebsites.net', route);
    }

    final response = await http
        .get(url);

    return jsonDecode(response.body)["completed"];
  }

  Future<int> pendingCounter(int id) async {
    var host = dotenv.env['API_URL'];
    var route = '/api/referral/employee/$id';
    var url = Uri.http(host!, route);
    if(host.isEmpty) {
      url = Uri.https('flutter-backend.azurewebsites.net', route);
    }
    
    final response = await http
        .get(url);

    return jsonDecode(response.body)["pending"];
  }
}
