import 'dart:math';

import 'package:buto/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:buto/my_theme.dart';
import 'package:buto/button_page.dart';
import 'package:buto/my_functions.dart';
import 'package:animated_list_view_scroll/animated_list_view_scroll.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boto',
      theme: ThemeData(
        primaryColor: MyTheme().text(),
        fontFamily: MyTheme().fontFamily(),
        backgroundColor: MyTheme().background(),
        accentColor: MyTheme().accent(),
        dialogBackgroundColor: MyTheme().warning(),
        errorColor: MyTheme().error(),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fun = Functions();
  var theme = MyTheme();

  double width = 1000;
  double height = 2000;
  int runCount = 0;
  @override
  void initState() {
    stateTimer();
    super.initState();
  }

  void stateTimer() {
    if (runCount == 0) {
      Future.delayed(Duration(milliseconds: 600)).then((value) {
        setState(() {
          runCount = 1;
        });
      });
    }
  }

  Widget backgroundParticle() {
    double particleX =
        fun.randomDouble(5, MediaQuery.of(context).size.width.ceil());
    double particleY =
        fun.randomDouble(5, MediaQuery.of(context).size.height.ceil());
    double size = fun.randomDouble(1, 5);
    return AnimatedPositioned(
      duration: Duration(seconds: 30),
      curve: Curves.easeInOut,
      onEnd: () {
        print('ended?');
        setState(() {
          particleX = new Functions()
              .randomDouble(5, MediaQuery.of(context).size.width.ceil());
          particleY = new Functions()
              .randomDouble(5, MediaQuery.of(context).size.height.ceil());
        });
      },
      top: particleY,
      left: particleX,
      child: AnimatedContainer(
        duration: Duration(seconds: 30),
        width: size,
        height: size,
        decoration: new BoxDecoration(
            color: theme.accent(),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 3,
                  color: Colors.white38,
                  offset: Offset(0, 0))
            ]),
      ),
    );
  }

  Widget listItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
          width: double.maxFinite,
          height: 80,
          decoration: new BoxDecoration(
              color: Colors.black38,
              border: Border.all(
                color: theme.accent(),
                width: 2,
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Something',
                      style: TextStyle(color: theme.text(), fontSize: 22),
                    ),
                  ),
                  My_Widgets().chartsButton(50)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'Last-Updated: 2 days ago',
                      style: TextStyle(color: theme.text(), fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      '👇210',
                      style: TextStyle(color: theme.text(), fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      'Created: 12 days ago',
                      style: TextStyle(color: theme.text(), fontSize: 12),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> particles =
        new List.generate(50, (index) => backgroundParticle());
    List<Widget> listItems = new List.generate(10, (index) => listItem());
    return Scaffold(
      backgroundColor: MyTheme().background(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: particles,
            ),
            Container(
              decoration: new BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: theme.accent(), width: 2))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'BUTO',
                      style: TextStyle(
                        fontFamily: theme.fontFamily(),
                        fontSize: 48,
                        letterSpacing: 8,
                        foreground: Paint()..shader = theme.blueGradient(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 18, 18),
                    child: IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          Icons.settings,
                          color: theme.accent(),
                          size: 32,
                        ),
                        onPressed: () {
                          //Open Settings Page
                        }),
                  )
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 12,
              left: -2,
              child: Container(
                  height: MediaQuery.of(context).size.height / 1.1,
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: new BoxDecoration(),
                  child: AnimatedListViewScroll(
                    itemCount: 10, //REQUIRED
                    itemHeight:
                        100, //REQUIRED (Total height of a single item must contains optional padding or margin)
                    animationOnReverse: true,
                    animationDuration: Duration(milliseconds: 200),
                    itemBuilder: (context, index) {
                      return AnimatedListViewItem(
                        key: GlobalKey(), //REQUIRED
                        index: index, //REQUIRED
                        animationBuilder: (context, index, controller) {
                          Animation<Offset> animation = Tween<Offset>(
                                  begin: Offset(1.0, 0.0), end: Offset.zero)
                              .animate(controller);
                          return SlideTransition(
                            position: animation,
                            child: listItems[index],
                          );
                        },
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
