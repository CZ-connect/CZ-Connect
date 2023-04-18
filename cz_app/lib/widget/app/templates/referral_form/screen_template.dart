import 'package:flutter/material.dart';
import '../navigation_menu.dart';

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
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
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
      drawer: const NavigationMenu(),
    );
  }
}
