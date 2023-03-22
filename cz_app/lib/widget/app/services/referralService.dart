import 'dart:convert';

import 'package:http/http.dart';

class Referral {
  int userId;
  //List<Referral> referrals;
  List<String> Refferals = [];

  Referral({required this.userId});

  Future<void> getData() async {
    try{
      Response response = await get(Uri.parse('https://jsonplaceholder.typicode.com/todos/0'));
      Map data = jsonDecode(response.body);
      //print(data);
      //print(data['title']);
      //get properties from data
    }
    catch(e){
      print('error $e');
    }
  }
}