import 'package:flutter/material.dart';

class circleProgressIndicator extends StatelessWidget {
  circleProgressIndicator({@required this.visible = false});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return visible
        ? Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent))
              ],
            ),
          )
        : Container();
  }
}
