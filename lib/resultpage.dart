import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

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
                            'https://github.com/618knot/circle_judge/blob/main/images/panel001.png?raw=true'),
                        Flexible(
                          child: Container(
                            child: const Text(
                              'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            color: Colors.lightBlue,
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
                        'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      color: Colors.lightBlue,
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
                        'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      color: Colors.lightBlue,
                    )
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 60),
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
                        onPressed: () {}, child: const Text('タイトルへ')),
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
