import 'package:cz_app/widget/app/models/employee.dart';
import 'package:flutter/material.dart';

class UserRow extends StatelessWidget {
  const UserRow({super.key});

  @override
  Widget build(BuildContext context) {
    final Employee? employee;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      employee = ModalRoute.of(context)?.settings.arguments as Employee;
    } else {
      employee = null;
    }
    return FractionallySizedBox(
      widthFactor: 1.0,
      heightFactor: 0.3,
      alignment: FractionalOffset.center,
      child: DecoratedBox(
        decoration:
            BoxDecoration(border: Border.all(width: 2), color: Colors.white24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
                child: Image.asset('assets/images/profile_placeholder.png',
                    width: 70, height: 70)),
            Text(employee?.name ??
                'Coen van den Berge'), // TO-DO Change hardcoded name to logged in user.
          ],
        ),
      ),
    );
  }
}
