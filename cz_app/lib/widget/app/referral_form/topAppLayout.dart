import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class topAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO make this filllable with widtgets
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.red),
        width: double.maxFinite,
        height: 250.0,
      ),
    );
  }
}
