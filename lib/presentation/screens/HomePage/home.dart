import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/pageView/cubit/pageview_cubit.dart';
import 'package:the_social/presentation/screens/HomePage/Chatroom/chatRoom.dart';
import 'package:the_social/presentation/screens/HomePage/Feed/feed.dart';
import 'package:the_social/presentation/screens/HomePage/Profile/profile.dart';
import 'package:the_social/presentation/widgets/HomePage/bottom_nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController homePageController = PageController();

  @override
  Widget build(BuildContext context) {
    context.read<PageviewCubit>().getPageController(homePageController);
    return Scaffold(
      backgroundColor: kDarkColor,
      body: PageView(
        controller: homePageController,
        children: [
          Feed(
            pageController: homePageController,
          ),
          ChatRoom(),
          Profile(),
        ],
        // physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          context.read<PageviewCubit>().changePage(page);
        },
      ),
      bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * 0.065,
          child: bottomNavBar(homePageController)),
    );
  }
}
