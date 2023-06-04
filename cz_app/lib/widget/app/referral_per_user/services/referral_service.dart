import 'dart:convert';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class ReferralService {
  int userId;
  List<Referral> referrals = [];

  ReferralService({required this.userId});

  Future<void> getData() async {
    var url = Uri.http(dotenv.env['API_URL'] ?? 'flutter-backend.azurewebsites.net', '/api/employee/referral/$userId');
    Response response = await get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        });
    List data = jsonDecode(response.body) as List;

    referrals =
        data.map((referralJson) => Referral.fromJson(referralJson)).toList();
  }
}
