import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_social/constants/Constantcolors.dart';

showRewards(BuildContext context, DocumentSnapshot postSnapshot) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
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
                    'Rewards',
                    style: TextStyle(
                        color: kBlueColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 16),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('awards')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: GestureDetector(
                                onTap: () async {
                                  // await context
                                  //     .read<PostimageuploadCubit>()
                                  //     .addReward(
                                  //   context,
                                  //   postSnapshot.id,
                                  //   {
                                  //     'username': context
                                  //         .read<LoginCubit>()
                                  //         .state
                                  //         .userName,
                                  //     'userimage': context
                                  //         .read<LoginCubit>()
                                  //         .state
                                  //         .userImage,
                                  //     'useruid':
                                  //         context.read<LoginCubit>().state.uid,
                                  //     'time': Timestamp.now(),
                                  //     'awardimage': snapshot.data!.docs
                                  //         .elementAt(index)
                                  //         .get('image'),
                                  //     'awardtitle': snapshot.data!.docs
                                  //         .elementAt(index)
                                  //         .id
                                  //   },
                                  // );
                                  // Navigator.pop(context);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Image.network(
                                    snapshot.data!.docs
                                        .elementAt(index)
                                        .get('image'),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.size,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
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
