import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/Feed/cubit/postimageupload_cubit.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/logic/cubits/pageView/cubit/pageview_cubit.dart';
import 'package:the_social/presentation/screens/HomePage/AltProfile/altProfile.dart';

showCommentsSheet(BuildContext context, String postId) {
  final TextEditingController _commentController = TextEditingController();
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
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
                    'Comments',
                    style: TextStyle(
                        color: kBlueColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.1),
                    height: MediaQuery.of(context).size.height * 0.7 -
                        MediaQuery.of(context).viewInsets.bottom,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(postId)
                          .collection('comments')
                          .orderBy('time')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              'No Comments',
                              style: TextStyle(color: kWhiteColor),
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  reverse: true,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (snapshot.data!.docs
                                                        .elementAt(index)
                                                        .get('useruid') ==
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
                                                } else {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (contex) {
                                                        return AltProfile(
                                                            useruid: snapshot
                                                                .data!.docs
                                                                .elementAt(
                                                                    index)
                                                                .get(
                                                                    'useruid'));
                                                      },
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: GestureDetector(
                                                      child: CircleAvatar(
                                                        radius: 15.0,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          snapshot.data!.docs
                                                              .elementAt(index)
                                                              .get('userimage'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      snapshot.data!.docs
                                                          .elementAt(index)
                                                          .get('username'),
                                                      style: TextStyle(
                                                          color: kWhiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      FontAwesomeIcons.heart,
                                                      color: kRedColor,
                                                      size: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    '0',
                                                    style: TextStyle(
                                                      color: kWhiteColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      FontAwesomeIcons.reply,
                                                      color: kYellowColor,
                                                      size: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: kBlueColor,
                                                  size: 12,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75,
                                                child: Text(
                                                  snapshot.data!.docs
                                                      .elementAt(index)
                                                      .get('comment'),
                                                  style: TextStyle(
                                                      color: kWhiteColor,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  FontAwesomeIcons.trash,
                                                  color: kGreyColor,
                                                  size: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: kDarkColor.withOpacity(0.2),
                                        )
                                      ],
                                    );
                                  },
                                  itemCount: snapshot.data!.size,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.61 -
                        MediaQuery.of(context).viewInsets.bottom,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width * 0.83,
                            height: 50.0,
                            child: TextField(
                              controller: _commentController,
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                hintText: 'Add a Comment...',
                                hintStyle: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          FloatingActionButton(
                            backgroundColor: kGreenColor,
                            onPressed: () {
                              context
                                  .read<PostimageuploadCubit>()
                                  .addComment(
                                      context, postId, _commentController.text)
                                  .whenComplete(() {
                                _commentController.clear();
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.comment,
                              color: kWhiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: kBlueGreyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        );
      });
}
