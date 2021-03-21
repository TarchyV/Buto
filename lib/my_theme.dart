import 'package:flutter/material.dart';

class MyTheme {
  Color background() {
    return Color(0xff02182B);
  }

  Color text() {
    return Color(0xffB5C2B7);
  }

  Color accent() {
    return Color(0xff0197F6);
  }

  Color warning() {
    return Color(0xffFFD639);
  }

  Color error() {
    return Color(0xffEF6461);
  }

  String fontFamily() {
    return 'Oxygen';
  }

  Shader blueGradient() {
    return LinearGradient(
      colors: <Color>[Color(0xff0197F6), Colors.lightBlue[200]],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  }
}
