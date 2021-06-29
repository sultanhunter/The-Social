import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_social/constants/Constantcolors.dart';

Widget altProfileMiddle(
    BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        width: 150,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              FontAwesomeIcons.userAstronaut,
              color: kYellowColor,
              size: 16,
            ),
            Text(
              'Recently Added',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kWhiteColor),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userSnapshot.data!.id)
                  .collection('following')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final _useruid = snapshot.data!.docs
                          .elementAt(index)
                          .get('followinguid');
                      return StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(_useruid)
                              .snapshots(),
                          builder: (context, snapshot1) {
                            if (snapshot1.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      child: FittedBox(
                                        child: Image.network(
                                            snapshot1.data!.get('userimage')),
                                        fit: BoxFit.cover,
                                      ),
                                      decoration: BoxDecoration(
                                        color: kTransperant,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08 *
                                              0.7 *
                                              0.5),
                                        ),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08 *
                                              0.7,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.08 *
                                              0.7,
                                    ),
                                  ],
                                ),
                              );
                            }
                          });
                    },
                    itemCount: snapshot.data!.size,
                  );

                  //
                }
              }),
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: kDarkColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      )
    ],
  );
}
