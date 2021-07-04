import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/presentation/screens/HomePage/home.dart';
import 'package:the_social/presentation/widgets/LandingPage/emailAuthSheet.dart';

class MainButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.85,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Buttons(
              ontap: () {
                emailAuthSheet(context);
              },
              icon: EvaIcons.emailOutline,
              borderColor: kYellowColor,
            ),
            Buttons(
              ontap: () {
                context
                    .read<LoginCubit>()
                    .sigInWithGoogle()
                    .then((value) async {
                  final userDocRef = FirebaseFirestore.instance
                      .collection('users')
                      .doc(context.read<LoginCubit>().state.uid);
                  final doc = await userDocRef.get();
                  if (!doc.exists) {
                    context.read<LoginCubit>().createGoogleUserCollection({
                      'useremail': context.read<LoginCubit>().state.userEmail,
                      'username': context.read<LoginCubit>().state.userName,
                      'userimage': context.read<LoginCubit>().state.userImage,
                      'useruid': context.read<LoginCubit>().state.uid,
                      'googlelogin':
                          context.read<LoginCubit>().state.isGoogleSignIn,
                      'emaillogin':
                          context.read<LoginCubit>().state.isEmailSigIn,
                    });
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                });
              },
              icon: EvaIcons.google,
              borderColor: kRedColor,
            ),
            // Buttons(
            //   ontap: () {
            //     context.read<LoginCubit>().signOutWithGoogle();
            //   },
            //   icon: EvaIcons.facebook,
            //   borderColor: kBlueColor,
            // ),
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final VoidCallback ontap;
  final IconData icon;
  final Color borderColor;
  Buttons({required this.icon, required this.borderColor, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        child: Icon(
          icon,
          color: borderColor,
        ),
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
