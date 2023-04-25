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
              key: const Key('referral_dashboard_menu_item'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/referraldashboard');
              },
            ),
            ListTile(
              title: const Text('Application Form'),
              key: const Key('application_form_menu_item'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/');
              },
            ),
            ListTile(
              title: const Text('Graph Referals'),
              key: const Key('Graph_refferals_menu_item'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/graph');
              },
            ),
            ListTile(
              title: const Text('Referral Overzicht'),
              key: const Key('referral_overview_menu_item'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/loading');
              },
            ),
          ],
        ),
      );
  }
}