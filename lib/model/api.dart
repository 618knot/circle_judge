import 'dart:async';
import 'dart:convert';

import 'package:hello_world/questiondata.dart';
import 'package:http/http.dart' as http;

String startData = "0";

final controller = StreamController<bool>.broadcast();

StreamController<bool> getController() {
  return controller;
}

// スタート時にPOSTでゲームIDを取得する
void getGameId() async {
  var url = Uri.parse('https://quiet-eyrie-21766.herokuapp.com/start');
  final response = await http.post(url, headers: {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*'
  });
  Map data = new Map();
  data = json.decode(response.body);
  String gameId = data["game_id"];
  // print("gameId:");
  // print(gameId);
  // TODO:gameIdをreturnする
  QuestionData.gameId = gameId;
}

// モックAPIからカードに描画する情報を取得する
Future getQuestion() async {
  var url = Uri.parse('https://reqres.in/api/users?page=1');
  http.Response response = await http.get(url);

  Map data = new Map();
  List userData = [];
  data = json.decode(response.body); //json->Mapオブジェクトに格納
  userData = data["data"];
  for (var i = 0; i < userData.length; i++) {
    int id = userData[i]["id"];
    String sentence = userData[i]["email"];
    String image = userData[i]["avatar"];
    QuestionData().set(i, Question(id, sentence, image));
    // print(id);
    // print(sentence + image);
  }
  //Map->Listに必要な情報だけ格納
  controller.sink.add(true);
}

// バックエンドにPOSTで回答を返却する
Future setQuestion() async {
  var url =
      Uri.parse('https://quiet-eyrie-21766.herokuapp.com/question/answer');
  Map<String, String> headers = {'content-type': 'application/json'};

  // TODO:ここでgame_idとquestion_idとresultはquestiondataのAnswerを参照したい

  String? gameId = QuestionData.gameId;

  http.Response response = await http.get(url);

  Map data = new Map();

  for (int i = 0; i < QuestionData().getlength(); i++) {
    String body = json.encode({
      "game_id": gameId,
      "question_id": i.toString(),
      "result": QuestionData().GetAnswer(i).toString(),
    });
    print(body);
    response = await http.post(url, headers: headers, body: body);
    data = json.decode(response.body);
    String messageData = data["message"];
    print(messageData);
  }

  getResult();
}

Future getResult() async {
  var url = Uri.parse('https://quiet-eyrie-21766.herokuapp.com/result');
  Map<String, String> headers = {'content-type': 'application/json'};

  String? gameId = QuestionData.gameId;

  http.Response response = await http.get(url);

  Map data = new Map();
  for (int i = 0; i < QuestionData().getlength(); i++) {
    String body = json.encode({
      "game_id": gameId.toString(),
    });
    response = await http.post(url, headers: headers, body: body);

    /* TODO: json.decodeで発生する下記のエラーの修正
    E/flutter (11490): [ERROR:flutter/lib/ui/ui_dart_state.cc(209)] Unhandled Exception: FormatException: Unexpected character (at character 1)
    E/flutter (11490): <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
    E/flutter (11490): ^
     */
    // data = json.decode(response.body);
    // String circleName = data["name"];
    // int ranking = i;
    // ここでresultをQuestionDataに格納し
    // ResultData().set(i, Result(ranking, circleName));
  }

  // endを呼ぶ
  postGameEnd();
}

void postGameEnd() async {
  var url = Uri.parse('https://quiet-eyrie-21766.herokuapp.com/end');
  Map<String, String> headers = {'content-type': 'application/json'};

  String? gameId = QuestionData.gameId;
  http.Response response;
  String body = json.encode({"game_id": gameId});
  response = await http.post(url, headers: headers, body: body);
  print(response);
}

//@override
void API_Init() async {
  await getQuestion();
}

void GAME_ID_INIT() async {
  getGameId();
}

void GAME_END() async {
  setQuestion();
}
