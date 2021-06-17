import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/Feed/cubit/postimageupload_cubit.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/showCommentsSheet.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/showLikesSheet.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/showPostOptions.dart';

class UserPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlueGreyColor.withOpacity(0.4),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: kWhiteColor,
          ),
        ),
        title: Text('Posts',
            style: TextStyle(
              color: kBlueColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )),
      ),
      body: Container(),
    );
  }
}
