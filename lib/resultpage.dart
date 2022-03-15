import 'package:flutter/material.dart';
import 'package:hello_world/resultdata.dart';
import 'package:hello_world/model/api.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPage createState() => _ResultPage();
}

class _ResultPage extends State<ResultPage> {
  //const ResultPage({Key? key}) : super(key: key);

  @override
  void initState() {
    getresultController().stream.listen((event) {
      setState(() {});
      print("finish_load");
    });
  }

  @override
  Widget build(BuildContext context) {
    List<double> matchingRate = [0.8, 0.5, 0.3];

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.grey,
              child: Column(
                children: [
                  const Text(
                    '診断結果',
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                  const Text(
                    'あなたにおすすめのサークルは....',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.yellow,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.teal,
                          height: 43,
                          width: MediaQuery.of(context).size.width *
                              matchingRate[0],
                        ), //メーター

                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Text(
                            'xoサークル',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.lightGreen,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            ResultData().GetCircle(1).circlerank),
                        Flexible(
                          child: Container(
                            child: const Text(
                              '全角八十文字あああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            color: Colors.lightBlue,
                            height: 110,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
                color: Colors.yellow,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.teal,
                            height: 43,
                            width: MediaQuery.of(context).size.width *
                                matchingRate[1],
                          ), //メーター

                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'ooサークル',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: const Text(
                        '全角八十文字あああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      color: Colors.lightBlue,
                      height: 88,
                    )
                  ],
                )),
            Card(
                color: Colors.yellow,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.teal,
                            height: 43,
                            width: MediaQuery.of(context).size.width *
                                matchingRate[2],
                          ), //メーター

                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'oxサークル',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: const Text(
                        '全角八十文字あああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      color: Colors.lightBlue,
                      height: 88,
                    )
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                color: Colors.orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {},
                      child: const Icon(Icons.share),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/title");
                        },
                        child: const Text('タイトルへ')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
