import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ProgressDotsBar.dart';




class DotsTestPage extends StatefulWidget {
  @override
  State<DotsTestPage> createState() => _DotsTestPageState();
}

class _DotsTestPageState extends State<DotsTestPage> {

  int currentId = 0;
  final progBar = GlobalKey<_>();
  void incrementCurrentId(){
    setState(() {
      currentId += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCurrentId,
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: Column(
          children: [
            Text("currentID $currentId"),
            progBar,
          ],
        ),
      ),
    );;
  }
}
