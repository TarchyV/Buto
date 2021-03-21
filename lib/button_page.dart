import 'dart:math';

import 'package:flutter/material.dart';
import 'package:buto/my_theme.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:buto/my_functions.dart';
import 'my_widgets.dart';

class ButtonPage extends StatefulWidget {
  final String title;
  final String id;
  ButtonPage(this.title, this.id, {Key key}) : super(key: key);

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool clicked = false;
  bool finished = true;
  @override
  void initState() {
    clicked = false;

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // animationController.dispose() instead of your controller.dispose
  }

  void playSound() {
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/press.mp3"),
      showNotification: false,
    );
  }

  Widget button() {
    return Center(
      child: GestureDetector(
        onTapDown: (tdd) {
          playSound();
          setState(() {
            clicked = true;
            finished = false;
          });
        },
        onTapUp: (tdd) {
          setState(() {
            clicked = false;
          });
          Future.delayed(Duration(milliseconds: 600)).then((value) {
            setState(() {
              finished = true;
            });
          });
        },
        child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 200),
          width: !clicked
              ? MediaQuery.of(context).size.width / 2
              : (MediaQuery.of(context).size.width / 2) - 50,
          height: !clicked
              ? MediaQuery.of(context).size.height / 3
              : (MediaQuery.of(context).size.height / 3) - 50,
          decoration: new BoxDecoration(
            color: MyTheme().accent(),
            shape: BoxShape.circle,
            border: Border.all(
                width: finished ? 0 : 6, color: Colors.lightBlue[200]),
            gradient: LinearGradient(
                colors: [MyTheme().accent(), Colors.lightBlue[300]]),
            boxShadow: [
              !clicked
                  ? BoxShadow(
                      color: Colors.black,
                      spreadRadius: 8,
                      blurRadius: 10,
                      offset: Offset(0, 6), // changes position of shadow
                    )
                  : BoxShadow(
                      color: Colors.black,
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget particle() {
    double size = Functions().randomDouble(1, 3);
    return AnimatedPositioned(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      top: finished
          ? MediaQuery.of(context).size.height / 2
          : Functions()
              .randomDouble(0, MediaQuery.of(context).size.height.ceil()),
      left: finished
          ? MediaQuery.of(context).size.height / 4
          : Functions()
              .randomDouble(0, MediaQuery.of(context).size.width.ceil()),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: size,
        height: size,
        decoration: new BoxDecoration(
            color: Colors.lightBlue[200], shape: BoxShape.circle),
      ),
    );
  }

  Widget plusOne() {
    return Center(
      child: new AnimatedPadding(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInCirc,
          padding: EdgeInsets.only(
            bottom: finished ? 0 : MediaQuery.of(context).size.height / 2,
          ),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: finished ? 0 : 1,
            child: Container(
                height: 40,
                width: 40,
                decoration: new BoxDecoration(
                    color: MyTheme().warning(),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  '+1',
                  style: TextStyle(
                      fontFamily: MyTheme().fontFamily(),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ))),
          )),
    );
  }

  Widget bottomBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: new BoxDecoration(
          border: Border(top: BorderSide(width: 3, color: MyTheme().text()))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: My_Widgets().title('Total Taps: ', 16),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.delete,
              size: 32,
              color: MyTheme().text(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> particles = new List.generate(50, (index) => particle());
    return Scaffold(
        backgroundColor: MyTheme().background(),
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Stack(
                  children: particles,
                ),
                plusOne(),
                button(),
                Positioned(
                  top: 22,
                  left: 80,
                  child: My_Widgets().title("Swear Jar", 32),
                ),
                Positioned(
                    top: 20, right: 15, child: My_Widgets().chartsButton(50)),
                Positioned(
                    top: 20, left: 15, child: My_Widgets().backButton(50)),
                Positioned(bottom: 5, child: bottomBar())
              ],
            )));
  }
}
