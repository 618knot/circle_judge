import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Card(
              color: Colors.yellow,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                          'xoサークル',
                          style: TextStyle(
                          fontSize: 50,
                          ),
                          ),
                  ),

              Container(
                color: Colors.lightGreen,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network('data:image/png;base64,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'),
                  
                    Flexible(
                      child: Container(
                        child: Text(
                              'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
                              style: TextStyle(
                              fontSize: 30,
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
                    alignment: Alignment.topCenter,
                    child: Text(
                          'ooサークル',
                          style: TextStyle(
                          fontSize: 50,
                          ),
                          ),
                  ),

                   Container(
                      child: Text(
                        'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
                        style: TextStyle(
                        fontSize: 30,
                        ),
                      ),
                      color: Colors.lightBlue,
                    )
                    
                ],
              )
            ),

            Card(
              color: Colors.yellow,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                          'oxサークル',
                          style: TextStyle(
                          fontSize: 50,
                          ),
                          ),
                  ),

                   Container(
                      child: Text(
                        'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
                        style: TextStyle(
                        fontSize: 30,
                        ),
                      ),
                      color: Colors.lightBlue,
                    )
                    
                ],
              )
            ),
          ],
        ),
      )
    );
  }
}
