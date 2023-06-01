import 'dart:convert';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:http/http.dart';

class ReferralService {
  int userId;
  List<Referral> referrals = [];

  ReferralService({required this.userId});

  Future<void> getData() async {
    Response response = await get(
        Uri.parse('https://flutter-backend.azurewebsites.net/api/employee/referral/$userId'),
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
