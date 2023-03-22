import 'package:flutter/material.dart';

class UserRow extends StatelessWidget {
  const UserRow({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      heightFactor: 0.3,
      alignment: FractionalOffset.center,
      child: DecoratedBox(
        decoration:
            BoxDecoration(border: Border.all(width: 2), color: Colors.grey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
                child: Image.asset('assets/images/stadscafe.png',
                    width: 70, height: 70)),
            const Expanded(child: Text("Coen van den Berge"))
          ],
        ),
      ),
    );
  }
}
