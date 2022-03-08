import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:hello_world/model/api.dart';
import 'package:hello_world/questiondata.dart';

class TinderCards extends StatelessWidget {
  /*TinderCards(){
    //api.dartとの連携部分。呼ぶだけにして処理そのものはQuestionDataに移植するかも
    print("データセット");
    QuestionData().set(0,Question(0,"問題文のテストだよ","https://github.com/618knot/circle_judge/blob/main/images/panel001.png?raw=true"));
    QuestionData().set(1,Question(1,"第二問はすこーし長い文章のテストだよ","https://github.com/618knot/circle_judge/blob/main/images/panel002.png?raw=true"));
    QuestionData().set(2,Question(2,"最終問題","https://github.com/618knot/circle_judge/blob/main/images/panel003.png?raw=true"));
    QuestionData().set(3,Question(3,"質問おわり","https://github.com/618knot/circle_judge/blob/main/images/panel000.png?raw=true"));
  }*/
  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,

      child :TinderSwapCard(
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
                    height: 230,
                  ),
                ],
              )
          )
        ],
      ),
      cardController: controller = CardController(),
      swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
        print(orientation.name);
        print(index);
        if (orientation.name == "RIGHT") {
          QuestionData().SetAnswer(true, index);
        } else if (orientation.name == "LEFT") {
          QuestionData().SetAnswer(false, index);
        }
        if (index + 1 == QuestionData().getlength()&&orientation.name!="RECOVER") {
          GAME_END();
        }
        },
      ),
    );
  }
}
