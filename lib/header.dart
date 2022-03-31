import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  String title = '';
  Header(String title){
    this.title = title;
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewGradientAppBar(
            title: Text(title,
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            gradient: LinearGradient(
              colors: [
                Color(0xff7BD4F1).withOpacity(0.65),
                Color(0xff220f60).withOpacity(1.0)
              ],
            )));
  }
}
