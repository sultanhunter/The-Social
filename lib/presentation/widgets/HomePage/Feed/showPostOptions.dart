import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/Feed/cubit/postimageupload_cubit.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/editPostCaption.dart';

showPostOptions(BuildContext context, String postId, String imageLocation) {
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
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: kBlueColor,
                        onPressed: () {
                          editPostCaption(context, postId);
                        },
                        child: Text(
                          'Edit Caption',
                          style: TextStyle(
                              color: kWhiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                      MaterialButton(
                        color: kRedColor,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: kBlueColor,
                                  title: Text(
                                    'Delete this Post?',
                                    style: TextStyle(
                                        color: kWhiteColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: kWhiteColor,
                                            color: kWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                    MaterialButton(
                                      color: kRedColor,
                                      onPressed: () {
                                        context
                                            .read<PostimageuploadCubit>()
                                            .deletePost(
                                                context, postId, imageLocation)
                                            .whenComplete(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                            color: kWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ],
                                );
                              }).whenComplete(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          'Delete Post',
                          style: TextStyle(
                              color: kWhiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          // height: MediaQuery.of(context).size.height * 0.2,
          // width: MediaQuery.of(context).size.width,
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
