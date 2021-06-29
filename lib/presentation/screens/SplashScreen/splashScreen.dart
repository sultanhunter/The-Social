import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/constants/constantStyles.dart';
import 'package:the_social/presentation/screens/LandingPage/landingPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 1),
      () => Navigator.pushReplacement(
        context,
        PageTransition(
          child: LandingPage(),
          type: PageTransitionType.bottomToTop,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkColor,
      body: Center(
        child: RichText(
          text: TextSpan(
            text: 'the',
            style: kTextSpanStyle,
            children: <TextSpan>[
              TextSpan(
                text: 'Social',
                style: kTextSpanStyle.copyWith(
                  color: kBlueColor,
                  fontSize: 34,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
