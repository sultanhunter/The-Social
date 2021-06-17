import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/constants/constantStyles.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/selectPostImageType.dart';

feedAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kBlueGreyColor.withOpacity(0.4),
    centerTitle: true,
    actions: [
      IconButton(
          icon: Icon(
            Icons.camera_enhance_rounded,
            color: kGreenColor,
          ),
          onPressed: () {
            selectPostImageType(context);
          })
    ],
    title: RichText(
      text: TextSpan(
          text: 'Social ',
          style: kProfileAppBarText,
          children: <TextSpan>[
            TextSpan(
                text: 'Feed',
                style: kProfileAppBarText.copyWith(color: kBlueColor))
          ]),
    ),
  );
}
