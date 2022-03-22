import 'package:flutter/material.dart';
import 'package:hello_world/tinderCards.dart';
import 'package:hello_world/DotTestPage.dart';

class ProgressDot extends StatefulWidget {
  const ProgressDot({Key? key, required this.questionId}) : super(key: key);

  final int? questionId;

  @override
  _ProgressDotState createState() => _ProgressDotState();
}

class _ProgressDotState extends State<ProgressDot>
    with SingleTickerProviderStateMixin {
  double _size = 20;

  late AnimationController _controller;
  late Animation _color;

  void updateDotsState(currentId) {
    if (currentId > widget.questionId) {
      setState(() {
        _size = 20;
        // _color = Colors.lightGreen;
      });
    } else if (currentId == widget.questionId) {
      setState(() {
        _size = 40;
        _animationChange();
        // _color = Colors.lightGreen;
      });
    } else if (currentId < widget.questionId) {
      setState(() {
        _size = 20;
        // _color = Colors.grey;
      });
    }
  }

  void _animationChange() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  // Widget dot() {
  //   return Container(
  //     width: _size,
  //     height: _size,
  //     decoration: const BoxDecoration(
  //       color: ,
  //       shape: BoxShape.circle,
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _controller.addListener(() {
      setState(() {});
      print(_controller.value);
    });

    _color = ColorTween(
      begin: Colors.grey,
      end: Colors.lightGreen,
    ).animate(_controller);

    getTestController().stream.listen((event) {
      print(event);
      //通知が来た時に更新の関数を実行
      updateDotsState(event);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, child) => child!,
        child: Container(
          // color: _color.value,
          width: _size,
          height: _size,
          decoration: const BoxDecoration(
            // color: _color.value,
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
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
