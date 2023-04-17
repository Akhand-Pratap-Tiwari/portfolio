import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'about_meta.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AboutMeWidgetInfo aboutMeWidInfo = AboutMeWidgetInfo(
        thisSize: MediaQuery.of(context).size, context: context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            style: aboutMeWidInfo.textStyle,
            children: const [
              TextSpan(text: 'Hello! I am, '),
              TextSpan(
                text: 'Akhand P. Tiwari. ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent,
                ),
              ),
              TextSpan(text: introBeforeAnim),
            ],
          ),
          softWrap: true,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: aboutMeWidInfo.animContBorderRad,
              color: const Color.fromRGBO(29, 29, 29, 1),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return LottieBuilder.asset(
                  'assets/anim/ready.json',
                  height: constraints.maxWidth / 1.5,
                  width: constraints.maxWidth / 1.5,
                  alignment: Alignment.center,
                  frameRate: FrameRate.max,
                  reverse: true,
                );
              },
            ),
          ),
        ),
        Text(
          introAfterAnim,
          style: aboutMeWidInfo.textStyle,
          softWrap: true,
        ),
      ],
    );
  }
}
