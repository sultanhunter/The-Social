import 'package:flutter/material.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/feed_appBar.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/feed_body.dart';

class Feed extends StatelessWidget {
  final PageController pageController;
  Feed({required this.pageController});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: feedAppBar(context),
      body: feedBody(context),
    );
  }
}
