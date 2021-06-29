import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/presentation/screens/HomePage/UserPosts/userPosts.dart';

Widget footerProfile(
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.57,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: kDarkColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(context.read<LoginCubit>().state.uid)
              .collection('posts')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final size = snapshot.data!.size;
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  itemCount: size,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserPosts(
                                userUid: context.read<LoginCubit>().state.uid,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          child: FittedBox(
                            clipBehavior: Clip.antiAlias,
                            fit: BoxFit.cover,
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
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Image.network(
                                      snapshot1.data!.get('imageurl'));
                                }),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
    ),
  );
}
