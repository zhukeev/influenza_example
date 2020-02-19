import 'package:flutter/material.dart';
import 'package:influenza_example/CustomScrollBehavior.dart';
import 'package:influenza_example/CustomScrollPhysics.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  static const FULL_SCALE = 1.0;
  PageController controller = PageController(viewportFraction: .6);
  var currentPageValue = 0.0;
  var previousPage;
  static const images = [
    'assets/images/influenza_virus.png',
    'assets/images/virus2.png',
    'assets/images/virus3.png',
    'assets/images/virus4.png',
  ];

  ValueNotifier<double> pageNotifier;

  ScrollPhysics _physics;

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

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    pageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    print(controller.position);
    return Scaffold(
      backgroundColor: Colors.black,
      body: buildPageView(),
    );
  }

  Widget buildPage(int position, String text) {
    var imgUrl = images[position % images.length];

    return Container(
      color: position % 2 == 0
          ? Colors.blue.withOpacity(.2)
          : Colors.pink.withOpacity(.2),
      child: Center(
          child: Container(
              width: MediaQuery.of(context).size.width * .8,
              child: Image.asset(
                imgUrl,
//                    color: position % 2 == 0 ? Colors.blue : Colors.pink,
              ))),
    );
  }

  Widget buildPageView() {
    return Stack(
      children: <Widget>[
        ScrollConfiguration(
          behavior: MyBehavior(),
          child: PageView.builder(
              controller: controller,
              itemCount: 10,
              scrollDirection: Axis.vertical,
              physics: _physics,
              itemBuilder: (context, position) {
                final scale =
                    FULL_SCALE - (position - (currentPageValue)).abs();

                if (position == currentPageValue.floor()) {
                  return Transform.translate(
                    offset: Offset(0.0, -36.0),
                    child: Transform.scale(
                      scale: scale,
                      child: buildPage(position, 'from'),
                    ),
                  );
                } else if (position == currentPageValue.floor() + 1) {
                  return Transform.translate(
                    offset: Offset(0.0, -36.0),
                    child: Transform.scale(
                      scale: scale,
                      child: buildPage(position, 'to'),
                    ),
                  );
                } else {
                  return buildPage(position, 'default');
                }
              }),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * .15,
          left: 16,
          child: Text(
            'Cold Virus',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w100, fontSize: 40),
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
                      'Fever, runny nose, sore throat, muscle pains, headache,coughing, sneezing, fatigue.',
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
            child: SizedBox(
              height: 100,
              width: 70,
              child: FlatButton(
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xFF441FFF),
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
                onPressed: () {},
              ),
            ),
          ),
        )
      ],
    );
  }
}

double opacity(double page) {
  if (page > 0.1) {
    return (page - 1);
  }

  return 1.0;
}
