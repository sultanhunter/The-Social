import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/constants/constantStyles.dart';
import 'package:the_social/logic/cubits/chat/chatcreate_cubit.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/presentation/widgets/HomePage/Chat/createChatSheet.dart';

class ChatRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseFirestore
                .collection('users')
                .doc(context.read<LoginCubit>().state.uid)
                .collection('chats')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final receiverUid =
                          snapshot.data!.docs.elementAt(index).id;

                      return StreamBuilder<DocumentSnapshot>(
                          stream: _firebaseFirestore
                              .collection('users')
                              .doc(receiverUid)
                              .snapshots(),
                          builder: (context, snapshot1) {
                            if (snapshot1.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<ChatcreateCubit>()
                                      .userSelected(receiverUid);
                                  Navigator.pushNamed(context, '/chatPage');
                                },
                                child: Container(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        snapshot1.data!.get('userimage'),
                                      ),
                                    ),
                                    title: Text(
                                      snapshot1.data!.get('username'),
                                      style: TextStyle(
                                          color: kBlueColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                    subtitle: StreamBuilder<QuerySnapshot>(
                                        stream: _firebaseFirestore
                                            .collection('users')
                                            .doc(context
                                                .read<LoginCubit>()
                                                .state
                                                .uid)
                                            .collection('chats')
                                            .doc(receiverUid)
                                            .collection('allChats')
                                            .snapshots(),
                                        builder: (context, snapshot2) {
                                          if (snapshot2.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (snapshot2.hasData) {
                                            final messagesSize =
                                                snapshot2.data!.size;

                                            return Text(
                                              snapshot2.data!.docs
                                                  .elementAt(messagesSize - 1)
                                                  .get('message'),
                                              style: TextStyle(
                                                  color: kGreenColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0),
                                            );
                                          } else {
                                            return Container(
                                              height: 0,
                                              width: 0,
                                            );
                                          }
                                        }),
                                  ),
                                ),
                              );
                            }
                          });
                    },
                    itemCount: snapshot.data!.size,
                  ),
                );
              }
            }),
      ),
    );
  }
}
