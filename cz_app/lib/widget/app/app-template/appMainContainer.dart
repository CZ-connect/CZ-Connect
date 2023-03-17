import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class appMainContainer extends StatelessWidget {
  const appMainContainer({super.key});


  @override
  Widget build(BuildContext context) {
    //TODO make this filllable with widtgets
    return Center(
      child: Container(
        decoration: const BoxDecoration(color: Colors.amber),
        width:  MediaQuery
            .of(context)
            .size
            .width - 100,
        height: MediaQuery
            .of(context)
            .size
            .height - 250,

      ),
    );
  }

}