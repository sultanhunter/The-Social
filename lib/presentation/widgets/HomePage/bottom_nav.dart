import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/logic/cubits/pageView/cubit/pageview_cubit.dart';

Widget bottomNavBar(PageController pageController) {
  return Builder(builder: (context) {
    final loginState = context.watch<LoginCubit>().state;
    final pageViewState = context.watch<PageviewCubit>().state;
    return CustomNavigationBar(
      currentIndex: pageViewState.pageIndex,
      bubbleCurve: Curves.bounceIn,
      scaleCurve: Curves.linear,
      selectedColor: kBlueColor,
      unSelectedColor: kWhiteColor,
      strokeColor: kBlueColor,
      scaleFactor: 0.5,
      iconSize: 30.0,
      elevation: 10,
      items: [
        CustomNavigationBarItem(
          icon: Icon(EvaIcons.home),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.message_rounded),
        ),
        CustomNavigationBarItem(
            icon: CircleAvatar(
          radius: 35,
          backgroundColor: kBlueGreyColor,
          backgroundImage: NetworkImage(loginState.userImage),
        ))
      ],
      onTap: (val) {
        context.read<PageviewCubit>().changePage(val);
        pageController.jumpToPage(val);
      },
      backgroundColor: Color(0xFF040307),
    );
  });
}
