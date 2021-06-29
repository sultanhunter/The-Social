import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/Feed/cubit/postimageupload_cubit.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/logic/cubits/pageView/cubit/pageview_cubit.dart';
import 'package:the_social/presentation/screens/HomePage/AltProfile/altProfile.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/showCommentsSheet.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/showLikesSheet.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/showPostOptions.dart';

Widget feedBody(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 8.0),
    child: Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: SizedBox(
                height: 500,
                width: 400,
                child: Lottie.asset('assets/animations/loading.json'),
              ));
            } else {
              final size = snapshot.data!.size;
              return Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kBlueGreyColor,
                        ),
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (snapshot.data!.docs
                                          .elementAt(size - index - 1)
                                          .get('useruid') ==
                                      context.read<LoginCubit>().state.uid) {
                                    context.read<PageviewCubit>().changePage(2);
                                    context
                                        .read<PageviewCubit>()
                                        .state
                                        .pageController
                                        .jumpToPage(2);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AltProfile(
                                          useruid: snapshot.data!.docs
                                              .elementAt(size - index - 1)
                                              .get('useruid'),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: kTransperant,
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                        snapshot.data!.docs
                                            .elementAt(size - index - 1)
                                            .get('userimage'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Container(
                                          child: RichText(
                                            text: TextSpan(
                                                text: snapshot.data!.docs
                                                    .elementAt(size - index - 1)
                                                    .get('username'),
                                                style: TextStyle(
                                                  color: kBlueColor,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        ', ${context.read<PostimageuploadCubit>().showTimeAgo(
                                                              snapshot
                                                                  .data!.docs
                                                                  .elementAt(
                                                                      size -
                                                                          index -
                                                                          1)
                                                                  .get('time'),
                                                            )}',
                                                    style: TextStyle(
                                                      color: kLightColor
                                                          .withOpacity(0.8),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  child: Text(
                                snapshot.data!.docs
                                    .elementAt(size - index - 1)
                                    .get('caption'),
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
                                  context.read<PostimageuploadCubit>().addLike(
                                      context,
                                      snapshot.data!.docs
                                          .elementAt(size - index - 1)
                                          .id);
                                },
                                child: FittedBox(
                                  child: Image.network(
                                    snapshot.data!.docs
                                        .elementAt(size - index - 1)
                                        .get('imageurl'),
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
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('posts')
                                                  .doc(snapshot.data!.docs
                                                      .elementAt(
                                                          size - index - 1)
                                                      .id)
                                                  .collection('likes')
                                                  .snapshots(),
                                              builder: (context, snapshot3) {
                                                if (snapshot3.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else {
                                                  bool isLiked = false;
                                                  for (int i = 0;
                                                      i < snapshot3.data!.size;
                                                      i++) {
                                                    if (snapshot3.data!.docs
                                                            .elementAt(i)
                                                            .id ==
                                                        context
                                                            .read<LoginCubit>()
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
                                                              context
                                                                  .read<
                                                                      PostimageuploadCubit>()
                                                                  .deleteLike(
                                                                      context,
                                                                      snapshot
                                                                          .data!
                                                                          .docs
                                                                          .elementAt(size -
                                                                              index -
                                                                              1)
                                                                          .id);
                                                            } else {
                                                              context
                                                                  .read<
                                                                      PostimageuploadCubit>()
                                                                  .addLike(
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
                                                            color: kRedColor,
                                                            size: 22,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            showLikesSheet(
                                                                context,
                                                                snapshot
                                                                    .data!.docs
                                                                    .elementAt(
                                                                        size -
                                                                            index -
                                                                            1)
                                                                    .id);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              snapshot3
                                                                  .data!.size
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
                                                      .elementAt(
                                                          size - index - 1)
                                                      .id);
                                            },
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.comment,
                                                    color: kBlueColor,
                                                    size: 22,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: StreamBuilder<
                                                        QuerySnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('posts')
                                                          .doc(snapshot
                                                              .data!.docs
                                                              .elementAt(size -
                                                                  index -
                                                                  1)
                                                              .id)
                                                          .collection(
                                                              'comments')
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot2) {
                                                        if (snapshot2
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        } else {
                                                          return Text(
                                                              snapshot2
                                                                  .data!.size
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
                                  snapshot.data!.docs
                                              .elementAt(size - index - 1)
                                              .get('useruid') ==
                                          context.read<LoginCubit>().state.uid
                                      ? IconButton(
                                          onPressed: () {
                                            showPostOptions(
                                              context,
                                              snapshot.data!.docs
                                                  .elementAt(size - index - 1)
                                                  .id,
                                              snapshot.data!.docs
                                                  .elementAt(size - index - 1)
                                                  .get('imagelocation'),
                                            );
                                          },
                                          icon: Icon(
                                            EvaIcons.moreVertical,
                                            color: kWhiteColor,
                                          ))
                                      : Container(
                                          width: 0.0,
                                          height: 0.0,
                                        ),
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: size,
                ),
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
          )),
    ),
  );
}
