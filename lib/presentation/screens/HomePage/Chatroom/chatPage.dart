import 'dart:math';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/blocs/typing/bloc/typing_bloc.dart';
import 'package:the_social/logic/cubits/chat/chatcreate_cubit.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController _messageController;
  @override
  void dispose() {
    context.read<TypingBloc>().add(TypingText(text: ""));
    _messageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String receiverUid =
        context.read<ChatcreateCubit>().state.receiverUid;
    final String loggedInUserUid = context.read<LoginCubit>().state.uid;
    return Scaffold(
      backgroundColor: kDarkColor,
      appBar: AppBar(
        title: BlocBuilder<ChatcreateCubit, ChatcreateState>(
            builder: (context, state) {
          return StreamBuilder<DocumentSnapshot>(
              stream: _firebaseFirestore
                  .collection('users')
                  .doc(state.receiverUid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                          snapshot.data!.get('userimage'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          child: Text(
                            snapshot.data!.get('username'),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              });
        }),
        backgroundColor: kBlueGreyColor.withOpacity(0.4),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firebaseFirestore
                      .collection('users')
                      .doc(context.read<LoginCubit>().state.uid)
                      .collection('chats')
                      .doc(receiverUid)
                      .collection('allChats')
                      .orderBy('timeseconds', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: StreamBuilder<DocumentSnapshot>(
                                  stream: _firebaseFirestore
                                      .collection('users')
                                      .doc(snapshot.data!.docs
                                          .elementAt(index)
                                          .get('senderuid'))
                                      .snapshots(),
                                  builder: (context, snapshot1) {
                                    if (snapshot1.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return Row(
                                        mainAxisAlignment: snapshot.data!.docs
                                                    .elementAt(index)
                                                    .get('senderuid') ==
                                                context
                                                    .read<LoginCubit>()
                                                    .state
                                                    .uid
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                        children: [
                                          snapshot.data!.docs
                                                      .elementAt(index)
                                                      .get('senderuid') ==
                                                  context
                                                      .read<LoginCubit>()
                                                      .state
                                                      .uid
                                              ? Container(
                                                  height: 0,
                                                  width: 0,
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0,
                                                          left: 10.0),
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(snapshot1
                                                            .data!
                                                            .get('userimage')),
                                                  ),
                                                ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: kBlueGreyColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    snapshot.data!.docs
                                                        .elementAt(index)
                                                        .get('message'),
                                                    style: TextStyle(
                                                        color: kWhiteColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          snapshot.data!.docs
                                                      .elementAt(index)
                                                      .get('senderuid') ==
                                                  context
                                                      .read<LoginCubit>()
                                                      .state
                                                      .uid
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0),
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(snapshot1
                                                            .data!
                                                            .get('userimage')),
                                                  ),
                                                )
                                              : Container(
                                                  height: 0,
                                                  width: 0,
                                                ),
                                        ],
                                      );
                                    }
                                  }),
                            ),
                          );
                        },
                        itemCount: snapshot.data!.size,
                      );
                    }
                  }),
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewInsets.bottom -
                  MediaQuery.of(context).size.height * 0.1,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.2),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.81 -
                  MediaQuery.of(context).viewInsets.bottom,
              left: MediaQuery.of(context).size.width * 0.08 * 0.5,
              child: Container(
                decoration: BoxDecoration(
                    // backgroundBlendMode: BlendMode.color,
                    color: kBlueColor,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.92,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        cursorColor: kDarkColor,
                        style: TextStyle(
                            color: kDarkColor,
                            fontSize: 16,
                            decoration: TextDecoration.none),
                        decoration: InputDecoration(
                          hintText: 'Enter a message',
                          hintStyle: TextStyle(color: kDarkColor),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(2),
                        ),
                        controller: _messageController,
                        onChanged: (value) {
                          context
                              .read<TypingBloc>()
                              .add(TypingText(text: value));
                        },
                      ),
                    ),
                    Container(child: BlocBuilder<TypingBloc, TypingState>(
                      builder: (context, state) {
                        if (_messageController.text.isNotEmpty) {
                          return TextButton(
                              onPressed: () {
                                final DateTime dateTime = DateTime.now();
                                final Timestamp timestamp = Timestamp.now();
                                final double time = timestamp.seconds +
                                    timestamp.nanoseconds *
                                        (pow(10, -9).toDouble());
                                String temp = _messageController.text;
                                _messageController.clear();
                                context
                                    .read<TypingBloc>()
                                    .add(TypingText(text: ""));
                                context.read<ChatcreateCubit>().createChat(
                                    loggedInUserUid, receiverUid, time, {
                                  'message': temp,
                                  'time': dateTime,
                                  'timeseconds': time,
                                  'senderuid':
                                      context.read<LoginCubit>().state.uid,
                                  'receiveruid': context
                                      .read<ChatcreateCubit>()
                                      .state
                                      .receiverUid,
                                });
                              },
                              child: Text(
                                'Send',
                                style: TextStyle(
                                    color: kDarkColor,
                                    fontWeight: FontWeight.bold),
                              ));
                        } else {
                          return Container(
                            height: 0,
                            width: 0,
                          );
                        }
                      },
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
