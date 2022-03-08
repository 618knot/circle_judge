import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:hello_world/judgeProcessPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JudgeProcessPage(),//ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  @override
  _ExampleHomePageState createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage>
    with TickerProviderStateMixin {
  List<String> welcomeImages = [
    "https://github.com/618knot/circle_judge/blob/main/images/panel001.png?raw=true",
    "https://github.com/618knot/circle_judge/blob/main/images/panel002.png?raw=true",
    "https://github.com/618knot/circle_judge/blob/main/images/panel003.png?raw=true",
    "https://github.com/618knot/circle_judge/blob/main/images/panel000.png?raw=true",
    /*"assets/sample1.png",
    "assets/sample2.png",
    "assets/sample3.png",
    "assets/sample1.png",
    "assets/sample2.png",
    "assets/sample3.png",
    */

  ];

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return  Scaffold(
      body:Stack(
        children:<Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child:  TinderSwapCard(
              swipeUp: true,
              swipeDown: true,
              orientation: AmassOrientation.BOTTOM,
              totalNum: welcomeImages.length,
              stackNum: 3,
              swipeEdge: 4.0,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.width * 0.9,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: MediaQuery.of(context).size.width * 0.8,
              cardBuilder: (context, index) => Card(child:Image.network(welcomeImages[index],)
                //Card(child : Image.asset('${welcomeImages[index]}')
              ),
              cardController: controller = CardController(),
              /*swipeUpdateCallback:
                (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //Card is LEFT swiping
              } else if (align.x > 0) {
                //Card is RIGHT swiping
              }
            },*/
              swipeCompleteCallback:
                  (CardSwipeOrientation orientation, int index) {

              },
            ),
          ),
        ],
      ),
    );
  }
}

