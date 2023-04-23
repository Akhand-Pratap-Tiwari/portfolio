import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

import '../constraints.dart';
import 'video_player.dart';
import 'projects_meta.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  PageController _vidPageController = PageController(); 
  PageController _desPageController = PageController();
  PageController _tlePageController = PageController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // debugPrint('debug1: ' + constraints.minHeight.toString());
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: constraints.maxWidth / 2),
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _vidPageController,
                children: List.generate(
                  gitVidTitlDesc.length,
                  (index) => VideoApp(
                    videoHeight: constraints.maxWidth / 2,
                    gitHubUrl: gitVidTitlDesc[index][0],
                    videoLink: gitVidTitlDesc[index][1],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PreviousButton(
                  vidPageController: _vidPageController,
                  txtPageController: _desPageController,
                ),
                SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.white,
                    activeDotColor: Colors.black,
                  ),
                  controller: _vidPageController,
                  count: gitVidTitlDesc.length,
                ),
                NextButton(
                  vidPageController: _vidPageController,
                  txtPageController: _desPageController,
                )
              ],
            ),
            Divider(
              color: Colors.transparent,
            ),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(gitVidTitlDesc[0][2],
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                Expanded(child: Divider()),
              ],
            ),
            Divider(
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
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _desPageController,
                  children: List.generate(
                    gitVidTitlDesc.length,
                    (index) => SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          gitVidTitlDesc[index][3],
                          style: Theme.of(context).textTheme.bodyLarge!,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required PageController vidPageController,
    required PageController txtPageController,
  })  : _vidPageController = vidPageController,
        _txtPageController = txtPageController;

  final PageController _vidPageController;
  final PageController _txtPageController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _txtPageController.nextPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInToLinear,
        );
        _vidPageController.nextPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInToLinear,
        );
      },
      backgroundColor: Colors.white.withOpacity(0.5),
      child: const Icon(Icons.chevron_right_rounded),
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    super.key,
    required PageController txtPageController,
    required PageController vidPageController,
  })  : _pageController = vidPageController,
        _txtPageController = txtPageController;

  final PageController _txtPageController;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _txtPageController.previousPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInToLinear,
        );
        _pageController.previousPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInToLinear);
      },
      backgroundColor: Colors.white.withOpacity(0.5),
      child: const Icon(Icons.chevron_left_rounded),
    );
  }
}
