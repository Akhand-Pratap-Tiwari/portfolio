import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class MyBlurredContainer extends StatefulWidget {
  final String title;
  final Widget body;

  const MyBlurredContainer({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<MyBlurredContainer> createState() => _MyBlurredContainerState();
}

class _MyBlurredContainerState extends State<MyBlurredContainer> {
  var borderRadius = BorderRadius.circular(16.0);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.withOpacity(0.5),
                  Colors.cyan.withOpacity(0.5),
                ],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displayMedium!.fontSize,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: widget.body,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
