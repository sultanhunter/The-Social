import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/Feed/cubit/postimageupload_cubit.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/selectPostImageType.dart';

editPostImageSheet(BuildContext context) {
  final TextEditingController _captionController = TextEditingController();
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
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
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.image_aspect_ratio,
                                color: kGreenColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.fit_screen,
                                color: kYellowColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75 * 0.5,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Image.file(
                            context
                                .read<PostimageuploadCubit>()
                                .state
                                .fileImage,
                            fit: BoxFit.contain),
                      ),
                    ],
                  ),
                ),
                Row(children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        selectPostImageType(context);
                      },
                      child: Text(
                        'Reselect',
                        style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: kWhiteColor),
                      ))
                ]),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: Image.asset('assets/icons/sunflower.png')),
                      Container(
                        height: 110,
                        width: 5,
                        color: kBlueColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 120,
                          width: 330,
                          child: TextField(
                            maxLines: 5,
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100)
                            ],
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 100,
                            controller: _captionController,
                            style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: 'Add a Caption...',
                              hintStyle: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  color: kBlueColor,
                  onPressed: () {
                    context
                        .read<PostimageuploadCubit>()
                        .uploadPostImage(context)
                        .whenComplete(() {
                      context
                          .read<PostimageuploadCubit>()
                          .uploadPostData(context, {
                        'imageurl':
                            context.read<PostimageuploadCubit>().state.imageUrl,
                        'caption': _captionController.text,
                        'username': context.read<LoginCubit>().state.userName,
                        'useremail': context.read<LoginCubit>().state.userEmail,
                        'useruid': context.read<LoginCubit>().state.uid,
                        'userimage': context.read<LoginCubit>().state.userImage,
                        'time': Timestamp.now(),
                        'imagelocation':
                            'posts/${context.read<LoginCubit>().state.uid}${context.read<PostimageuploadCubit>().state.fileImage.path}',
                      }).whenComplete(() {
                        Navigator.pop(context);
                      });
                    });
                  },
                  child: Text(
                    'Share',
                    style: TextStyle(
                        color: kWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: kBlueGreyColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      });
}
