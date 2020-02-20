import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:influenza_example/CustomScrollBehavior.dart';
import 'package:influenza_example/CustomScrollPhysics.dart';
import 'package:influenza_example/model/Virus.dart';

import 'DetailsPage.dart';
import 'package:influenza_example/Constants.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  static const FULL_SCALE = 1.0;
  PageController controller = PageController(viewportFraction: .4);
  var currentPageValue = 0.0;
  var previousPage;


  ValueNotifier<double> pageNotifier;

  ScrollPhysics _physics;
  double scale = 1.0;

  AnimationController _heroAnimationController;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });

      if (controller.position.haveDimensions && _physics == null) {
        setState(() {
          var dimension = controller.position.maxScrollExtent / (10 - 1);
          _physics = CustomScrollPhysics(itemDimension: dimension);
        });
      }
    });

    previousPage = controller.initialPage;
    pageNotifier = ValueNotifier(1.0);

    _heroAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    pageNotifier.dispose();
    _heroAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 2,
                  colors: [Palette.bgGradientStart, Palette.bgGradientEnd])),
          child: buildPageView()),
    );
  }

  Widget buildPage(int position, String text) {
    var imgUrl = viruses[position].image;
    return Hero(
      tag: imgUrl,
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        final Hero toHero = toHeroContext.widget;

        if (flightDirection == HeroFlightDirection.pop) {
          return ScaleTransition(
            scale: animation,
            child: toHero.child,
          );
        } else
          return RotationTransition(
            turns: animation,
            child: toHero.child,
          );
      },
      child: Container(
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//                Text('$text'),
            Container(
                width: MediaQuery.of(context).size.width * .1,
                height: MediaQuery.of(context).size.width * .1,
                child: Image.asset(
                  imgUrl,
                  fit: BoxFit.cover,
                )),
          ],
        )),
      ),
    );
  }

  Widget buildPageView() {
    return Stack(
      children: <Widget>[
        ScrollConfiguration(
          behavior: MyBehavior(),
          child: PageView.builder(
              controller: controller,
              itemCount: viruses.length,
              scrollDirection: Axis.vertical,

//              physics:   _physics,
              itemBuilder: (context, position) {
                scale = FULL_SCALE - (position - (currentPageValue)).abs();

                if (position == currentPageValue.floor()) {
                  print('from');
                  return Transform.scale(
                    scale: math.max(scale * 6, 1),
                    child: buildPage(position, 'from'),
                  );
                } else if (position == currentPageValue.floor() + 1) {
                  print('to');
                  return Transform.scale(
                    scale: scale * 6,
                    child: buildPage(position, 'to'),
                  );
                } else if (position == currentPageValue.floor() - 1) {
                  print('prev');
                  return buildPage(position, 'previous');
                } else {
                  print('default');
                  return Container(
                    child: Center(child: Text('default')),
                  );
                }
              }),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * .15,
          left: 16,
          child: AnimatedOpacity(
            duration: Duration(microseconds: 300),
            opacity: math.max(
                0,
                1 -
                    double.parse('0.' +
                            currentPageValue.toString().split('.').last) *
                        2),
            child: Text(
              viruses[currentPageValue.floor() % viruses.length].name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 40),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * .7,
          left: 16,
          child: Container(
            width: MediaQuery.of(context).size.width * .6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Symptoms',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: Text(
                      viruses[currentPageValue.floor() % viruses.length]
                          .symptoms,
                      style: TextStyle(
                          color: Colors.white.withOpacity(.6),
                          fontWeight: FontWeight.w300,
                          fontSize: 15)),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: viruses[currentPageValue.floor()].name,
              child: SizedBox(
                height: 100,
                width: 70,
                child: FlatButton(
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Palette.buttonBlue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(Icons.play_arrow, color: Colors.white, size: 40),
                      Text(
                        "Explore",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                  onPressed: () {
                    /*Navigator.of(context).push(FadeRoute(
                        page: DetailsPage(
                            viruses[currentPageValue.floor() % viruses.length])));*/
                    Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: Duration(seconds: 2),
                        pageBuilder: (_, __, ___) => DetailsPage(
                            viruses[currentPageValue.floor() % viruses.length])));
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
