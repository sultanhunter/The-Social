import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/constants/constantStyles.dart';
import 'package:the_social/logic/cubits/imagePickUpload/cubit/imagepickupload_cubit.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/presentation/screens/HomePage/home.dart';

signUpSheet(BuildContext context) {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
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
              Container(
                width: MediaQuery.of(context).size.width * 0.30,
                height: MediaQuery.of(context).size.width * 0.30,
                decoration: BoxDecoration(
                  border: Border.all(color: kRedColor, width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(300),
                  ),
                ),
                child: BlocBuilder<ImagepickuploadCubit, ImagepickuploadState>(
                    builder: (context, state) {
                  if (state.fileImage.path == 'null') {
                    return CircleAvatar(
                      backgroundColor: kTransperant,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    );
                  } else {
                    return CircleAvatar(
                      backgroundColor: kTransperant,
                      backgroundImage: FileImage(state.fileImage),
                    );
                  }
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<ImagepickuploadCubit>().clearImage();
                    },
                    child: Text('Clear'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ImagepickuploadCubit>().getImage();
                    },
                    child: Text('Select Profile Photo'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                    hintStyle: kSigninText,
                  ),
                  style: kSigninText.copyWith(fontSize: 18.0),
                ),
              ),
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
                backgroundColor: kRedColor,
                onPressed: () async {
                  if (emailController.text.isNotEmpty &&
                      passController.text.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      context
                              .read<ImagepickuploadCubit>()
                              .state
                              .fileImage
                              .path !=
                          'null') {
                    await context
                        .read<ImagepickuploadCubit>()
                        .uploadUserImage();

                    await context.read<LoginCubit>().createAccount(
                        emailController.text, passController.text);

                    await context.read<LoginCubit>().createUserCollection({
                      'useruid': context.read<LoginCubit>().state.uid,
                      'useremail': emailController.text,
                      'username': nameController.text,
                      'userimage':
                          context.read<ImagepickuploadCubit>().state.imageUrl,
                      'userpassword': passController.text,
                      'googlelogin':
                          context.read<LoginCubit>().state.isGoogleSignIn,
                      'emaillogin':
                          context.read<LoginCubit>().state.isEmailSigIn,
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        ModalRoute.withName('/landing'));
                  } else if (emailController.text.isNotEmpty &&
                      passController.text.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      context
                              .read<ImagepickuploadCubit>()
                              .state
                              .fileImage
                              .path ==
                          'null') {
                    await context
                        .read<ImagepickuploadCubit>()
                        .uploadUserImage();

                    await context.read<LoginCubit>().createAccount(
                        emailController.text, passController.text);

                    await context.read<LoginCubit>().createUserCollection({
                      'useruid': context.read<LoginCubit>().state.uid,
                      'useremail': emailController.text,
                      'username': nameController.text,
                      'userimage':
                          'https://firebasestorage.googleapis.com/v0/b/thesocial-5f7bc.appspot.com/o/userProfileImage%2Fdata%2Fuser%2F0%2Fcom.example.the_social%2Fcache%2Fdefault_profile%2Fuser.png?alt=media&token=ddd3dbdc-ca69-4fe3-8e88-3a442f46a91b',
                      'userpassword': passController.text,
                      'googlelogin':
                          context.read<LoginCubit>().state.isGoogleSignIn,
                      'emaillogin':
                          context.read<LoginCubit>().state.isEmailSigIn,
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        ModalRoute.withName('/landing'));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content:
                                Text('Email, Password or name can\'t be empty'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ok'))
                            ],
                          );
                        });
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
