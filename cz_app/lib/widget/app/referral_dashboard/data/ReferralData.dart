import 'dart:convert';
import 'package:cz_app/widget/app/models/Referral.dart';
import 'package:http/http.dart' as http;

class ReferralData {
  Future<List<Referral>> fetchReferrals() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/referral'));

    if (response.statusCode == 200) {
      var referralObjsJson = jsonDecode(response.body)["referrals"] as List;
      List<Referral> referralObjs = referralObjsJson
          .map((referralJson) => Referral.fromJson(referralJson))
          .toList();
      return referralObjs;
    } else {
      throw Exception('Failed to load Referral');
    }
  }

  Future<int> completedCounter() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/referral'));

    return jsonDecode(response.body)["completed"];
  }

  Future<int> pendingCounter() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/referral'));

    return jsonDecode(response.body)["pending"];
  }
}
