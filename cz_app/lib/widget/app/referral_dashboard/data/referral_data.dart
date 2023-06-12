import 'dart:convert' show jsonDecode;
import 'package:flutter/cupertino.dart';

import '../../models/referral.dart' show Referral;
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferralData {
  Future<List<Referral>> fetchReferrals(int id, BuildContext context) async {
    final response = await http.get(
        Uri.parse('http://localhost:3000/api/referral/employee/$id'),
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
    final response = await http
        .get(Uri.parse('http://localhost:3000/api/referral/employee/$id'));

    return jsonDecode(response.body)["completed"];
  }

  Future<int> pendingCounter(int id) async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/api/referral/employee/$id'));

    return jsonDecode(response.body)["pending"];
  }
}
