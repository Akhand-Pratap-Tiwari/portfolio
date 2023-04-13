import 'package:flutter/material.dart';

import 'mobile_layout/m_home.dart';
import 'tablet_layout/t_home/t_home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 640) {
            return const MHome();
          } else if (constraints.maxWidth <= 1007) {
            return const THome();
          } else {
            return const THome(); //destops
          }
        },
      ),
    );
  }
}
