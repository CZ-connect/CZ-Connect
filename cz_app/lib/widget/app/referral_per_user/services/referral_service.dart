import 'dart:convert';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class ReferralService {
  int userId;
  List<Referral> referrals = [];

  ReferralService({required this.userId});

  Future<void> getData() async {
    var host = dotenv.env['API_URL'];
    var route = '/api/employee/referral/$userId';
    var url = Uri.http(host!, route);
    if(host.isEmpty) {
      url = Uri.https('flutter-backend.azurewebsites.net', route);
    }

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
