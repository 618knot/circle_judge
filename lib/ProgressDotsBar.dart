import 'package:flutter/material.dart';

class ProgressDot extends StatefulWidget {
  const ProgressDot({Key? key}) : super(key: key);

  @override
  _ProgressDotState createState() => _ProgressDotState();
}

class _ProgressDotState extends State<ProgressDot> {
  Widget Dot() {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dot();
  }
}

class ProgressDotsBar extends StatefulWidget {
  const ProgressDotsBar({Key? key}) : super(key: key);

  @override
  _ProgressDotsBarState createState() => _ProgressDotsBarState();
  Widget Line() {
    return Container(
      height: 3,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey,
      ),
    );
  }
}

class _ProgressDotsBarState extends State<ProgressDotsBar> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Row(
      ),
    );
  }
}
