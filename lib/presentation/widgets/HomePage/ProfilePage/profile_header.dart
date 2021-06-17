import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/presentation/widgets/HomePage/ProfilePage/checkFollowersSheet.dart';
import 'package:the_social/presentation/widgets/HomePage/ProfilePage/checkFollowingSheet.dart';

Widget profileHeader(
    BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.25,
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Container(
            height: 250,
            width: 160,
            child: Column(
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: kTransperant,
                      backgroundImage:
                          NetworkImage(userSnapshot.data!.get('userimage')),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      userSnapshot.data!.get('username'),
                      style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          EvaIcons.email,
                          color: kGreenColor,
                          size: 16,
                        ),
                        Expanded(
                          child: Text(
                            userSnapshot.data!.get('useremail'),
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kDarkColor,
                          borderRadius: BorderRadius.circular(15)),
                      height: 70,
                      width: 80,
                      child: GestureDetector(
                        onTap: () {
                          checkFollowersSheet(context);
                        },
                        child: Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userSnapshot.data!.id)
                                    .collection('followers')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return Text(
                                      snapshot.data!.size.toString(),
                                      style: TextStyle(
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28.0,
                                      ),
                                    );
                                  }
                                }),
                            Text(
                              'Followers',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kDarkColor,
                          borderRadius: BorderRadius.circular(15)),
                      height: 70,
                      width: 80,
                      child: GestureDetector(
                        onTap: () {
                          checkFollowingSheet(context);
                        },
                        child: Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userSnapshot.data!.id)
                                    .collection('following')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return Text(
                                      snapshot.data!.size.toString(),
                                      style: TextStyle(
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28.0,
                                      ),
                                    );
                                  }
                                }),
                            Text(
                              'Following',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: kDarkColor,
                      borderRadius: BorderRadius.circular(15)),
                  height: 70,
                  width: 80,
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              var userPostsNumber = 0;
                              for (int i = 0; i < snapshot.data!.size; i++) {
                                if (snapshot.data!.docs
                                        .elementAt(i)
                                        .get('useruid') ==
                                    userSnapshot.data!.get('useruid')) {
                                  userPostsNumber++;
                                }
                              }
                              return Text(
                                '$userPostsNumber',
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                ),
                              );
                            }
                          }),
                      Text(
                        'Posts',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
