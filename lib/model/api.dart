import 'dart:async';
import 'dart:convert';

import 'package:hello_world/questiondata.dart';
import 'package:hello_world/resultdata.dart';
import 'package:http/http.dart' as http;

String startData = "0";
//質問のロード完了通知
final controller = StreamController<bool>.broadcast();
StreamController<bool> getController() {
  return controller;
}

//結果のロード完了通知
final Resultcontroller = StreamController<bool>.broadcast();
StreamController<bool> getresultController() {
  return Resultcontroller;
}

// スタート時にPOSTでゲームIDを取得する
void getGameId() async {
  var url = Uri.parse('https://quiet-eyrie-21766.herokuapp.com/start');
  final response = await http.post(url, headers: {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*'
  });
  Map data = Map();
  data = json.decode(response.body);
  String gameId = data["game_id"];
  // print("gameId:");
  // print(gameId);
  QuestionData.gameId = gameId;
}

Future<bool> questionPost(int num) async {
  http.Response response;
  var url = Uri.parse('https://quiet-eyrie-21766.herokuapp.com/question');
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode({
    "game_id": QuestionData.gameId,
    "question_id": num,
  });
  response = await http.post(url, headers: headers, body: body);
  List data = json.decode(response.body);
  String image = data[0]["image_url"];
  String sentence = data[0]["question"];
  var jsonsentence = json.encode(sentence);
  var utf8sentence = utf8.decode(jsonsentence.runes.toList());
  QuestionData()
      .set(num - 1, Question(num, utf8sentence.replaceAll('"', ''), image));
  print("loaded");
  return true;
}

// モックAPIからカードに描画する情報を取得する
Future getQuestion() async {
  while (QuestionData.gameId == null) {
    await Future.delayed(Duration(microseconds: 20));
    print("wait");
  }
  List<Future<bool>> future = [];
  for (int i = 1; i <= 6; i++) {
    future.add(questionPost(i));
  }
  var futureAll = Future.wait(future);
  futureAll.then((results) => controller.sink.add(true));
}

// バックエンドにPOSTで回答を返却する
Future setQuestion() async {
  var url =
      Uri.parse('https://quiet-eyrie-21766.herokuapp.com/question/answer');
  Map<String, String> headers = {'content-type': 'application/json'};

  String? gameId = QuestionData.gameId;

  http.Response response = await http.get(url);

  Map data = Map();

  for (int i = 1; i <= QuestionData().getlength(); i++) {
    String body = json.encode({
      "game_id": gameId,
      "question_id": i,
      "result": QuestionData().GetAnswer(i - 1),
    });
    print(body);
    response = await http.post(url, headers: headers, body: body);
    data = json.decode(response.body);
    String messageData = data["message"];
    print(messageData);
  }
  // Future.delayed(Duration(microseconds: 300));
  getResult();
}

// decode関数
String jsonDecode(String shiftjisSentence) {
  var jsonsentence = json.encode(shiftjisSentence);
  var utf8sentence = utf8.decode(jsonsentence.runes.toList());
  utf8sentence = utf8sentence.replaceAll('"', '');
  print(utf8sentence);
  return utf8sentence;
}

Future getResult() async {
  print("aaaaaaaaaaaaaaaaaaaaaaaaaaa");
  var url = Uri.parse('https://quiet-eyrie-21766.herokuapp.com/result');
  Map<String, String> headers = {'content-type': 'application/json'};

  String? gameId = QuestionData.gameId;

  http.Response response = await http.get(url);

  for (int i = 0; i < QuestionData().getlength(); i++) {
    print(i);
    String body = json.encode({
      "game_id": gameId,
    });
    // print(body);
    response = await http.post(url, headers: headers, body: body);
    var data = json.decode(response.body);
    var rankingData = data["ranking"];
    // 要素分割してリストにする

    int circle_ranking = i + 1;
    String circle_name = jsonDecode(rankingData[0]["circle_name"]);
    double percent = rankingData[0]["percent"];
    print(percent);
    String circle_image_url = jsonDecode(rankingData[0]["circle_image_url"]);
    String circle_description =
        jsonDecode(rankingData[0]["circle_description"]);

    ResultData().set(
        i,
        Result(
          circle_ranking,
          circle_name,
          percent,
          circle_image_url,
          circle_description,
        ));
    Resultcontroller.sink.add(true);
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
