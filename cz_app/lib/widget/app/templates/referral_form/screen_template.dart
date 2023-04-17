import 'package:flutter/material.dart';

import '../../referral_dashboard/referrals_index.dart';
import '../referral_dashboard/bottom.dart';
import '../referral_dashboard/container.dart';
import '../referral_dashboard/template.dart';
import '../referral_dashboard/top.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget header;
  final Widget body;
  final Widget? leading;

  const ScreenTemplate({
    Key? key,
    required this.header,
    required this.body,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
//        backgroundColor: Colors.transparent,
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
      ),
      bottomNavigationBar: null,
      body: Column(
        children: [
          Container(height: 0), // Removes extra space at the top of the Column
          Expanded(
            child: Stack(
              children: [
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE40429), Color(0xFFFF9200)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      header,
                      body,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
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
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Scaffold(
                        body: ReferralDashboardTemplate(
                            header: ReferralDashboardTopWidget(),
                            body: ReferralDashboardBottomWidget(
                              child: ReferralDashboardContainerWidget(
                                child: ReferralDashboardIndexWidget(),
                              ),
                            ),
                          ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Application Form'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Overzicht '),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
