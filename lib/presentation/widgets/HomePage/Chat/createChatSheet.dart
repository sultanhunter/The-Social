import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/chat/chatcreate_cubit.dart';

class CreateChatSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkColor,
      appBar: AppBar(
        backgroundColor: kBlueGreyColor.withOpacity(0.4),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
                          snapshot.data!.docs.elementAt(index).get('useruid');
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<ChatcreateCubit>()
                              .userSelected(receiverUid);
                          Navigator.popAndPushNamed(context, '/chatPage');
                        },
                        child: Container(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                snapshot.data!.docs
                                    .elementAt(index)
                                    .get('userimage'),
                              ),
                            ),
                            title: Text(
                              snapshot.data!.docs
                                  .elementAt(index)
                                  .get('username'),
                              style: TextStyle(
                                  color: kBlueColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            subtitle: Text(
                              snapshot.data!.docs
                                  .elementAt(index)
                                  .get('useremail'),
                              style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                          ),
                        ),
                      );
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
