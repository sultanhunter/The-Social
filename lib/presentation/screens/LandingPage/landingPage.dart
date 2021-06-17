import 'package:flutter/material.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/presentation/widgets/LandingPage/body_color.dart';
import 'package:the_social/presentation/widgets/LandingPage/body_image.dart';
import 'package:the_social/presentation/widgets/LandingPage/main_buttons.dart';
import 'package:the_social/presentation/widgets/LandingPage/privacy.dart';
import 'package:the_social/presentation/widgets/LandingPage/tagline.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          BodyColor(),
          BodyImage(context: context),
          TaglineText(),
          MainButton(),
          PrivacyText(),
        ],
      ),
    );
  }
}
