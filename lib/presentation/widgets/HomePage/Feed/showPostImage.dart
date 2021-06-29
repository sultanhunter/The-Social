import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/Feed/cubit/postimageupload_cubit.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/editPostImage.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/selectPostImageType.dart';

showPostImage(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: kBlueGreyColor,
            borderRadius: BorderRadius.circular(12),
          ),
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
                height: 200,
                width: 400,
                child: Image.file(
                    context.read<PostimageuploadCubit>().state.fileImage,
                    fit: BoxFit.contain),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          selectPostImageType(context);
                        },
                        child: Text('Reselect',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: kWhiteColor))),
                    MaterialButton(
                      color: kBlueColor,
                      onPressed: () {
                        Navigator.pop(context);
                        editPostImageSheet(context);
                      },
                      child: Text(
                        'Confirm Image',
                        style: TextStyle(
                            color: kWhiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
