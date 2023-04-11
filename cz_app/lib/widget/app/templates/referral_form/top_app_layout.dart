import 'package:flutter/material.dart';

class TopAppWidget extends StatelessWidget {
  const TopAppWidget({super.key});

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
