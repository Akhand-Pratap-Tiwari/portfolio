import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/tablet_layout/t_home/t_top_container.dart';
import 'package:portfolio/tablet_layout/t_home/video_player.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

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

  ///Tabs here
  final List<String> _tabNames = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Work Exp.',
  ];

  final String expAndRes =
      '- Leader of group in project exhibition in 2 consecutive sems.\n'
      '- Speaker at Flutter Forward event.\n'
      '- Speaker at GDSC Techathon Event.\n'
      '- Android Core Team Member of Google Developer Students Club (VIT, Bhopal)\n'
      '- Member of UX/UI design team of new LINUX distro.\n'
      '- Member of UX/UI design team of a new malnutrition tracking app.\n'
      '- GitHub Contributor at GDSC VIT, Bhopal organization';

  late TabController _tabController;
  late ScrollController _scrollController;

  late List<GlobalKey<State<StatefulWidget>>> keyList;

  // int selectedIndex = 0;

  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  
  Color _tabBarColor = Colors.pinkAccent;
  @override
  void initState() {
    keyList = List.generate(_tabNames.length, (index) => GlobalKey());

    _tabController = TabController(
      length: keyList.length,
      vsync: this,
      animationDuration: const Duration(milliseconds: 100),
    );

    _scrollController = ScrollController()
      ..addListener(() {
        if(_scrollController.offset == 0) {
          setState(() {
          _tabBarColor = Colors.pinkAccent;
        });
        } else if(_tabBarColor != Colors.black45) {
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
            debugPrint('$selectedIndex');
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
            debugPrint('$selectedIndex');
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
                    );
                  },
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
          builder: (context, constraints) =>
              ProjectView(constraints: constraints),
        ),
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
              elevation: 20,
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
          Align(
            alignment: Alignment.centerRight,
            child: contactBar,
          )
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

class ProjectView extends StatefulWidget {
  final BoxConstraints constraints;

  const ProjectView({super.key, required this.constraints});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  List<List<String>> gitVidTitlDesc = [
    [
      'https://github.com/Akhand-Pratap-Tiwari/Project-Exhibition-Final',
      'assets/vids/befap.mp4',
      'Product Result Aggregator for Online Shopping (Jul 22 - Oct 22)',
      '${' ' * 5}- Description: There are only two major platforms from where most of the Indians do online shopping and '
          'those are Flipkart and Amazon. The most painful thing is to choose the correct product while also '
          'comparing the choices from both the platforms. We made a website to ease it. It has following aims:\n\n'
          '${' ' * 10}a- Fetch product from both platforms and present them at a single place.\n'
          '${' ' * 10}b- Use AI to randomly sample reviews and make a simple summary out of them for the user.\n'
          '${' ' * 10}c- Use AI to also determine the positivity of randomly sampled reviews.\n'
          '${' ' * 10}d- A ranking system that can rank products using positivity of reviews, quantity of positive and negative reviews, price.\n\n'
          '${' ' * 5}- Technology: HTML/CSS, JavaScript, ReactJS, MongoDB, Node.js, Python, numpy, scikit, nltk\n'
          '${' ' * 5}- Team Project: 5 members\n'
          '${' ' * 5}- Role: Project Lead with following responsibilities: System design and workflow, make the Ranking system, AI model for Review Summarization',
    ],
    [
      'https://github.com/Akhand-Pratap-Tiwari/QT_Passenger',
      'https://drive.google.com/uc?id=14QUxAu8iEVrI8-KeXy-JAuoPoIbzjlpq&export=download',
      'Flexible Taxi App (Nov 22 - Feb 23)',
      '${' ' * 5}- Description: We made a Taxi app that allows passengers to post a requirement about when and where they '
          'want to go. Then on this requirement drivers can emit bids. Then the passenger can choose the appropriate '
          'bid they want to accept. This increases the reachability of drivers and helps passengers to get a fair look at price.\n'
          '${' ' * 5}- NOTE: This project works in conjunction with this project https://github.com/AkhandPratap-Tiwari/QT_Driver\n'
          '${' ' * 5}- Technology: Flutter, Dart, Firebase, FlutterFire, FirebaseCLI\n'
          '${' ' * 5}- Team Project: 5 members\n'
          '${' ' * 5}- Role: Project Lead with following responsibilities: System Design, UX/UI design, Backend of Passenger side',
    ],
//     [
//        'https://github.com/Akhand-Pratap-Tiwari/who-borrowed-what',
//       'https://drive.google.com/uc?id=14QUxAu8iEVrI8-KeXy-JAuoPoIbzjlpq&export=download',
//       'Who Borrowed What (Mar 10 - Ongoing)',
//       '${' ' * 5}- Description: This was for my personal use and an exploratory project. I usually lend my notes, assignments'
// 'and projects to my mates and tend to forget about those and then panic later. To solve this issue, I made'
// 'an Android app for myself to keep track of objects that I have lent. My aim was also to explore the'
// 'technology stack in depth as well and what new skills I can add to the arsenal.\n'
// '${' ' * 5}- My further plan is to get this on the app store and then further integrate and use analytics tools to observe'
// 'the traffic and potentially use AI/ML to derive some insights about the app. '
//           '${' ' * 5}- Technology: Flutter, Dart, Firebase, FirebaseUI for Flutter, FirebaseCLI\n'
//           '${' ' * 5}- Team Project: No\n'
//           '${' ' * 5}- Role: From system design to final implementation.\n',
//     ]
  ];
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // debugPrint('debug2 :' + widget.constraints.toString());
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: widget.constraints.maxWidth,
          height: widget.constraints.maxWidth + 18,
          child: PageView.builder(
            // physics: BouncingScrollPhysics(),
            controller: _pageController,
            itemCount: gitVidTitlDesc.length,
            itemBuilder: (context, index) => SingleChildScrollView(
              child: Column(
                children: [
                  VideoApp(
                    videoHeight: widget.constraints.maxWidth / 2,
                    gitHubUrl: gitVidTitlDesc[index][0],
                    videoLink: gitVidTitlDesc[index][1],
                  ),
                  const Divider(color: Colors.transparent),
                  const Divider(color: Colors.transparent),
                  // const Divider(color: Colors.transparent),
                  // const Divider(color: Colors.transparent),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          indent: 8,
                          endIndent: 8,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        gitVidTitlDesc[index][2],
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: Colors.teal.shade300),
                      ),
                      const Expanded(
                        child: Divider(
                          indent: 8,
                          endIndent: 8,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  Text(gitVidTitlDesc[index][3])
                  // widget.description
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 24, 8, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () {
                  // debugPrint('debug3 :' +_pageController.page.toString());
                  _pageController.previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInToLinear);
                },
                backgroundColor: Colors.white.withOpacity(0.5),
                child: const Icon(Icons.chevron_left_rounded),
              ),
              // AnimatedSmoothIndicator(activeIndex: activeIndex, count: count)
              SmoothPageIndicator(
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.white,
                  activeDotColor: Colors.black,
                ),
                controller: _pageController,
                count: gitVidTitlDesc.length,
              ),
              FloatingActionButton(
                onPressed: () {
                  // debugPrint('debug3 :'+_pageController.page.toString());
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInToLinear,
                  );
                },
                backgroundColor: Colors.white.withOpacity(0.5),
                child: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
