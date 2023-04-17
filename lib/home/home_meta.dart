import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constraints.dart';

final List<dynamic> linkIconColorList = [
  [
    'https://www.linkedin.com/in/akhand-pratap-tiwari-37621b22a/',
    FontAwesomeIcons.linkedin,
    Colors.lightBlue
  ],
  [
    'https://github.com/Akhand-Pratap-Tiwari/',
    FontAwesomeIcons.squareGithub,
    Colors.black
  ],
  [
    'https://www.youtube.com/channel/UCx0ucku5Par4_Gzs5C89UJA/featured',
    FontAwesomeIcons.squareYoutube,
    Colors.red
  ],
  [
    'https://www.instagram.com/Akhand_Pratap_Tiwari/',
    FontAwesomeIcons.instagram,
    Colors.purpleAccent
  ],
];

final List<dynamic> typerAnimatedTextList = [
  [
    'Cross-platform Dev',
    Colors.purpleAccent,
  ],
  [
    'Flutter App Dev',
    Colors.lightBlue,
  ],
  [
    'UI/UX Designer',
    Colors.pinkAccent,
  ],
];

class WidgetInfo {
  Size thisSize;
  BorderRadius circularBorderRadius = BorderRadius.circular(32);
  late BorderRadius circularBorderRadius2;
  late BorderRadius containerBorderRadius;

  WidgetInfo({required this.thisSize}) {
    updateSize(thisSize);
  }

  void updateSize(Size size) {
    thisSize = size;

    circularBorderRadius2 = BorderRadius.only(
      bottomLeft: Radius.elliptical(thisSize.width / 2, 175),
      bottomRight: Radius.elliptical(thisSize.width / 2, 175),
    );

    containerBorderRadius = isDesktop
        ? BorderRadius.only(
            bottomRight: Radius.elliptical(thisSize.width, 500),
          )
        : circularBorderRadius2;
  }
}
