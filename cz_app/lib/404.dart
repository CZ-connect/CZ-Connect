import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteNotFound extends StatelessWidget {
  const RouteNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Deze url bestaat niet, keer terug naar de applicatie.',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            context.go("/");
          },
          child: const Text('Terugkeren naar CZ - Connect'),
        ),
      ],
    );
  }
}
