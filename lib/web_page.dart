import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/home/home.dart';
import 'package:portfolio/projects/video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about/about.dart';
import 'meta.dart';
import 'global_common_widgets/blurred_container.dart';
import 'projects/projects.dart';
import 'skills/skills.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> with TickerProviderStateMixin {
  final List<String> _tabNames = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Work Exp.',
  ];

  late TabController _tabController;
  late ScrollController _scrollController;
  late List<GlobalKey<State<StatefulWidget>>> keyList;

  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  Color _tabBarColor = Colors.pinkAccent;

  @override
  void initState() {
    keyList = List.generate(_tabNames.length, (index) => GlobalKey());

    _tabController = TabController(
      length: keyList.length,
      vsync: this,
      animationDuration: const Duration(milliseconds: 250),
    );

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset == 0) {
          setState(() {
            _tabBarColor = Colors.pinkAccent;
          });
        } else if (_tabBarColor != Colors.black45) {
          setState(() {
            _tabBarColor = Colors.black45;
          });
        }

        if (_scrollController.position.userScrollDirection ==
                ScrollDirection.reverse &&
            selectedIndex.value < keyList.length - 1) {
          RenderBox box = keyList[selectedIndex.value + 1]
              .currentContext!
              .findRenderObject() as RenderBox;
          Offset position = box.localToGlobal(Offset.zero);
          //this is global position
          if (position.dy <= 64) {
            // debugPrint('$selectedIndex');
            ++_tabController.index;
            ++selectedIndex.value;
          }
        } else if (_scrollController.position.userScrollDirection ==
                ScrollDirection.forward &&
            selectedIndex.value > 0) {
          RenderBox box = keyList[selectedIndex.value - 1]
              .currentContext!
              .findRenderObject() as RenderBox;
          Offset position = box.localToGlobal(Offset.zero);
          //this is global position
          if (box.size.height / 2 + position.dy >= 64) {
            // debugPrint('$selectedIndex');
            --_tabController.index;
            --selectedIndex.value;
          }
        }
      });

    super.initState();
  }

  _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  final List<dynamic> _contactBar = [
    [
      'mailto:akdevstudios100@gmail.com',
      Icons.mail_rounded,
      Colors.white,
    ],
    [
      'tel://+917309040494',
      Icons.call,
      Colors.white,
    ]
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // var keyList = List.filled(4, GlobalKey());
    List<Widget> widgetList = [
      MyBlurredContainer(
        key: keyList[1],
        // animation: 'assets/anim/development.json',
        title: 'About Me',
        body: AboutMe(),
      ),
      MyBlurredContainer(
        key: keyList[2],
        title: 'Skills',
        body: Skills(),
      ),
      MyBlurredContainer(
        key: keyList[3],
        title: 'Projects',
        body: Projects(),
      ),
      MyBlurredContainer(
        key: keyList[4],
        title: 'Work Exp. and Responsibilities',
        body: Align(
          alignment: Alignment.center,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset('assets/anim/experience.json'),
              Text(
                expAndRes,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    ];

    var contactBar = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black,
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            _contactBar.length,
            (index) => IconButton(
              onPressed: () => _launchURL(_contactBar[index][0]),
              icon: FaIcon(_contactBar[index][1]),
              iconSize: 30,
              color: _contactBar[index][2],
            ),
          )..insert(
              1,
              const SizedBox(
                width: 50,
                child: Divider(),
              ),
            ),
        ),
      ),
    );
    List<String> bgAnim = [
      'assets/anim/waves.json',
      'assets/anim/liquidBg.json',
      'assets/anim/sparkles.json',
    ];
    return Scaffold(
      // extendBody: true,
      // bottomNavigationBar: contactBar,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Material(
              elevation: 10,
              color: _tabBarColor,
              child: TabBar(
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                automaticIndicatorColorAdjustment: true,
                onTap: (value) {
                  selectedIndex.value = value;
                  Scrollable.ensureVisible(
                    keyList[value].currentContext!,
                    duration: const Duration(seconds: 1),
                    curve: Curves.elasticOut,
                  );
                },
                controller: _tabController,
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Colors.indigo, Colors.cyan]),
                  borderRadius: BorderRadius.circular(48),
                ),
                labelPadding: const EdgeInsets.all(8),
                indicatorPadding: const EdgeInsets.all(8),
                labelStyle: Theme.of(context).textTheme.bodyLarge,
                splashBorderRadius: BorderRadius.circular(48),
                tabs: List.generate(
                  keyList.length,
                  (index) => Center(
                    child: Tab(
                      child: Center(
                        child: Text(
                          _tabNames[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ValueListenableBuilder<int>(
            valueListenable: selectedIndex,
            builder: (context, value, child) => AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: LottieBuilder.asset(
                bgAnim[value <= 1
                    ? 0
                    : value <= 3
                        ? 1
                        : 2],
                key: ValueKey(value <= 1
                    ? 0
                    : value <= 3
                        ? 1
                        : 2),
                fit: BoxFit.cover,
                height: size.height,
                width: size.width,
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 64.0),
                  child: Home(
                    key: keyList[0],
                  ),
                ),
                size.width ~/ 700 <= 1
                    ? Column(
                        children: widgetList,
                      )
                    : GridView.count(
                        childAspectRatio: 1 / 1.25,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        children: widgetList,
                      ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: contactBar,
          )
        ],
      ),
    );
  }
}

