import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/presentation/screens/LandingPage/landingPage.dart';

logOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kBlueColor,
          title: Text(
            'Log Out Of theSocial',
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: kWhiteColor,
                    decoration: TextDecoration.underline,
                    decorationColor: kWhiteColor),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                if (context.read<LoginCubit>().state.isGoogleSignIn == true) {
                  await context.read<LoginCubit>().signOutWithGoogle();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                      ModalRoute.withName('/landing'));
                } else if (context.read<LoginCubit>().state.isEmailSigIn ==
                    true) {
                  await context.read<LoginCubit>().logOutWithEmail();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                      ModalRoute.withName('/landing'));
                }
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: kRedColor,
                ),
              ),
            )
          ],
        );
      });
}
