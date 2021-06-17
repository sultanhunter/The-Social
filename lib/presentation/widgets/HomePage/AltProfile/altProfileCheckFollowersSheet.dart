import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/Feed/cubit/postimageupload_cubit.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/logic/cubits/pageView/cubit/pageview_cubit.dart';
import 'package:the_social/presentation/screens/HomePage/AltProfile/altProfile.dart';

altProfileFollowersSheet(
    BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: kBlueGreyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(
                  thickness: 4.0,
                  color: kWhiteColor,
                ),
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: kWhiteColor),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    'Following',
                    style: TextStyle(
                        color: kBlueColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5 * 0.8,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(userSnapshot.data!.id)
                        .collection('followers')
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final followeruid = snapshot.data!.docs
                                .elementAt(index)
                                .get('followeruid');
                            return StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(followeruid)
                                    .snapshots(),
                                builder: (context, snapshot1) {
                                  if (snapshot1.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return ListTile(
                                      leading: GestureDetector(
                                        onTap: () {
                                          if (followeruid ==
                                              context
                                                  .read<LoginCubit>()
                                                  .state
                                                  .uid) {
                                            context
                                                .read<PageviewCubit>()
                                                .changePage(2);
                                            context
                                                .read<PageviewCubit>()
                                                .state
                                                .pageController
                                                .jumpToPage(2);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (contex) {
                                                  return AltProfile(
                                                      useruid: snapshot
                                                          .data!.docs
                                                          .elementAt(index)
                                                          .get('followeruid'));
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            snapshot1.data!.get('userimage'),
                                          ),
                                        ),
                                      ),
                                      title: GestureDetector(
                                        onTap: () {
                                          if (followeruid ==
                                              context
                                                  .read<LoginCubit>()
                                                  .state
                                                  .uid) {
                                            context
                                                .read<PageviewCubit>()
                                                .changePage(2);
                                            context
                                                .read<PageviewCubit>()
                                                .state
                                                .pageController
                                                .jumpToPage(2);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (contex) {
                                                  return AltProfile(
                                                      useruid: snapshot
                                                          .data!.docs
                                                          .elementAt(index)
                                                          .get('followinguid'));
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          snapshot1.data!.get('username'),
                                          style: TextStyle(
                                              color: kBlueColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      subtitle: Text(
                                        snapshot1.data!.get('useremail'),
                                        style: TextStyle(
                                            color: kWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0),
                                      ),
                                      trailing: followeruid ==
                                              context
                                                  .read<LoginCubit>()
                                                  .state
                                                  .uid
                                          ? Container(
                                              height: 0,
                                              width: 0,
                                            )
                                          : Container(
                                              height: 30,
                                              width: 110,
                                              child:
                                                  StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(context
                                                        .read<LoginCubit>()
                                                        .state
                                                        .uid)
                                                    .collection('following')
                                                    .snapshots(),
                                                builder: (context, snapshot2) {
                                                  bool isFollowing = false;
                                                  if (snapshot2
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  } else {
                                                    for (int i = 0;
                                                        i <
                                                            snapshot2
                                                                .data!.size;
                                                        i++) {
                                                      if (snapshot2.data!.docs
                                                              .elementAt(i)
                                                              .get(
                                                                  'followinguid') ==
                                                          snapshot1.data!
                                                              .get('useruid')) {
                                                        isFollowing = true;
                                                        break;
                                                      }
                                                    }
                                                    return MaterialButton(
                                                      color: isFollowing
                                                          ? kWhiteColor
                                                          : kBlueColor,
                                                      onPressed: () {
                                                        if (!isFollowing) {
                                                          context
                                                              .read<
                                                                  PostimageuploadCubit>()
                                                              .followUser(
                                                            context
                                                                .read<
                                                                    LoginCubit>()
                                                                .state
                                                                .uid,
                                                            snapshot1.data!
                                                                .get('useruid'),
                                                            {
                                                              'followeruid': context
                                                                  .read<
                                                                      LoginCubit>()
                                                                  .state
                                                                  .uid,
                                                              'followerusername':
                                                                  context
                                                                      .read<
                                                                          LoginCubit>()
                                                                      .state
                                                                      .userName,
                                                              'time': Timestamp
                                                                  .now(),
                                                            },
                                                          ).whenComplete(() {
                                                            Navigator.pop(
                                                                context);
                                                            final snackBar =
                                                                SnackBar(
                                                              content: Text(
                                                                  'You followed ${snapshot1.data!.get('username')} succesfully'),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                            );
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                          });
                                                        } else {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                backgroundColor:
                                                                    kBlueColor,
                                                                title: Text(
                                                                  'Unfollow ${snapshot1.data!.get('username')}?',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kWhiteColor,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                      'No',
                                                                      style: TextStyle(
                                                                          color:
                                                                              kWhiteColor,
                                                                          decoration: TextDecoration
                                                                              .underline,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      context
                                                                          .read<
                                                                              PostimageuploadCubit>()
                                                                          .unFollowUser(
                                                                              context.read<LoginCubit>().state.uid,
                                                                              snapshot1.data!.get('useruid'))
                                                                          .whenComplete(() {
                                                                        Navigator.pop(
                                                                            context);
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          color:
                                                                              kRedColor,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16.0,
                                                              ),
                                                            )
                                                          : Text(
                                                              'Follow',
                                                              style: TextStyle(
                                                                color:
                                                                    kWhiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                    );
                                  }
                                });
                          },
                          itemCount: snapshot.data!.size,
                        );
                      }
                    }),
              ),
            ],
          ),
        );
      });
}
