import 'package:flutter/material.dart';

void main() => runApp(const circleProgressIndicator());

class circleProgressIndicator extends StatelessWidget {
  const circleProgressIndicator({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: circleProgressIndicatorStatefulWidget(),
    );
  }
}

class circleProgressIndicatorStatefulWidget extends StatefulWidget {
  const circleProgressIndicatorStatefulWidget({Key? key}) : super(key: key);

  @override
  State<circleProgressIndicatorStatefulWidget> createState() =>
      _circleProgressIndicatorStatefulWidget();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _circleProgressIndicatorStatefulWidget
    extends State<circleProgressIndicatorStatefulWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Linear progress indicator with a fixed color',
              style: Theme.of(context).textTheme.headline6,
            ),
            CircularProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Linear progress indicator',
            ),
          ],
        ),
      ),
    );
  }
}
