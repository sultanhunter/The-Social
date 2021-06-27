import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/presentation/screens/HomePage/Chatroom/chatPage.dart';

class CreateChatSheet extends StatelessWidget {
  const CreateChatSheet({Key? key}) : super(key: key);

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
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ChatPage()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
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
                        );
                      },
                      itemCount: snapshot.data!.size,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
