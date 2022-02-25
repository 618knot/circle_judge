import 'package:flutter/material.dart';

class TitlePage extends StatelessWidget {
  Widget Title(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Text("サークル診断アプリ",style: TextStyle(fontSize: 40),),
    );
  }
  Widget StartButton(){
    return ElevatedButton(
        onPressed: (){},
        child: Container(
          padding: EdgeInsets.symmetric(),
          child: Text("始める"),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('wallpaper.jpeg'),
            fit:BoxFit.cover,
          )
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 1,),
              Title(),
              Spacer(flex:1),
              ElevatedButton(onPressed:(){},child: Text("始める")),
              Spacer(flex:3),
            ],
          ),
        ),
      )
    );
  }
}
