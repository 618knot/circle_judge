import 'package:flutter/material.dart';
import 'package:hello_world/model/api.dart';
import 'package:hello_world/tinderCards.dart';
import 'package:hello_world/ProgressDotsBar.dart';
import 'package:hello_world/header.dart';
class JudgeProcessPage extends StatefulWidget {
  judgeProcessPage() {
    //getController().stream.listen((event) {print("イベント");});
  }

  @override
  _JudgeProcessPageState createState() => _JudgeProcessPageState();
}

class _JudgeProcessPageState extends State<JudgeProcessPage> {
  var cardController = getCardController();
  Widget buttonsMenu() {
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: "good",
            onPressed: () {cardController.triggerLeft();},
            child: const Icon(Icons.thumb_down_alt_outlined),
            backgroundColor: Theme.of(context).primaryColor
          ),
          FloatingActionButton(
            heroTag: "bad",
            onPressed: () {cardController.triggerRight();},
            child: const Icon(Icons.thumb_up_alt_outlined),
            backgroundColor: Theme.of(context).primaryColor
          ),
        ],
      ),
    );
  }

  Widget _dummyCard() {
    //本命のwidgetが実装されるまでの措置
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(100.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("Q1"),
          Image.network(
              "https://github.com/618knot/circle_judge/blob/main/images/panel001.png?raw=true"),
          const Text("HelloWorldですか？")
        ],
      )),
    ));
  }

  @override
  void initState() {
    getController().stream.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header('診断中'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProgressDotsBar(),
          //Expanded(child: _dummyCard()),//本命のwidgetが実装されるまでの措置
          Expanded(child: TinderCards()),
          //Expanded(child:buttonsMenu()),
          buttonsMenu()
        ],
      ),
    );
  }
}
