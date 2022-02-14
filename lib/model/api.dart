import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder( //スクロール可能な可変リストを作る
          itemCount: userData == null ? 0 : userData.length, //受け取る数の定義
          itemBuilder: (BuildContext context, int index) { //ここに表示したい内容をindexに応じて
            return Card( //cardデザインを定義:material_design
              child: Row(
                children: <Widget>[
                      Text("${userData[index]["first_name"]} ${userData[index]["last_name"]}"),
                ],
              ),
            );
          },
        )
    );
  }

  Future getData() async {
    var url = Uri.parse('https://reqres.in/api/users?page=2');
    http.Response response = await http.get(url);
    data = json.decode(response.body); //json->Mapオブジェクトに格納
    setState(() { //状態が変化した場合によばれる
      userData = data["data"]; //Map->Listに必要な情報だけ格納
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
}