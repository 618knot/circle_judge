import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/header.dart';
import 'package:hello_world/model/api.dart';
import 'package:hello_world/resultdata.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPage createState() => _ResultPage();
}

class _ResultPage extends State<ResultPage> {
  @override
  void initState() {
    getresultController().stream.listen((event) {
      setState(() {});
      print("finish_load");
    });
  }

  detailDialog(
      context, String imageUrl, String circleName, String introduction) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Column(
                children: [
                  Image.network(imageUrl),
                  Text(
                    circleName,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  )
                ],
              ),
              content: Text(introduction),
              actions: [
                Container(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () => {Navigator.pop(context)},
                      child: const Text(
                        '閉じる',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ));
  }

  Widget firstCard(context, String circleName, double matchingRate,
      String introduction, String imageUrl) {
    return GestureDetector(
      onTap: () {
        print('タップされました');
        detailDialog(context, imageUrl, circleName, introduction);
      },
      child: Card(
        margin: EdgeInsets.only(
          top: 10,
          right: 20,
          left: 20,
        ),
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
                    width: MediaQuery.of(context).size.width * matchingRate,
                  ), //メーター

                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      '$circleName',
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
                    imageUrl,
                    width: 100,
                    height: 100,
                  ),
                  Flexible(
                    child: Container(
                      child: Text(
                        '$introduction',
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
    );
  }

  Widget secondThirdCard(context, String circleName, double matchingRate,
      String introduction, String imageUrl) {
    return GestureDetector(
      onTap: () {
        print('タップされました');
        detailDialog(context, imageUrl, circleName, introduction);
      },
      child: Card(
          margin: EdgeInsets.only(
            top: 10,
            right: 20,
            left: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      margin: const EdgeInsets.only(left: 80, top: 1),
                      child: Text(
                        '$circleName',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      margin: const EdgeInsets.only(left: 10, top: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Text(
                        '1位',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      margin: const EdgeInsets.only(left: 240, top: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Text(
                        'おすすめ度' + (matchingRate.round() * 100).toString() + '%',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(//パーセントバーと「画像と説明Row」
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3.0,bottom: 3.0),
                      child: PercentageBar(matchingRate: matchingRate,),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Stack(
                              children: [
                                Image.network(
                                  imageUrl,
                                  width: 100,
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              child: Text(
                                '$introduction',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              height: 110,
                              margin: EdgeInsets.only(left: 8.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget buttons(context) {
    return Container(
      height: 90,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: const CircleBorder(),
            ),
            onPressed: () => shareImageAndText('result', shareKey),
            child: const Icon(
              Icons.share,
              color: Colors.black,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/title");
            },
            child: const Text(
              'タイトルへ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final GlobalKey shareKey = GlobalKey();

  Future<ByteData> exportToImage(GlobalKey globalKey) async {
    final boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(
      pixelRatio: 3,
    );
    final byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData!;
  }

  Future<File> getApplicationDocumentsFile(
      String text, List<int> imageData) async {
    final directory = await getApplicationDocumentsDirectory();

    final exportFile = File('${directory.path}/$text.png');
    if (!await exportFile.exists()) {
      await exportFile.create(recursive: true);
    }
    final file = await exportFile.writeAsBytes(imageData);
    return file;
  }

  void shareImageAndText(String text, GlobalKey globalKey) async {
    //shareする際のテキスト
    try {
      final bytes = await exportToImage(globalKey);
      //byte data→Uint8List
      final widgetImageBytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      //App directoryファイルに保存
      final applicationDocumentsFile =
          await getApplicationDocumentsFile(text, widgetImageBytes);

      final path = applicationDocumentsFile.path;
      await ShareExtend.share(path, "image");
      print(path);
      // applicationDocumentsFile.delete();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: shareKey,
      child: Scaffold(
        appBar: Header('診断結果'),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                firstCard(
                    context,
                    resultLoad(0).circlename,
                    resultLoad(0).percent,
                    resultLoad(0).circle_description,
                    resultLoad(0).circle_image_url),
                secondThirdCard(
                    context,
                    resultLoad(1).circlename,
                    resultLoad(1).percent,
                    resultLoad(1).circle_description,
                    resultLoad(1).circle_image_url),
                secondThirdCard(
                    context,
                    resultLoad(2).circlename,
                    resultLoad(2).percent,
                    resultLoad(2).circle_description,
                    resultLoad(2).circle_image_url)
              ],
            ),
          ),
        ),
        bottomNavigationBar: buttons(context),
      ),
    );
  }

  Result resultLoad(int num) {
    if (ResultData().GetCircle(num) == null) {
      return Result(
          0,
          "読み込み中",
          0,
          'https://github.com/618knot/circle_judge/blob/main/images/panel001.png?raw=true',
          "読み込み中");
    }
    return ResultData().GetCircle(num);
  }
}

class PercentageBar extends StatelessWidget {
  static const double height = 10;
  static const int graduationMargin = 50;
  PercentageBar({
    Key? key,
    required this.matchingRate,
  }) : super(key: key);
  final double matchingRate;
  int toPercent(double rate){//0~1の少数を0~100の整数に変換
    return  (rate * 100).toInt();//切り捨て
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color:Color(0xff220f60),height: height),
        Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xff7BD4F1).withOpacity(matchingRate),
                  Color(0xff7BD4F1).withOpacity(matchingRate),
                  Color(0xff220f60),
                ]
            )
        ),
        height: height,
      ),
      ],
    );
  }
}