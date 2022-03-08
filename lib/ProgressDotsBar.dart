import 'package:flutter/material.dart';
import 'package:hello_world/tinderCards.dart';

class ProgressDot extends StatefulWidget {
  const ProgressDot({Key? key, required this.questionId}) : super(key: key);

  final int? questionId;

  @override
  _ProgressDotState createState() => _ProgressDotState();
}

class _ProgressDotState extends State<ProgressDot> {
  double _size = 20;
  Color _color = Colors.grey;

  void updateDotsState(currentId) {
    if (currentId > widget.questionId) {
      setState(() {
        _size = 20;
        _color = Colors.lightGreen;
      });
    } else if (currentId == widget.questionId) {
      setState(() {
        _size = 40;
        _color = Colors.lightGreen;
      });
    } else if (currentId < widget.questionId) {
      setState(() {
        _size = 20;
        _color = Colors.grey;
      });
    }
  }

  Widget dot() {
    return Container(
      width: _size,
      height: _size,
      decoration: const BoxDecoration(
        color: _color,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return dot();
  }
}

class ProgressDotsBar extends StatefulWidget {
  const ProgressDotsBar({Key? key}) : super(key: key);

  @override
  _ProgressDotsBarState createState() => _ProgressDotsBarState();
}

class _ProgressDotsBarState extends State<ProgressDotsBar> {
  Widget line() {
    return Container(
      height: 3,
      width: 10,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey,
      ),
    );
  }

  @override
  void initState() {
    getQuestionIDController().stream.listen((event) {
      setState(() {});
      print(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ProgressDot(questionId: 0),
          line(),
          ProgressDot(questionId: 1),
          line(),
          ProgressDot(questionId: 2),
          line(),
          ProgressDot(questionId: 3),
          line(),
        ],
      ),
    );
  }
}
