import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'postimageupload_state.dart';

class PostimageuploadCubit extends Cubit<PostimageuploadState> {
  PostimageuploadCubit()
      : super(
          PostimageuploadState(fileImage: File('null'), imageUrl: 'null'),
        );

  final picker = ImagePicker();
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      emit(
        PostimageuploadState(
            fileImage: File(pickedFile.path), imageUrl: 'null'),
      );
    }
  }

  Future uploadPostImage(BuildContext context) async {
    UploadTask imageUploadTask;
    Reference imageReference = FirebaseStorage.instance.ref().child(
        'posts/${context.read<LoginCubit>().state.uid}/${state.fileImage.path}');
    imageUploadTask = imageReference.putFile(state.fileImage);
    await imageUploadTask;
    final imageUrl = await imageReference.getDownloadURL();
    emit(PostimageuploadState(
      fileImage: File(state.fileImage.path),
      imageUrl: imageUrl,
    ));
  }

  Future uploadPostData(BuildContext context, dynamic data) async {
    final DateTime dateTime = DateTime.now();
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(dateTime.toString())
        .set(data);
    FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<LoginCubit>().state.uid)
        .collection('posts')
        .doc(dateTime.toString())
        .set({
      'postId': dateTime.toString(),
    });
  }

  Future updatePostCaption(
      BuildContext context, String postId, String newCaption) async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update({'caption': newCaption});
  }

  Future deletePost(
      BuildContext context, String postId, String imageLocation) async {
    await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
    await FirebaseStorage.instance.ref().child(imageLocation).delete();
    FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<LoginCubit>().state.uid)
        .collection('posts')
        .doc(postId)
        .delete();
  }

  Future addLike(BuildContext context, String postId) async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(context.read<LoginCubit>().state.uid)
        .set({
      'like': true,
      'useruid': context.read<LoginCubit>().state.uid,
      'username': context.read<LoginCubit>().state.userName,
      'userimage': context.read<LoginCubit>().state.userImage,
      'useremail': context.read<LoginCubit>().state.userEmail,
      'time': Timestamp.now()
    });
  }

  Future deleteLike(BuildContext context, String postId) async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(context.read<LoginCubit>().state.uid)
        .delete();
  }

  Future addComment(BuildContext context, String postId, String comment) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(comment)
        .set({
      'comment': comment,
      'useruid': context.read<LoginCubit>().state.uid,
      'username': context.read<LoginCubit>().state.userName,
      'userimage': context.read<LoginCubit>().state.userImage,
      'useremail': context.read<LoginCubit>().state.userEmail,
      'time': Timestamp.now()
    });
  }

  Future followUser(
      String followerUid, String followingUid, dynamic data) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(followingUid)
        .collection('followers')
        .doc(followerUid)
        .set(data);
    FirebaseFirestore.instance
        .collection('users')
        .doc(followerUid)
        .collection('following')
        .doc(followingUid)
        .set({
      'followinguid': followingUid,
      'time': Timestamp.now(),
    });
  }

  Future unFollowUser(String followerUid, String followingUid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(followingUid)
        .collection('followers')
        .doc(followerUid)
        .delete();
    FirebaseFirestore.instance
        .collection('users')
        .doc(followerUid)
        .collection('following')
        .doc(followingUid)
        .delete();
  }

  String showTimeAgo(dynamic timedata) {
    Timestamp time = timedata;
    DateTime dateTime = time.toDate();
    return timeago.format(dateTime);
  }
}
