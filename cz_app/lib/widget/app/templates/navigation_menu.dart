import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 100,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFFE40429), Color(0xFFFF9200)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                      ),
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
            ),
            ListTile(
              title: const Text('Referral Dashboard'),
              onTap: () {
                Navigator.pushNamed(context, '/referraldashboard');
              },
            ),
            ListTile(
              title: const Text('Application Form'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: const Text('Referral Overzicht'),
              onTap: () {
                Navigator.pushNamed(context, '/loading');
              },
            ),
          ],
        ),
      );
  }
}