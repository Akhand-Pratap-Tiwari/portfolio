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
          if (constraints.maxWidth <= 640) {
            isMobile = true;
            isTablet = false;
            isDesktop = false;
          } else if (constraints.maxWidth <= 1007) {
            isMobile = false;
            isTablet = true;
            isDesktop = false;
          } else {
            isMobile = false;
            isTablet = false;
            isDesktop = true;
          }
          return const WebPage();
        },
      ),
    );
  }
}
