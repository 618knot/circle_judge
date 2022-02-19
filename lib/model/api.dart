import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:hello_world/questiondata.dart';

Map data = new Map();
List userData = [];
String startData = "0";
// TODO:最終的にはWidget部分はこのクラスに書かず切り出したい
/*
void main() {
  runApp(MaterialApp(
    home: ApiConnection(),
  ));
}

class ApiConnection extends StatefulWidget {
  @override
  _ApiConnectionState createState() => _ApiConnectionState();
}

class _ApiConnectionState extends State<ApiConnection> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemCount: userData == null ? 0 : userData.length,
          // itemCount: startData == null ? 0 : startData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(
                children: <Widget>[
                      Text("${userData[index]["first_name"]} ${userData[index]["last_name"]}"),
                  // Text("${startData}"),
                ],
              ),
            );
          },
        )
    );
  }
*/
  // ゲームスタート時に必要なゲームIDを受け取る
  // Future postStart() async {
  //   var url = Uri.parse('https://circle-judge-backend.herokuapp.com/start');
  //   http.Response response = await http.get(url);
  //   data = json.decode(response.body);
  //   setState(() {
  //     startData = data["message"];
  //   });
  // }

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
  void initState() async{
    //super.initState();
    await getQuestion();
    // postStart();
    // postQuestion();
    // postAnswer();
    // postAnswer();
    // postResult();
  }
