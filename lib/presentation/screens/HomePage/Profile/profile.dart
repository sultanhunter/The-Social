import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/constants/constantStyles.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/presentation/widgets/HomePage/ProfilePage/divider.dart';
import 'package:the_social/presentation/widgets/HomePage/ProfilePage/footer_profile.dart';
import 'package:the_social/presentation/widgets/HomePage/ProfilePage/log_out_dialog.dart';
import 'package:the_social/presentation/widgets/HomePage/ProfilePage/middle_profile.dart';
import 'package:the_social/presentation/widgets/HomePage/ProfilePage/profile_header.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBlueGreyColor.withOpacity(0.4),
        leading: IconButton(
          icon: Icon(
            EvaIcons.settings2Outline,
            color: kLightBlueColor,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {
              logOutDialog(context);
            },
            icon: Icon(EvaIcons.logOutOutline),
            color: kGreenColor,
          ),
        ],
        title: RichText(
          text: TextSpan(
              text: 'My ',
              style: kProfileAppBarText,
              children: <TextSpan>[
                TextSpan(
                    text: 'Profile',
                    style: kProfileAppBarText.copyWith(color: kBlueColor))
              ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(context.read<LoginCubit>().state.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        profileHeader(context, snapshot),
                        divider(),
                        middleProfile(context, snapshot),
                        footerProfile(context),
                      ],
                    );
                  }
                }),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: kBlueGreyColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
    );
  }
}
