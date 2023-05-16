import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import 'package:flutter/material.dart';

class UserRow extends StatefulWidget {
  final Employee? employee;
  const UserRow({super.key, this.employee});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _UserRow();
}

class _UserRow extends State<UserRow> {
  @override
  Widget build(BuildContext context) {
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
            Text(widget.employee?.name ??
                UserPreferences.getUserName()),
          ],
        ),
      ),
    );
  }
}
