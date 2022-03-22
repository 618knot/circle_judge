import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:hello_world/model/api.dart';
import 'package:hello_world/questiondata.dart';

final controller = StreamController<int>.broadcast();
final cardController = CardController();

CardController getCardController(){
  return cardController;
}

StreamController<int> getQuestionIDController() {
  return controller;
}

class TinderCards extends StatelessWidget {
  void fn(int x) {
    controller.sink.add(x + 1);
  }


  /*TinderCards(){
    //api.dartとの連携部分。呼ぶだけにして処理そのものはQuestionDataに移植するかも
    print("データセット");
    QuestionData().set(0,Question(0,"問題文のテストだよ","https://github.com/618knot/circle_judge/blob/main/images/panel001.png?raw=true"));
    QuestionData().set(1,Question(1,"第二問はすこーし長い文章のテストだよ","https://github.com/618knot/circle_judge/blob/main/images/panel002.png?raw=true"));
    QuestionData().set(2,Question(2,"最終問題","https://github.com/618knot/circle_judge/blob/main/images/panel003.png?raw=true"));
    QuestionData().set(3,Question(3,"質問おわり","https://github.com/618knot/circle_judge/blob/main/images/panel000.png?raw=true"));
  }*/
  //static final controller = StreamController<int>();

  double clear_maru=0.0;
  double clear_batsu=0.0;

  double First(index,clear){
    if(index==0){
      return clear;
    }else{
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Stack(
      //height: MediaQuery.of(context).size.height * 0.6,
      children:<Widget>[
        TinderSwapCard(
          swipeUp: true,
          swipeDown: true,
          orientation: AmassOrientation.BOTTOM,
          totalNum: QuestionData().getlength(),
          stackNum: 3,
          swipeEdge: 4.0,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.width * 0.9,
          minWidth: MediaQuery.of(context).size.width * 0.8,
          minHeight: MediaQuery.of(context).size.width * 0.8,
          cardBuilder: (context, index) =>
          //StreamBuilder<bool>(
          //stream:controller.st
          Column(
            children: [
              Card(
                color: Colors.grey,
                child: Column(
                  children: [
                    Text(
                      QuestionData().GetQuestion(index),
                      style: TextStyle(fontSize: 35),
                    ),
                    Image.network(
                      QuestionData().GetImage(index),
                      fit: BoxFit.contain /*: 240, */,
                      height: 170,
                    ),
                  ],
                ))
          ],
        ),
        cardController: cardController,
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          print(orientation.name);
          print(index);
          if (orientation.name == "RIGHT") {
            QuestionData().SetAnswer(true, index);
          } else if (orientation.name == "LEFT") {
            QuestionData().SetAnswer(false, index);
          }
          if (index + 1 == QuestionData().getlength() &&
              orientation.name != "RECOVER") {

              )

            ],
          ),

          cardController: cardController,
          swipeCompleteCallback: (CardSwipeOrientation orientation,int index) {
            print(orientation.name);
            print(index);

            if (orientation.name == "RIGHT") {
              QuestionData().SetAnswer(true, index);
              clear_maru = 0.0;
            } else if (orientation.name == "LEFT") {
              QuestionData().SetAnswer(false, index);
              clear_batsu = 0.0;
            }

            if (index + 1 == QuestionData().getlength() &&
                orientation.name != "RECOVER") {
              GAME_END();
            }

            print(orientation.name);
            print(index);
            if (orientation.name == "RIGHT") {
              QuestionData().SetAnswer(true, index);
            } else if (orientation.name == "LEFT") {
              QuestionData().SetAnswer(false, index);
            }
            if (index + 1 == QuestionData().getlength() &&
                orientation.name != "RECOVER") {

              Navigator.of(context).pushNamed("/result");

              GAME_END();
            }
            fn(index);
          },
          swipeUpdateCallback:(DragUpdateDetails details, Alignment align) {
    if(align.x>10){
    clear_maru=1.0;
    }else if(align.x<0){
    clear_maru=0.0;
    }else{
    clear_maru=align.x/10;
    }

    if(align.x<-10){
    clear_batsu=1.0;
    }else if(align.x>0){
    clear_batsu=0.0;
    }else{
    clear_batsu=-(align.x/10);
    }

            GAME_END();
          }
          if(orientation.name!="RECOVER"){
          fn(index);
          }
        },
        ),
        /*
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/maru.png")
            )
          ),
          alignment: Alignment.center
        )
        */
      ],

    );
  }
}
