import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/resultdata.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:hello_world/model/api.dart';
import 'dart:ui' as ui;
import 'dart:io';

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
  detailDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Column(
                children: [
                  Image.network(
                      'https://github.com/618knot/circle_judge/blob/main/images/panel001.png?raw=true'),
                  const Text(
                    'sampleサークル',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
              content: const Text('アラートダイアログだよ'),
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

  Widget header() {
    return Container(
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
    );
  }

  Widget firstCard(
      context, String circleName, double matchingRate, String introduction,String ImageUrl) {
    return GestureDetector(
      onTap: () {
        print('タップされました');
        detailDialog(context);
      },
      child: Card(
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
                    ImageUrl,width: 100,height: 100,),
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

  Widget secondThirdCard(
      context, String circleName, double matchingRate, String introduction) {
    return GestureDetector(
      onTap: () {
        print('タップされました');
        detailDialog(context);
      },
      child: Card(
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
                child: Text(
                  '$introduction',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                color: Colors.lightBlue,
                height: 88,
              )
            ],
          )),
    );
  }

  Widget buttons(context) {
    return Align(
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
              onPressed: () => shareImageAndText('result', shareKey),
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
          body: SafeArea(
        child: Center( 
            child: Column(
              children: [
                header(),
                firstCard(context, resultLoad(0).circlename, resultLoad(0).percent,
                    resultLoad(0).circle_description,resultLoad(0).circle_image_url),
                secondThirdCard(context, resultLoad(1).circlename, resultLoad(1).percent,
                    resultLoad(1).circle_description),
                secondThirdCard(context, resultLoad(2).circlename, resultLoad(2).percent,
                    resultLoad(2).circle_description),
                buttons(context),
              ],
            ),
        ),
      )),
    );
  }

  Result resultLoad(int num){
    if(ResultData().GetCircle(num)==null){
      return Result(0, "読み込み中", 0, 'https://github.com/618knot/circle_judge/blob/main/images/panel001.png?raw=true', "読み込み中");
    }
    return ResultData().GetCircle(num);
  }
}
