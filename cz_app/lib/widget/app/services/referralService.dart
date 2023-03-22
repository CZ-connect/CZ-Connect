import 'dart:convert';

import 'package:cz_app/widget/app/models/referral.dart';
import 'package:http/http.dart';

class ReferralService {
  int userId;
  //List<Referral> referrals;
  List<Referral> Referrals = [];

  ReferralService({required this.userId});

  Future<void> getData() async {
      Response response = await get(Uri.parse('https://jsonplaceholder.typicode.com/todos/$userId'));
      Map data = jsonDecode(response.body);
      //print(data);
      //print(data['title']);
      //get properties from data
  }
}