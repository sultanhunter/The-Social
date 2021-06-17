import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/Feed/cubit/postimageupload_cubit.dart';
import 'package:the_social/presentation/widgets/HomePage/Feed/editPostImage.dart';

selectPostImageType(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.1,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: kLightBlueColor,
                    onPressed: () {
                      context
                          .read<PostimageuploadCubit>()
                          .getImage(ImageSource.gallery)
                          .then((value) {
                        Navigator.pop(context);

                        editPostImageSheet(context);
                      });
                    },
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  MaterialButton(
                    color: kLightBlueColor,
                    onPressed: () {
                      context
                          .read<PostimageuploadCubit>()
                          .getImage(ImageSource.camera)
                          .then((value) {
                        Navigator.pop(context);

                        editPostImageSheet(context);
                      });
                    },
                    child: Text(
                      'Camera',
                      style: TextStyle(
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
}
