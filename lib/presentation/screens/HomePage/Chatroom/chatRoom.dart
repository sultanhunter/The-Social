import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/constants/constantStyles.dart';
import 'package:the_social/presentation/widgets/HomePage/Chat/createChatSheet.dart';

class ChatRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: kBlueColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateChatSheet(),
            ),
          );
        },
        child: Icon(
          FontAwesomeIcons.plus,
          color: kWhiteColor,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(EvaIcons.moreVertical),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.plus),
        ),
        backgroundColor: kBlueGreyColor.withOpacity(0.4),
        title: RichText(
          text: TextSpan(
              text: 'Chat ',
              style: kProfileAppBarText,
              children: <TextSpan>[
                TextSpan(
                  text: 'Box',
                  style: kProfileAppBarText.copyWith(color: kBlueColor),
                )
              ]),
        ),
      ),
    );
  }
}
