import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:hello_world/judgeProcessPage.dart';
import 'package:hello_world/resultPage.dart';
import 'package:hello_world/titlePage.dart';

void main() => runApp(MyApp());

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HelloCircle',
      theme: ThemeData(
          primarySwatch: Colors.blue, primaryColor: HexColor('220f60')),
      // home: JudgeProcessPage(),//ExampleHomePage(),
      home: TitlePage(),
      routes: <String, WidgetBuilder>{
        '/title': (BuildContext context) => TitlePage(),
        '/judge': (BuildContext context) => JudgeProcessPage(),
        '/result': (BuildContext context) => ResultPage(),
      },
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

    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: TinderSwapCard(
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
            cardBuilder: (context, index) => Card(
                child: Image.network(
              welcomeImages[index],
            )
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
                (CardSwipeOrientation orientation, int index) {},
          ),
        ),
      ),
    );
  }
}
