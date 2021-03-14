import 'dart:math';

import 'package:flutter/material.dart';
import 'package:boto/my_theme.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

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
  double randomDouble(int min,int max){
    Random rnd;
    rnd = new Random();
    return min + rnd.nextInt(max - min).toDouble();
  }

  void playSound(){
    AssetsAudioPlayer.newPlayer().open(
    Audio("assets/press.mp3"),
    showNotification: false,
);
  }


Widget button(){
    return Center(
      child: GestureDetector(
        onTapDown: (tdd){
        playSound();
          setState(() {
            clicked = true;
            finished = false;
          });
        },
        onTapUp: (tdd){
        setState(() {
          clicked = false;
        });
        Future.delayed(Duration(milliseconds:600)).then((value) {
          setState(() {
           finished = true;
          });
        });
        },
        child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 100),
          width: !clicked?MediaQuery.of(context).size.width/2:(MediaQuery.of(context).size.width/2)-50,
          height: !clicked?MediaQuery.of(context).size.height/3:(MediaQuery.of(context).size.height/3)-50,
          decoration: new BoxDecoration(
            color: MyTheme().accent(),
            shape: BoxShape.circle,
             boxShadow: [
               !clicked? BoxShadow(
                  color: Colors.black,
                  spreadRadius: 8,
                  blurRadius: 10,
                  offset: Offset(0, 6), // changes position of shadow
                ): BoxShadow(
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

Widget particle(){
  double size = randomDouble(1, 3);
  return AnimatedPositioned(
    duration: Duration(milliseconds:600),
      curve: Curves.easeInOut,
      top: finished? MediaQuery.of(context).size.height/2: randomDouble(0, MediaQuery.of(context).size.height.ceil()),
      left: finished? MediaQuery.of(context).size.height/4: randomDouble(0, MediaQuery.of(context).size.width.ceil()),
      child: AnimatedContainer(
        duration: Duration(milliseconds:300),
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Colors.lightBlue[200],
          shape: BoxShape.circle
        )
        ,
    ),
  );
}

Widget plusOne(){
  return Center(
    child: new AnimatedPadding(
      duration: Duration(milliseconds:400),
      curve: Curves.easeInCirc,
      padding: EdgeInsets.only(bottom:finished? 0: MediaQuery.of(context).size.height/2,),
      child: AnimatedOpacity(
            duration: Duration(milliseconds:400),
          opacity: finished? 0:1,
          child: Container(
          height: 40,
          width: 40,
          decoration: new BoxDecoration(
            color: MyTheme().warning(),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Center(child: Text('+1',
          style: TextStyle(
            fontFamily: MyTheme().fontFamily(),
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
          ))
        ),
      )
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
        child: 
            Stack(
              children: [
                  
                Stack(children: particles,),
                plusOne(),
                 button(),
                
                
              ],
            )    
      )
    );
  }
}