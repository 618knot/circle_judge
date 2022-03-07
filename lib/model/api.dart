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
  QuestionData.gameId = gameId;
}

// モックAPIからカードに描画する情報を取得する
Future getQuestion() async {
  var url = Uri.parse('https://quiet-eyrie-21766.herokuapp.com/question');
  Map<String, String> headers = {'content-type': 'application/json'};
  while(QuestionData.gameId==null){
    await Future.delayed(Duration(microseconds: 20));
    print("wait");
  }
  String? gameId = QuestionData.gameId;

  http.Response response;

  String body;

  for (int i = 1; i <= 5; i++) {
    body = json.encode({
      "game_id": gameId,
      "question_id": i,
    });
    print(body);
    response = await http.post(url, headers: headers, body: body);
    List data = json.decode(response.body);
    String image=data[0]["image_url"];
    String sentence=data[0]["question"];
    var jsonsentence = json.encode(sentence);
    var utf8sentence = utf8.decode(jsonsentence.runes.toList());
    QuestionData().set(i-1, Question(i, utf8sentence.replaceAll('"', ''), image));
  }
  controller.sink.add(true);
}

// バックエンドにPOSTで回答を返却する
Future setQuestion() async {
  var url =
      Uri.parse('https://quiet-eyrie-21766.herokuapp.com/question/answer');
  Map<String, String> headers = {'content-type': 'application/json'};

  String? gameId = QuestionData.gameId;

  http.Response response = await http.get(url);

  Map data = new Map();

  for (int i = 1; i <= QuestionData().getlength(); i++) {
    String body = json.encode({
      "game_id": gameId,
      "question_id": i,
      "result": QuestionData().GetAnswer(i-1),
    });
    print(body);
    response = await http.post(url, headers: headers, body: body);
    data = json.decode(response.body);
    String messageData = data["message"];
    print(messageData);
  }
}

Future getResult() async {
  var url = Uri.parse('https://quiet-eyrie-21766.herokuapp.com/result');
  Map<String, String> headers = {'content-type': 'application/json'};

  String? gameId = QuestionData.gameId;

  http.Response response = await http.get(url);

  Map data = new Map();
  for (int i = 0; i < QuestionData().getlength(); i++) {
    String body = json.encode({
      "game_id": gameId,
    });
    response = await http.post(url, headers: headers, body: body);

  }

  // endを呼ぶ
  // postGameEnd();
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
