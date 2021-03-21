import 'package:flutter/material.dart';
import 'my_theme.dart';

class My_Widgets {
  Widget title(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: MyTheme().fontFamily(),
          color: MyTheme().text(),
          fontSize: fontSize),
    );
  }

  Widget chartsButton(double size) {
    return GestureDetector(
      child: Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(borderRadius: BorderRadius.circular(18)),
        child: Icon(
          Icons.show_chart_outlined,
          size: size - 12,
          color: MyTheme().text(),
        ),
      ),
    );
  }

  Widget backButton(double size) {
    return GestureDetector(
      child: Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(borderRadius: BorderRadius.circular(18)),
        child: Icon(
          Icons.arrow_back_ios_outlined,
          size: size - 12,
          color: MyTheme().text(),
        ),
      ),
    );
  }
}
