import 'package:flutter/material.dart';
import 'package:influenza_example/model/Virus.dart';

class DetailsPage extends StatefulWidget {
  final Virus virus;

  DetailsPage(this.virus);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String heroImageTag;

  @override
  void initState() {
    heroImageTag = widget.virus.image;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {


        setState(() {
          heroImageTag = 'remove_hero';
        });
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Positioned(
                right: -100,
                top: 0,
                bottom: 0,
                child: Hero(
                  tag: widget.virus.image /*heroImageTag*/,
                  child: Transform.rotate(
                    angle: .8,
                    child: Container(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Image.asset(widget.virus.image)),
                  ),
                )),
            Positioned(
              top: MediaQuery.of(context).size.height * .15,
              left: 16,
              child: Text(
                'Cold Virus',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    fontSize: 40),
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
        ),
      ),
    );
  }
}
