import 'package:flutter/material.dart';
import 'package:the_social/constants/Constantcolors.dart';

class BodyColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.5, 0.9],
          colors: [
            kDarkColor,
            kBlueGreyColor,
          ],
        ),
      ),
    );
  }
}
