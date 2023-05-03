import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../constraints.dart';
import 'video_player.dart';
import 'projects_meta.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  int glbIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: VideoApp(
              key: ValueKey(glbIndex),
              videoHeight: constraints.maxWidth / 2,
              gitHubUrl: gitVidTitlDesc[glbIndex][0],
              videoLink: gitVidTitlDesc[glbIndex][1],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () => setState(() {
                  glbIndex =
                      glbIndex == 0 ? gitVidTitlDesc.length - 1 : glbIndex - 1;
                }),
                backgroundColor: Colors.white.withOpacity(0.5),
                child: const Icon(Icons.chevron_left_rounded),
              ),
              AnimatedSmoothIndicator(
                activeIndex: glbIndex,
                count: gitVidTitlDesc.length,
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.white,
                  activeDotColor: Colors.black,
                ),
              ),
              FloatingActionButton(
                onPressed: () => setState(() {
                  glbIndex =
                      glbIndex == gitVidTitlDesc.length - 1 ? 0 : glbIndex + 1;
                }),
                backgroundColor: Colors.white.withOpacity(0.5),
                child: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
          const Divider(
            color: Colors.transparent,
          ),
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Row(
                key: ValueKey(glbIndex),
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(gitVidTitlDesc[glbIndex][2],
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  const Expanded(child: Divider()),
                ],
              )),
          const Divider(
            color: Colors.transparent,
          ),
          Container(
            // margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black,
            ),
            child: SizedBox(
              height: !isMobile
                  ? constraints.maxWidth - 380
                  : MediaQuery.of(context).size.height / 2,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      gitVidTitlDesc[glbIndex][3],
                      key: ValueKey(glbIndex),
                      style: Theme.of(context).textTheme.bodyLarge!,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
