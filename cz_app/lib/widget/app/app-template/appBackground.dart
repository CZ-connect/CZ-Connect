import 'package:cz_app/widget/app/app-template/bottemAppLayout.dart';
import 'package:cz_app/widget/app/app-template/topAppLayout.dart';
import 'package:flutter/material.dart';


//This widget styles the topcontainer and the bottom container in the app into 1
 class backgroundWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return Column(
       children: <Widget>[
         // top widget 1
         topAppWidget(),
         bottemAppWidget(),
         //top widget 2
       ]
   );
  }

}