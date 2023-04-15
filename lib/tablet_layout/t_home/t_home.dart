import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/tablet_layout/t_home/t_top_container.dart';
import 'package:portfolio/tablet_layout/t_home/video_player.dart';

import 't_blurred_container.dart';

final List<String> _skillPaths = [
  'assets/img/cpp.jpg',
  'assets/img/c.png',
  'assets/img/firebase.png',
  'assets/img/flutter.jpg',
  'assets/img/gcp.png',
  'assets/img/github.png',
  'assets/img/illustrator.png',
  'assets/img/python.png',
  'assets/img/sql.jpg',
  'assets/img/inkscape.png',
  'assets/img/desmos.jpg',
  'assets/img/dart.png',
  'assets/img/ai.jpg'
];

class THome extends StatefulWidget {
  const THome({super.key});

  @override
  State<THome> createState() => _THomeState();
}

class _THomeState extends State<THome> with TickerProviderStateMixin {
  final String _intro1 =
      'I am a Cross-platform Flutter-App developer from U.P., India. I am currently pursuing my B.Tech CSE [Core] from VIT, Bhopal. '
      '\n\nBeing passionate about improving my coding skills, developing new applications and exploring new technologies I always look forward to take leap into the unexplored.\n';
  final String _intro2 =
      '\nAlthough I can build Mobile Apps, Websites and Desktop Apps using Flutter but my forte is Mobile App development. '
      '\n\nI am also a good team player as I am able to lead a team as well as work as supporting member too. ';

  final List<String> _tabNames = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Work Exp.',
    'Contact',
  ];

  late TabController _tabController;
  late ScrollController _scrollController;

  var key0 = GlobalKey();
  var key1 = GlobalKey();
  var key2 = GlobalKey();
  var key3 = GlobalKey();
  var key4 = GlobalKey();
  var key5 = GlobalKey();
  late final List<GlobalKey> keyList;

  int selectedIndex = 0;
  @override
  void initState() {
    keyList = [key0, key1, key2, key3, key4, key5];

    _tabController = TabController(
      length: 6,
      vsync: this,
      animationDuration: const Duration(milliseconds: 100),
    )..addListener(() {  });

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.userScrollDirection ==
                ScrollDirection.reverse &&
            selectedIndex < 3) {
          RenderBox box = keyList[selectedIndex + 1]
              .currentContext!
              .findRenderObject() as RenderBox;
          Offset position = box.localToGlobal(Offset.zero);
          //this is global position
          if (position.dy <= 64) {
            debugPrint('$selectedIndex');
            ++_tabController.index;
            ++selectedIndex;
          }
        } else if (_scrollController.position.userScrollDirection ==
                ScrollDirection.forward &&
            selectedIndex > 0) {
          RenderBox box = keyList[selectedIndex - 1]
              .currentContext!
              .findRenderObject() as RenderBox;
          Offset position = box.localToGlobal(Offset.zero);
          //this is global position
          if (box.size.height / 2 + position.dy >= 64) {
            debugPrint('$selectedIndex');
            --_tabController.index;
            --selectedIndex;
          }
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var keyList = List.filled(4, GlobalKey());
    List<Widget> widgetList = [
      MyBlurredContainer(
        key: keyList[1],
        // animation: 'assets/anim/development.json',
        title: 'About Me',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  const TextSpan(text: 'Hello! I am, '),
                  const TextSpan(
                    text: 'Akhand P. Tiwari. ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  TextSpan(text: _intro1),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black45,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // debugPrint('debug1 :' + constraints.maxWidth.toString());
                    return LottieBuilder.asset(
                    'assets/anim/ready.json',
                    height: constraints.maxWidth / 1.5,
                    width: constraints.maxWidth / 1.5,
                    alignment: Alignment.center,
                    frameRate: FrameRate.max,
                    reverse: true,
                  );},
                ),
              ),
            ),
            Text(
              _intro2,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      MyBlurredContainer(
        key: keyList[2],
        title: 'Skills',
        body: LayoutBuilder(
          builder: (context, constraints) => GridView.count(
            // childAspectRatio: 1/2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // maxCrossAxisExtent: 4,
            crossAxisCount: constraints.maxWidth ~/ 150,
            mainAxisSpacing: 32,
            crossAxisSpacing: 32,
            children: List.generate(
                _skillPaths.length,
                (index) => SkillBadge(
                      index: index,
                    )),
          ),
        ),
      ),
      MyBlurredContainer(
        key: keyList[3],
        title: 'Projects',
        body: LayoutBuilder(
          builder: (context, constraints) => VideoApp(
            videoHeight: constraints.maxWidth / 2,
            description: const Text('data'),
            gitHubUrl: 'https://github.com/Akhand-Pratap-Tiwari/Automatic-Extractive-Text-Summarization-using-TF-IDF',
            videoLink: 'assets/vids/gdsc_rec_app.mp4',
          ),
        ),
      )
    ];
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: (){}),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Material(
              color: Colors.black45,
              child: TabBar(
                onTap: (value) {
                  selectedIndex = value;
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
                  6,
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
          SizedBox(
            width: size.width,
            height: size.height,
            // color: Colors.red,
            child: LottieBuilder.asset(
              'assets/anim/waves.json',
              fit: BoxFit.fitWidth,
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 64.0),
                  child: MyTopContainer(
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
        ],
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
  var _borderRadius = BorderRadius.circular(32);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: _borderRadius,
      elevation: 20,
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
          borderRadius: _borderRadius,
        ),
        child: InkWell(
          onTap: () {},
          onHover: (value) => setState(() {
            if (value) {
              _borderRadius = BorderRadius.circular(8);
            } else {
              _borderRadius = BorderRadius.circular(32);
            }
          }),
          child: ClipRRect(
            borderRadius: _borderRadius,
            child: Image.asset(_skillPaths[widget.index]),
          ),
        ),
      ),
    );
  }
}
