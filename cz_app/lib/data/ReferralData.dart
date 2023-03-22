import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Referral.dart';

class ReferralData {
  Future<List<Referral>> fetchReferrals() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/referrals/'));

    if (response.statusCode == 200) {
      var referralObjsJson = jsonDecode(response.body)['data'] as List;
      List<Referral> referralObjs = referralObjsJson
          .map((referralJson) => Referral.fromJson(referralJson))
          .toList();
      return referralObjs;
    } else {
      throw Exception('Failed to load Referral');
    }
  }
}
