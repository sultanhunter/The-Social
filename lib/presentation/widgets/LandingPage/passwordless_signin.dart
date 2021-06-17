import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/constants/constantStyles.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/presentation/screens/HomePage/home.dart';

class PassWordLessSignin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children:
                  snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.get('googlelogin') == false) {
                  return ListTile(
                    trailing: Container(
                      width: 120,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.check,
                              color: kBlueColor,
                            ),
                            onPressed: () {
                              context
                                  .read<LoginCubit>()
                                  .logIntoAccount(
                                      documentSnapshot.get('useremail'),
                                      documentSnapshot.get('userpassword'))
                                  .whenComplete(() {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    ModalRoute.withName('/landing'));
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.trashAlt,
                              color: kRedColor,
                            ),
                            onPressed: () {
                              context.read<LoginCubit>().deleteUserData(
                                    documentSnapshot.get('useruid'),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(documentSnapshot.get('userimage')),
                    ),
                    title: Text(
                      documentSnapshot.get('username'),
                      style: kPasswordLessSigninTitleText,
                    ),
                    subtitle: Text(
                      documentSnapshot.get('useremail'),
                      style:
                          kPasswordLessSigninTitleText.copyWith(fontSize: 12),
                    ),
                  );
                } else {
                  return Container(
                    height: 0.0,
                    width: 0.0,
                  );
                }
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
