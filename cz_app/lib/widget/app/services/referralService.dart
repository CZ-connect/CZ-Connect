import 'dart:convert';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:http/http.dart';

class ReferralService {
  int userId;
  //List<Referral> referrals;
  List<Referral> referrals = [];

  ReferralService({required this.userId});

  Future<void> getData() async {
     Response response = await get(Uri.parse('http://localhost:3000/api/referral/$userId'));
     List data = jsonDecode(response.body) as List;

     referrals = data
            .map((referralJson) => Referral.fromJson(referralJson))
            .toList();
  }
}