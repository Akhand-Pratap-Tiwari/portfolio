import 'package:flutter/material.dart';
import 'web_page.dart';

class Constraints extends StatefulWidget {
  const Constraints({super.key});

  @override
  State<Constraints> createState() => _ConstraintsState();
}

bool isMobile = false;
bool isTablet = false;
bool isDesktop = false;
// BoxConstraints globalConstraints = BoxConstraints();

class _ConstraintsState extends State<Constraints> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
                  debugPrint('debug1: ' + constraints.minHeight.toString());

          // globalConstraints = constraints;
          if (constraints.maxWidth <= 640) {
            isMobile = true;
            isTablet = false;
            isDesktop = false;
            // debugPrint('debug4: ' + 'Here1');
          } else if (constraints.maxWidth <= 1007) {
            isMobile = false;
            isTablet = true;
            isDesktop = false;
            // debugPrint('debug4: ' + 'Here2');
          } else {
            isMobile = false;
            isTablet = false;
            isDesktop = true;
            // debugPrint('debug4: ' + 'Here3');
          }
          return const WebPage();
        },
      ),
    );
  }
}
