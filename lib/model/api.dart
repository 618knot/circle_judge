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

// モックAPIからカードに描画する情報を取得する
Future getQuestion() async {
  var url = Uri.parse('https://quiet-eyrie-21766.herokuapp.com/question');
  Map<String, String> headers = {'content-type': 'application/json'};
  while (QuestionData.gameId == null) {
    await Future.delayed(Duration(microseconds: 20));
    print("wait");
  }
  String? gameId = QuestionData.gameId;

  http.Response response;

  String body;

  for (int i = 1; i <= 6; i++) {
    body = json.encode({
      "game_id": gameId,
      "question_id": i,
    });
    print(body);
    response = await http.post(url, headers: headers, body: body);
    List data = json.decode(response.body);
    String image = data[0]["image_url"];
    String sentence = data[0]["question"];
    var jsonsentence = json.encode(sentence);
    var utf8sentence = utf8.decode(jsonsentence.runes.toList());
    QuestionData()
        .set(i - 1, Question(i, utf8sentence.replaceAll('"', ''), image));
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

Future getResult() async {
  print("aaaaaaa");
  var url = Uri.parse('https://quiet-eyrie-21766.herokuapp.com/result');
  Map<String, String> headers = {'content-type': 'application/json'};

  String? gameId = QuestionData.gameId;

  http.Response response = await http.get(url);

  for (int i = 0; i < QuestionData().getlength(); i++) {
    String body = json.encode({
      "game_id": gameId,
    });
    print(body);
    response = await http.post(url, headers: headers, body: body);
    var data = json.decode(response.body);
    List rankingData = data["ranking"];
    var jsonsentence = json.encode(rankingData);
    var utf8sentence = utf8.decode(jsonsentence.runes.toList());
    print(utf8sentence);

    int circlerank = 1;
    String circlename = "cistLT";
    double percent = 0.3333333333333333;
    String circle_image_url =
        "https://cist-lt-group.web.app/static/media/logo.436cc4cb.svg";
    String circle_description =
        "IT技術系の勉強をしています！初心者大歓迎です！所属メンバーはバイオ系、電子工学系、情報工学系と様々なメンバーで構成されています！！みんなで興味のあることを勉強し、アウトプットすることを目標にしています！一人で悩まないで！一緒に技術力を高めませんか？？";
    ResultData().set(
        i - 1,
        Result(circlerank, circlename, percent, circle_image_url,
            circle_description));
  }

  // endを呼ぶ
  postGameEnd();
  Resultcontroller.sink.add(true);
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
