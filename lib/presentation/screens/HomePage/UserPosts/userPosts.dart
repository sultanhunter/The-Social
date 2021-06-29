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
  final String userUid;
  UserPosts({required this.userUid});
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
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userUid)
                .collection('posts')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final size = snapshot.data!.size;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Container(
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .doc(snapshot.data!.docs
                                  .elementAt(size - index - 1)
                                  .id)
                              .snapshots(),
                          builder: (context, snapshot1) {
                            if (snapshot1.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 8.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: StreamBuilder<DocumentSnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userUid)
                                              .snapshots(),
                                          builder: (context, snapshot2) {
                                            if (snapshot2.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else {
                                              return Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        kTransperant,
                                                    radius: 20,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      snapshot2.data!
                                                          .get('userimage'),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                      child: Container(
                                                        child: RichText(
                                                          text: TextSpan(
                                                              text: snapshot2
                                                                  .data!
                                                                  .get(
                                                                      'username'),
                                                              style: TextStyle(
                                                                color:
                                                                    kBlueColor,
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                  text:
                                                                      ', ${context.read<PostimageuploadCubit>().showTimeAgo(
                                                                            snapshot1.data!.get('time'),
                                                                          )}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: kLightColor
                                                                        .withOpacity(
                                                                            0.8),
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          }),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                        child: Text(
                                      snapshot1.data!.get('caption'),
                                      style: TextStyle(
                                          color: kGreenColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    )),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6 *
                                        0.71,
                                    width: MediaQuery.of(context).size.width,
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        context
                                            .read<PostimageuploadCubit>()
                                            .addLike(
                                                context,
                                                snapshot.data!.docs
                                                    .elementAt(size - index - 1)
                                                    .id);
                                      },
                                      child: FittedBox(
                                        child: Image.network(
                                          snapshot1.data!.get('imageurl'),
                                          scale: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                StreamBuilder<QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('posts')
                                                        .doc(snapshot.data!.docs
                                                            .elementAt(size -
                                                                index -
                                                                1)
                                                            .id)
                                                        .collection('likes')
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot3) {
                                                      if (snapshot3
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      } else {
                                                        bool isLiked = false;
                                                        for (int i = 0;
                                                            i <
                                                                snapshot3
                                                                    .data!.size;
                                                            i++) {
                                                          if (snapshot3
                                                                  .data!.docs
                                                                  .elementAt(i)
                                                                  .id ==
                                                              context
                                                                  .read<
                                                                      LoginCubit>()
                                                                  .state
                                                                  .uid) {
                                                            isLiked = true;
                                                            break;
                                                          }
                                                        }

                                                        return Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  if (isLiked) {
                                                                    context.read<PostimageuploadCubit>().deleteLike(
                                                                        context,
                                                                        snapshot
                                                                            .data!
                                                                            .docs
                                                                            .elementAt(size -
                                                                                index -
                                                                                1)
                                                                            .id);
                                                                  } else {
                                                                    context.read<PostimageuploadCubit>().addLike(
                                                                        context,
                                                                        snapshot
                                                                            .data!
                                                                            .docs
                                                                            .elementAt(size -
                                                                                index -
                                                                                1)
                                                                            .id);
                                                                  }
                                                                },
                                                                child: Icon(
                                                                  isLiked
                                                                      ? FontAwesomeIcons
                                                                          .solidHeart
                                                                      : FontAwesomeIcons
                                                                          .heart,
                                                                  color:
                                                                      kRedColor,
                                                                  size: 22,
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showLikesSheet(
                                                                      context,
                                                                      snapshot
                                                                          .data!
                                                                          .docs
                                                                          .elementAt(size -
                                                                              index -
                                                                              1)
                                                                          .id);
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                                  child: Text(
                                                                    snapshot3
                                                                        .data!
                                                                        .size
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                            kWhiteColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            18.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                    }),
                                                GestureDetector(
                                                  onTap: () {
                                                    showCommentsSheet(
                                                        context,
                                                        snapshot.data!.docs
                                                            .elementAt(size -
                                                                index -
                                                                1)
                                                            .id);
                                                  },
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .comment,
                                                          color: kBlueColor,
                                                          size: 22,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: StreamBuilder<
                                                              QuerySnapshot>(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'posts')
                                                                .doc(snapshot
                                                                    .data!.docs
                                                                    .elementAt(
                                                                        size -
                                                                            index -
                                                                            1)
                                                                    .id)
                                                                .collection(
                                                                    'comments')
                                                                .snapshots(),
                                                            builder: (context,
                                                                snapshot4) {
                                                              if (snapshot4
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                                return Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                              } else {
                                                                return Text(
                                                                    snapshot4
                                                                        .data!
                                                                        .size
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color:
                                                                            kWhiteColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            18.0));
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    child: Icon(
                                                      FontAwesomeIcons.shareAlt,
                                                      color: kYellowColor,
                                                      size: 22,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              showPostOptions(
                                                context,
                                                snapshot.data!.docs
                                                    .elementAt(size - index - 1)
                                                    .id,
                                                snapshot1.data!
                                                    .get('imagelocation'),
                                              );
                                            },
                                            icon: Icon(
                                              EvaIcons.moreVertical,
                                              color: kWhiteColor,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              );
                            }
                          },
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kBlueGreyColor,
                        ),
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  },
                  itemCount: size,
                );
              }
            }),
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kDarkColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
        ),
      ),
    );
  }
}
