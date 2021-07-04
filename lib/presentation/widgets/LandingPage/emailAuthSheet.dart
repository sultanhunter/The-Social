import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/constants/constantStyles.dart';
import 'package:the_social/presentation/widgets/LandingPage/login_sheet.dart';
import 'package:the_social/presentation/widgets/LandingPage/passwordless_signin.dart';
import 'package:the_social/presentation/widgets/LandingPage/signup_sheet.dart';

emailAuthSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(
                  thickness: 4.0,
                  color: kWhiteColor,
                ),
              ),
              // PassWordLessSignin(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      color: kBlueColor,
                      onPressed: () {
                        logInSheet(context);
                      },
                      child: Text(
                        'Log In',
                        style: kButtonTextStyle,
                      ),
                    ),
                    MaterialButton(
                      color: kRedColor,
                      onPressed: () {
                        signUpSheet(context);
                      },
                      child: Text(
                        'Sign Up',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          // height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: kBlueGreyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
        );
      });
}
