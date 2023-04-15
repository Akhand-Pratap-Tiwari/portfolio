import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTopContainer extends StatefulWidget {
  const MyTopContainer({super.key});

  @override
  State<MyTopContainer> createState() => _MyTopContainerState();
}

class _MyTopContainerState extends State<MyTopContainer> {
  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  final List<dynamic> _linkIconColorList = [
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var ellipticalBorderRadius = BorderRadius.only(
        bottomLeft: Radius.elliptical(size.width / 2, 175),
        bottomRight: Radius.elliptical(size.width / 2, 175));
        var picBorderRad =size.width <= 1007
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                  bottomRight: Radius.circular(150),
                )
              : const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.elliptical(400, 450),
              ); 
    Widget pic =
      Material(
        borderRadius: picBorderRad,
        elevation: 20,
        shadowColor: Colors.black,
        child: ClipRRect(
          borderRadius: picBorderRad,
          child: Image.asset(
            'assets/img/Photo4.jpg',
            scale: 3.5,
            ),
        ),
      );
    var txtAndSocial = [
      Column(
        crossAxisAlignment: size.width <= 1007
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 2.5),
              child: RichText(
                textAlign:
                    size.width <= 1007 ? TextAlign.center : TextAlign.start,
                text: TextSpan(
                  style: Theme.of(context).textTheme.displaySmall,
                  children: const [
                    TextSpan(text: '\n I am '),
                    TextSpan(
                      text: 'Akhand P. Tiwari',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.transparent,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ' I am a ',
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displayMedium!.fontSize),
              ),
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TyperAnimatedText('Cross-platform Developer',
                      textStyle: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.displayMedium!.fontSize,
                        color: Colors.purpleAccent,
                      )),
                  TyperAnimatedText('Flutter Developer',
                      textStyle: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.displayMedium!.fontSize,
                        color: Colors.lightBlue,
                      )),
                  TyperAnimatedText('UI/UX Designer',
                      textStyle: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.displayMedium!.fontSize,
                        color: Colors.pinkAccent,
                      ))
                ],
              )
            ],
          ),
          const Divider(
            color: Colors.transparent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              4,
              (index) => IconButton(
                onPressed: () => _launchURL(_linkIconColorList[index][0]),
                icon: FaIcon(_linkIconColorList[index][1]),
                iconSize: 50,
                color: _linkIconColorList[index][2],
              ),
            ),
          ),
        ],
      ),
      const Divider(color: Colors.transparent),
    ];

    return Material(
      color: Colors.transparent,
      borderRadius: size.width >= 1007
          ? BorderRadius.only(
              bottomLeft: Radius.elliptical(size.width / 2, 200),
              bottomRight: Radius.elliptical(size.width / 2, 200))
          : ellipticalBorderRadius,
      elevation: 20,
      child: ClipRRect(
        borderRadius: size.width >= 1007
            ? BorderRadius.only(
                bottomLeft: Radius.elliptical(size.width / 2, 200),
                bottomRight: Radius.elliptical(size.width / 2, 200))
            : ellipticalBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.only(bottom: 8),
            width: size.width,
            // height: size.height / 1.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent.withOpacity(0.3),
                  Colors.blue.withOpacity(0.7)
                ],
                stops: const [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: size.width >= 1007
                  ? BorderRadius.only(
                      bottomLeft: Radius.elliptical(size.width / 2, 200),
                      bottomRight: Radius.elliptical(size.width / 2, 200))
                  : ellipticalBorderRadius,
            ),
            child: size.width <= 1007
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [pic, ...txtAndSocial],
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width >= 1352 ? 96 * 2 : 32,
                        vertical: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: txtAndSocial..add(pic),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
