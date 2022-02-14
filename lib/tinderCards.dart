import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class TinderCards extends StatelessWidget {
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
  List<String> QuestionSentence = [
    "あなたは〇〇ですか？",
    "あなたは△△ですか？",
    "あなたは××ですか？",
    "質問は以上です"
  ];

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.6,
      child: TinderSwapCard(
        swipeUp: true,
        swipeDown: true,
        orientation: AmassOrientation.BOTTOM,
        totalNum: welcomeImages.length,
        stackNum: 3,
        swipeEdge: 4.0,
        maxWidth: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        maxHeight: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        minWidth: MediaQuery
            .of(context)
            .size
            .width * 0.8,
        minHeight: MediaQuery
            .of(context)
            .size
            .width * 0.8,
        cardBuilder: (context, index) =>
            Column(
              children:[


                //Text(QuestionSentence[index],style: TextStyle(fontSize: 35),),
                //Image.network(welcomeImages[index]),
                Card(
                //  constraints: BoxConstraints.expand(),
                  color:Colors.grey,
                    child:
                          Column(
                            children: [
                              Text(QuestionSentence[index],
                                style: TextStyle(fontSize: 35),),
                              Image.network(
                                welcomeImages[index], fit:BoxFit.contain/*: 240, */,height: 230,),
                            ],)
                )
                /*Padding(
                padding: EdgeInsets.all(30),
                //Container(child: )
                child:*/
                //color: Colors.blue,


                //Card(child : Image.asset('${welcomeImages[index]}')

              ],

            )
        /* Card(
                child: Container(decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(welcomeImages[index]))
                  //Image.network(welcomeImages[index],)

                ),
                  child: Text(QuestionSentence[index]),
                )

              //title: Text('${fromProvinces[index]}'),
            )*/,
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
          /// Get orientation & index of swiped card!
        },
      ),
    );
  }
}
