import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class topAppWidget extends StatelessWidget {
  static const color = Color(0xFFE40429);

  @override
  Widget build(BuildContext context) {
    //TODO make this fillable with widgets
    return Center(
      child: Container(
        decoration: BoxDecoration(color: color),
        width: double.maxFinite,
        height: 250.0,
      ),
    );
  }
}
