import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/presentation/screens/HomePage/home.dart';
import 'package:the_social/presentation/widgets/HomePage/AltProfile/altProfileFooter.dart';
import 'package:the_social/presentation/widgets/HomePage/AltProfile/altProfileHeader.dart';
import 'package:the_social/presentation/widgets/HomePage/AltProfile/altProfileMiddle.dart';
import 'package:the_social/presentation/widgets/HomePage/ProfilePage/divider.dart';

class AltProfile extends StatelessWidget {
  final String useruid;
  AltProfile({required this.useruid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlueGreyColor.withOpacity(0.4),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              ModalRoute.withName('/home'),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: kWhiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                ModalRoute.withName('/home'),
              );
            },
            icon: Icon(
              EvaIcons.moreVertical,
              color: kWhiteColor,
            ),
          ),
        ],
        title: RichText(
          text: TextSpan(
              text: 'The',
              style: TextStyle(
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' Social',
                  style: TextStyle(
                    color: kBlueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                )
              ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(useruid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    altProfileHeader(context, snapshot),
                    divider(),
                    altProfileMiddle(context, snapshot),
                    altProfileFooter(context, snapshot),
                  ],
                );
              }
            },
          ),
          decoration: BoxDecoration(
            color: kBlueGreyColor.withOpacity(0.6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
