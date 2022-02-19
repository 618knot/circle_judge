import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


// TODO:最終的にはWidget部分はこのクラスに書かず切り出したい
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
  Map data = new Map();
  List userData = [];
  String startData = "0";

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
  Future getUser() async {
    var url = Uri.parse('https://reqres.in/api/users?page=2');
    http.Response response = await http.get(url);
    data = json.decode(response.body); //json->Mapオブジェクトに格納
    setState(() { //状態が変化した場合によばれる
      userData = data["data"]; //Map->Listに必要な情報だけ格納
    });
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

  @override
  void initState() {
    super.initState();
    getUser();
    // postStart();
    // postQuestion();
    // postAnswer();
    // postAnswer();
    // postResult();
  }
}