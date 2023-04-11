import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/tablet_layout/t_home/t_top_container.dart';
import 'package:url_launcher/url_launcher.dart';

import 't_blurred_container.dart';

class THome extends StatefulWidget {
  const THome({super.key});

  @override
  State<THome> createState() => _THomeState();
}

class _THomeState extends State<THome> {
  String _intro1 =
      'I am a Cross-platform Flutter-App developer from U.P., India. I am currently pursuing my B.Tech CSE [Core] from VIT, Bhopal. '
      '\n\nBeing passionate about improving my coding skills, developing new applications and exploring new technologies I always look forward to take leap into the unexplored. ';
  String _intro2 =
      '\n\nAlthough I can build Mobile Apps, Websites and Desktop Apps using Flutter but my forte is Mobile App development. '
      '\n\nI am also a good team player as I am able to lead a team as well as work as supporting member too. ';
  List<String> _skillPaths = [
    'assets/img/cpp.jpg',
    'assets/img/firebase.png',
    'assets/img/flutter.jpg',
    'assets/img/gcp.png',
    'assets/img/github.png',
    'assets/img/illustrator.png',
    'assets/img/python.png',
    'assets/img/sql.jpg'
  ];

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
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyTopContainer(),
                  Divider(
                    color: Colors.transparent,
                    height: 100,
                  ),
                  MyBlurredContainer(
                    animation: 'assets/anim/development.json',
                    title: 'About Me',
                    body1: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(text: 'Hello! I am, '),
                          TextSpan(
                            text: 'Akhand P. Tiwari. ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                          TextSpan(text: _intro1),
                        ],
                      ),
                    ),
                    body2: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(text: _intro2),
                        ],
                      ),
                    ),
                  ),
                  MyBlurredContainer(
                    title: 'Skills and Abilities',
                    body1: SizedBox(
                      // width: size.width,
                      height: 350,
                      child: GridView.count(
                        // maxCrossAxisExtent: 4,
                        crossAxisCount: 4,
                        mainAxisSpacing: 32,
                        crossAxisSpacing: 32,
                        children: List.generate(
                          8,
                          (index) => ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: Image.asset(_skillPaths[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // MyBlurredContainer(title: 'Projects', body1: body1)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
