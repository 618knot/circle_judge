import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:hello_world/questiondata.dart';

Map data = new Map();
List userData = [];
String startData = "0";
final controller = StreamController<bool>.broadcast();
  // ゲームスタート時に必要なゲームIDを受け取る
  // Future postStart() async {
  //   var url = Uri.parse('https://circle-judge-backend.herokuapp.com/start');
  //   http.Response response = await http.get(url);
  //   data = json.decode(response.body);
  //   setState(() {
  //     startData = data["message"];
  //   });
  // }
StreamController<bool> getController (){
  return controller;
}

  // モックAPI
  Future getQuestion() async {
    var url = Uri.parse('https://reqres.in/api/users?page=1');
    http.Response response = await http.get(url);
    data = json.decode(response.body); //json->Mapオブジェクトに格納

    userData = data["data"];
    for (var i = 0; i < userData.length; i++) {
      int id = userData[i]["id"];
      String sentence = userData[i]["email"];
      String image = userData[i]["avatar"];
      QuestionData().set(i, Question(id, sentence, image));
      print(id);
      print(sentence+image);
    }
    //Map->Listに必要な情報だけ格納
    controller.sink.add(true);
  }

  // Future postQuestion() async {
  //   var url = Uri.parse('https://circle-judge-backend.herokuapp.com/question');
  //   http.Response response = await http.get(url);
  //   data = json.decode(response.body);
  //   setState(() {
  //     questionData = data["data"];
  //   });
  // }

  // Future postAnswer() async {
  //   var url = Uri.parse('https://circle-judge-backend.herokuapp.com/question/answer');
  //   http.Response response = await http.get(url);
  //   data = json.decode(response.body);
  //   setState(() {
  //     answerData = data["message"];
  //   });
  // }

  // Future postResult() async {
  //   var url = Uri.parse('https://circle-judge-backend.herokuapp.com/result');
  //   http.Response response = await http.get(url);
  //   data = json.decode(response.body);
  //   setState(() {
  //     questionHistoryData = data["question_history"];
  //     rankingData = data["ranking"];
  //   });
  // }

  //@override
  void API_Init() async{
    //super.initState();
    await getQuestion();
    // postStart();
    // postQuestion();
    // postAnswer();
    // postAnswer();
    // postResult();
  }
