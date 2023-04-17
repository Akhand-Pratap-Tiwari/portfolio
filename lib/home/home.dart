import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/constraints.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_meta.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    HomeWidgetInfo homeWidInfo = HomeWidgetInfo(thisSize: size);

    List<Widget> picAndTxt = [
      Material(
        borderRadius: homeWidInfo.circularBorderRadius,
        elevation: 20,
        shadowColor: Colors.black,
        child: ClipRRect(
          borderRadius: homeWidInfo.circularBorderRadius,
          child: Image.asset(
            'assets/img/Photo4.jpg',
            scale: 3.5,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(isTablet || isMobile ? 16 : 64),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isTablet || isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.displayMedium,
                  children: const [
                    TextSpan(text: 'I am '),
                    TextSpan(
                      text: 'Akhand P. Tiwari,',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: List.generate(
                  typerAnimatedTextList.length,
                  (index) => TyperAnimatedText(
                    typerAnimatedTextList[index][0],
                    textStyle: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.displayMedium!.fontSize,
                      color: typerAnimatedTextList[index][1],
                    ),
                  ),
                ),
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      linkIconColorList.length,
                      (index) => IconButton(
                        onPressed: () =>
                            _launchURL(linkIconColorList[index][0]),
                        icon: FaIcon(linkIconColorList[index][1]),
                        iconSize: 50,
                        color: linkIconColorList[index][2],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];

    return Material(
      color: Colors.transparent,
      borderRadius: homeWidInfo.containerBorderRadius,
      elevation: 10,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: homeWidInfo.containerBorderRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.pinkAccent,
                      Colors.deepPurple.withOpacity(0.7),
                    ],
                    stops: const [0, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: homeWidInfo.containerBorderRadius,
                ),
                child: isTablet || isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: picAndTxt,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: picAndTxt,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          isDesktop && size.width >= 1260
              ? LottieBuilder.asset('assets/anim/mobileDev.json')
              : Container(),
        ],
      ),
    );
  }
}
