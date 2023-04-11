import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class topAppWidget extends StatelessWidget {
  static const color = Color(0xFFE40429);

  @override
  Widget build(BuildContext context) {
    //TODO make this fillable with widgets
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 250,
        child: Container(
          decoration: const BoxDecoration(
            color: color,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/logo-cz.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'CZ-connect',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
