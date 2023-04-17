import 'package:flutter/material.dart';

const String introBeforeAnim =
    'I am a Cross-platform Flutter-App developer from U.P., India. I am currently pursuing my B.Tech CSE [Core] from VIT, Bhopal. '
    '\n\nBeing passionate about improving my coding skills, developing new applications and exploring new technologies I always look forward to take leap into the unexplored.\n';
    
const String introAfterAnim =
    '\nAlthough I can build Mobile Apps, Websites and Desktop Apps using Flutter but my forte is Mobile App development. '
    '\n\nI am also a good team player as I am able to lead a team as well as work as supporting member too. ';

class AboutMeWidgetInfo {
  Size thisSize;
  late TextStyle textStyle;
  late BuildContext context;

  AboutMeWidgetInfo({required this.thisSize, required this.context}) {
    textStyle = Theme.of(context).textTheme.bodyLarge!;
    updateSize(thisSize);
  }

  void updateSize(Size size) {
    thisSize = size;
  }
}
