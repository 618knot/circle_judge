import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'ProgressDotsBar.dart';

//ストリームの作成
final controller = StreamController<int>.broadcast();

//streamを他の場所からlistenできるように
StreamController<int> getTestController() {
  return controller;
}

class DotsTestPage extends StatefulWidget {
  @override
  State<DotsTestPage> createState() => _DotsTestPageState();
}

class _DotsTestPageState extends State<DotsTestPage> {

  int currentId = 0;
  //final progBar = GlobalKey<_>();

  void incrementCurrentId(){
    setState(() {
      currentId += 1;
      controller.sink.add(currentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCurrentId,
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: Column(
          children: [
            Text("currentID $currentId"),
            ProgressDot(questionId: 3),//仮に3を渡してみる
          ],
        ),
      ),
    );;
  }
}
