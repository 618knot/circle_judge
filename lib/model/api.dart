import 'dart:async';
import 'dart:convert';

import 'package:hello_world/questiondata.dart';
import 'package:http/http.dart' as http;

Map data = new Map();
List userData = [];
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
  data = json.decode(response.body);
  String gameId = data["game_id"];
  print("gameId:");
  print(gameId);
  // TODO:gameIdをreturnする
}

// モックAPIからカードに描画する情報を取得する
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
    print(sentence + image);
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
  String body = json.encode({
    "game_id": "2745e04c-4e5c-4d52-a25a-ff8a48055e1a",
    "question_id": "1",
    "result": true
  });
  http.Response response = await http.post(url, headers: headers, body: body);
  data = json.decode(response.body);
  String messageData = data["data"];
  print(messageData);
}

//@override
void API_Init() async {
  await getQuestion();
}

void GAME_ID_INIT() async {
  getGameId();
  setQuestion();
}
