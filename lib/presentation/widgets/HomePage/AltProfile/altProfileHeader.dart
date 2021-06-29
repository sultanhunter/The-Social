import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/Feed/cubit/postimageupload_cubit.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/presentation/widgets/HomePage/AltProfile/altProfileCheckFollowersSheet.dart';
import 'package:the_social/presentation/widgets/HomePage/AltProfile/altProfileShowFollowingSheet.dart';

Widget altProfileHeader(
    BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.35,
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: [
        Row(
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
                              altProfileFollowersSheet(context, userSnapshot);
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
                              altProfileFollowingSheet(context, userSnapshot);
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
                                  for (int i = 0;
                                      i < snapshot.data!.size;
                                      i++) {
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
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userSnapshot.data!.get('useruid'))
                    .collection('followers')
                    .snapshots(),
                builder: (context, snapshot) {
                  bool isFollowing = false;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    for (int i = 0; i < snapshot.data!.size; i++) {
                      if (snapshot.data!.docs.elementAt(i).get('followeruid') ==
                          context.read<LoginCubit>().state.uid) {
                        isFollowing = true;
                        break;
                      }
                    }
                    return MaterialButton(
                      color: isFollowing ? kWhiteColor : kBlueColor,
                      onPressed: () {
                        if (!isFollowing) {
                          context.read<PostimageuploadCubit>().followUser(
                            context.read<LoginCubit>().state.uid,
                            userSnapshot.data!.get('useruid'),
                            {
                              'followeruid':
                                  context.read<LoginCubit>().state.uid,
                              'followerusername':
                                  context.read<LoginCubit>().state.userName,
                              'time': Timestamp.now(),
                            },
                          ).whenComplete(() {
                            final snackBar = SnackBar(
                              content: Text(
                                  'You followed ${userSnapshot.data!.get('username')} succesfully'),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: kBlueColor,
                                title: Text(
                                  'Unfollow ${userSnapshot.data!.get('username')}?',
                                  style: TextStyle(
                                      color: kWhiteColor, fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                          color: kWhiteColor,
                                          decoration: TextDecoration.underline,
                                          fontSize: 16),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<PostimageuploadCubit>()
                                          .unFollowUser(
                                              context
                                                  .read<LoginCubit>()
                                                  .state
                                                  .uid,
                                              userSnapshot.data!.id)
                                          .whenComplete(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: kRedColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: isFollowing
                          ? Text(
                              'Following',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            )
                          : Text(
                              'Follow',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                    );
                  }
                },
              ),
              MaterialButton(
                color: kBlueColor,
                onPressed: () {},
                child: Text(
                  'Message',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
