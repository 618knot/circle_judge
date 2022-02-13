import 'package:flutter/material.dart';

class JudgeProcessPage extends StatefulWidget {
  @override
  _JudgeProcessPageState createState() => _JudgeProcessPageState();
}

class _JudgeProcessPageState extends State<JudgeProcessPage> {
  Widget buttonsMenu(){
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(onPressed: (){}, child: const Icon(Icons.thumb_down_alt_outlined),backgroundColor: Colors.deepOrange,),
          FloatingActionButton(onPressed: (){}, child: const Icon(Icons.thumb_up_alt_outlined),backgroundColor: Colors.lightGreen,),
        ],
      ),
    );
  }
  Widget _dummyCard(){
    return Card(child: Padding(
      padding: EdgeInsets.all(100.0),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Q1"),
          Image.network("https://github.com/618knot/circle_judge/blob/main/images/panel001.png?raw=true"),
          Text("HelloWorldですか？")
        ],
      )),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("診断中")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: _dummyCard()),
          buttonsMenu(),
        ],
      ),
    );
  }
}
