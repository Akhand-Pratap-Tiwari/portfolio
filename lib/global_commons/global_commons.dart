import 'package:flutter/material.dart';

class MyTextButtonAppBar extends StatefulWidget {
  final String text;
  final void Function()? onPressed;

  const MyTextButtonAppBar({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<MyTextButtonAppBar> createState() => _MyTextButtonAppBarState();
}

class _MyTextButtonAppBarState extends State<MyTextButtonAppBar> {
  double size = 15;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onHover: (value) => value
          ? setState(() {
              size = 20;
            })
          : setState(() {
              size = 15;
            }),
      onPressed: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedDefaultTextStyle(
          style:
              Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: size),
          duration: const Duration(milliseconds: 50),
          child: Text(widget.text),
          // curve: Curves.bounceInOut,
        ),
      ),
    );
  }
}
