import 'package:flutter/material.dart';
import 'package:hello_world/circlarProgressIndicator.dart';
import 'package:hello_world/model/api.dart';

class TitlePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TitlePage> {
  final _assetImage = 'assets/wallpaper.jpeg';
  final cistLogoImage = 'images/cistLogo.png';
  bool isLoading = true;
  bool isTaped = false;
  @override
  void initState() {
    super.initState();
    getController().stream.listen((event) {
      isLoading = false;
      if(isTaped==true){
        Navigator.of(context).pushNamed("/judge");
      }
    });
    GAME_ID_INIT();
    API_Init();
    isLoading = true;
  }

  void onPressedButton() async {
    setState(() {
      isTaped=true;
    });
    if(isLoading==false){
      Navigator.of(context).pushNamed("/judge");
    }

    //GAME_ID_INIT();


    // 完了通知か問題番号を受け取りたい
    // TODO: 問題番号を受け取る処理にリファクタ
    // await Future.delayed(const Duration(milliseconds: 2000), () {});
  }
  Widget CistLogo(){
    return Container(
      margin: EdgeInsets.only(right: 8.95),
      width: 120,
      height: 137,
      child: Image.asset(cistLogoImage,fit: BoxFit.contain,color: Colors.white,),
    );
  }
  Widget HelloCircleText(){
    return Container(
      padding: EdgeInsets.only(left: 0,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          Text('Hello\nCircle',
              style: TextStyle(fontSize: 40,color: Colors.white)),
        ],
      ),
    );
  }
  Widget Title() {
    return Container(
      height: 180,
      width: 286,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CistLogo(),
              HelloCircleText(),
            ],
          ),
          Divider(
            color:Colors.white,
            thickness: 5,
          ),
        ],
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

  Widget PresentedByCistLT(){
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Text(
        'presented by cistLT',
        style: TextStyle(fontSize: 10,color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
        body: GestureDetector(
      onTap: () {
        onPressedButton();
      },
      child: Container(

        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 3,
              ),
              Title(),
              Spacer(
                flex: 1,
              ),
              Text(
                "~ TAP TO START ~",
                style: TextStyle(fontSize: 20,color: Colors.white),
              ),
              circleProgressIndicator(visible: isLoading==true&&isTaped==true),
              Spacer(flex: 3),
              Expanded(child: Container()),//画面下にテキスト配置するため
              PresentedByCistLT()
            ],
          ),
        ),
      ),
    ));
  }
}
