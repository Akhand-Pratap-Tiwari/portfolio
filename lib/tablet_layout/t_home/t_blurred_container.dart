import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class MyBlurredContainer extends StatefulWidget {
  final String title;
  final String? animation;
  final bool alignRight, alignMiddle;
  final Widget body1;
  final Widget? body2;

  const MyBlurredContainer({
    super.key,
    required this.title,
    required this.body1,
    this.body2,
    this.animation,
    this.alignRight = false,
    this.alignMiddle = true,
  });

  @override
  State<MyBlurredContainer> createState() => _MyBlurredContainerState();
}

class _MyBlurredContainerState extends State<MyBlurredContainer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: size.width,
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
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.displayMedium!.fontSize),
                ),
                Divider(
                  color: Colors.white,
                  height: 10,
                ),
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    !widget.alignMiddle &&
                            !widget.alignRight &&
                            widget.animation != null
                        ? LottieBuilder.asset(widget.animation!)
                        : Container(),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: widget.body1,
                      ),
                    ),
                    !widget.alignMiddle &&
                            widget.alignRight &&
                            widget.animation != null
                        ? LottieBuilder.asset(widget.animation!)
                        : Container(),
                  ],
                ),
                widget.alignMiddle &&
                        !widget.alignRight &&
                        widget.animation != null
                    ? Center(child: LottieBuilder.asset(widget.animation!))
                    : Container(),
                widget.body2 ?? Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
