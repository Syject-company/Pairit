import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:pairit/screens/loading_screen.dart';
import 'package:pairit/states.dart';

class OnboardingScreen extends StatefulWidget {
  static final style = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int page = 0;
  LiquidController liquidController;
  UpdateType updateType;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var pages = [
      Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Image.asset('assets/images/first_screen.png'),
            ),
            Positioned(
              bottom: 80,
              child: Container(
                padding: EdgeInsets.only(
                  left: 36,
                ),
                child: Text(
                  "Design your own business card with a \nsimple constructor",
                  style: OnboardingScreen.style,
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              right: 24,
              child: Icon(Icons.arrow_forward, size: 30,),
            ),
          ],
        ),
      ),
      Container(
        color: accentColor,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Image.asset('assets/images/second_screen.png'),
            ),
            Positioned(
              bottom: 104,
              child: Container(
                padding: EdgeInsets.only(
                  left: 36,
                ),
                child: Text(
                  "Upload your image and logo",
                  style: OnboardingScreen.style,
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              right: 24,
              child: Icon(Icons.arrow_forward, size: 30,),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Image.asset('assets/images/third_screen.png'),
            ),
            Positioned(
              bottom: 104,
              child: Container(
                padding: EdgeInsets.only(
                  left: 36,
                ),
                child: Text(
                  "Save your new clients card and go",
                  style: OnboardingScreen.style,
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              right: 24,
              child: IconButton(
                icon: Icon(Icons.check),
                iconSize: 30,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SplashScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    ];

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            LiquidSwipe(
              pages: pages,
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              enableLoop: false,
              ignoreUserGestureWhileAnimating: true,
            ),
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}