import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class THome extends StatefulWidget {
  const THome({super.key});

  @override
  State<THome> createState() => _THomeState();
}

class _THomeState extends State<THome> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 100),
      length: 6,
      child: Scaffold(
        appBar: TabBar(
          labelStyle: const TextStyle(fontSize: 19),
          unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge,
          splashBorderRadius: BorderRadius.circular(72),
          tabs: const [
            Tab(text: 'Home'),
            Tab(text: 'About'),
            Tab(text: 'Skills'),
            Tab(text: 'Projects'),
            Tab(text: 'Work Exp.'),
            Tab(text: 'Contact')
          ],
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              // color: Colors.red,
              child: LottieBuilder.asset(
                'assets/anim/waves.json',
                fit: BoxFit.fitWidth,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(size.width / 2, 150),
                bottomRight: Radius.elliptical(size.width / 2, 150),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  width: size.width,
                  height: size.height / 1.2,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(size.width / 2, 150),
                      bottomRight: Radius.elliptical(size.width / 2, 150),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.elliptical(150, 70),
                          bottomRight: Radius.elliptical(150, 70),
                        ),
                        child: Image.asset(
                          'assets/img/Photo4.jpg',
                          scale: 3.5,
                        ),
                      ),
                      const Divider(color: Colors.transparent),
                      const Text('Hi There'),
                      const Divider(color: Colors.transparent),
                      const Text('I am Akhand P. Tiwari'),
                      const Divider(color: Colors.transparent),
                      const Text('I am a cross-platform Flutter App Developer'),
                      const Divider(color: Colors.transparent),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}