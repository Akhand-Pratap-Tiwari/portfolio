import 'package:flutter/material.dart';

import 'skills_meta.dart';

class Skills extends StatelessWidget {
  const Skills({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: constraints.maxWidth ~/ 150,
        mainAxisSpacing: 32,
        crossAxisSpacing: 32,
        children: List.generate(
          skillPaths.length,
          (index) => SkillBadge(
            index: index,
          ),
        ),
      ),
    );
  }
}

class SkillBadge extends StatefulWidget {
  final int index;
  const SkillBadge({super.key, required this.index});

  @override
  State<SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<SkillBadge> {
  SkillsWidgetInfo widInfo = SkillsWidgetInfo();
  BorderRadius borderRadius = BorderRadius.circular(32);
  double elevation = 10;
  EdgeInsets padding = const EdgeInsets.all(8);
  _animate(bool value) {
    setState(() {
      if (value) {
        borderRadius = widInfo.aniBorderRadius;
        elevation = widInfo.aniElevation;
        padding = widInfo.aniPadding;
      } else {
        borderRadius = widInfo.baseBorderRadius;
        elevation = widInfo.baseElevation;
        padding = widInfo.basePadding;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 100),
      padding: padding,
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        elevation: elevation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: widget.index == 0
                ? Colors.blueGrey.shade900
                : widget.index == 2
                    ? const Color.fromARGB(255, 44, 57, 75)
                    : widget.index == 6
                        ? const Color.fromARGB(255, 48, 0, 0)
                        : widget.index == 12
                            ? Colors.deepPurple.shade900
                            : Colors.white,
            borderRadius: borderRadius,
          ),
          child: InkWell(
            onTap: () {},
            onHover: (value) => _animate(value),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Image.asset(skillPaths[widget.index]),
            ),
          ),
        ),
      ),
    );
  }
}
