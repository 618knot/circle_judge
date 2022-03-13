import 'package:flutter/material.dart';
import 'package:hello_world/circlarProgressIndicator.dart';
import 'package:hello_world/model/api.dart';

class TitlePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TitlePage> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getController().stream.listen((event) {
      isLoading = false;
      Navigator.of(context).pushNamed("/judge");
    });
  }

  void onPressedButton() async {
    setState(() {
      isLoading = true;
    });

    GAME_ID_INIT();
    API_Init();

    // 完了通知か問題番号を受け取りたい
    // TODO: 問題番号を受け取る処理にリファクタ
    // await Future.delayed(const Duration(milliseconds: 2000), () {});
  }

  Widget Title() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        "サークル診断アプリ",
        style: TextStyle(fontSize: 40),
      ),
    );
  }

  Widget StartButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.symmetric(),
          child: Text("始める"),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('wallpaper.jpeg'),
        fit: BoxFit.cover,
      )),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Title(),
            Spacer(flex: 1),
            circleProgressIndicator(visible: isLoading),
            ElevatedButton(onPressed: onPressedButton, child: Text("始める")),
            Spacer(flex: 3),
          ],
        ),
      ),
    ));
  }
}
