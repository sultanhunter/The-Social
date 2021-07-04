import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/constants/constantStyles.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/presentation/screens/HomePage/home.dart';

logInSheet(BuildContext context) {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: kBlueGreyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
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
              // CircleAvatar(
              //   backgroundColor: kTransperant,
              //   radius: 80.0,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter email',
                    hintStyle: kSigninText,
                  ),
                  style: kSigninText.copyWith(fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    hintStyle: kSigninText,
                  ),
                  style: kSigninText.copyWith(fontSize: 18.0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                backgroundColor: kBlueColor,
                onPressed: () {
                  if (emailController.text.isNotEmpty ||
                      passController.text.isNotEmpty) {
                    context
                        .read<LoginCubit>()
                        .logIntoAccount(
                            emailController.text, passController.text)
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          ModalRoute.withName('/landing'));
                    });
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content:
                              const Text('Email or password can\'t be empty'),
                        );
                      },
                    );
                  }
                },
                child: Icon(
                  FontAwesomeIcons.check,
                  color: kWhiteColor,
                ),
              ),

              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    },
  );
}
