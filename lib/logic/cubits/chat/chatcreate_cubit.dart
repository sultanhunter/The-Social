import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'chatcreate_state.dart';

class ChatcreateCubit extends Cubit<ChatcreateState> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ChatcreateCubit() : super(ChatcreateState(receiverUid: 'null'));

  Future createChat(String loggedInUserUid, String receiverUid, double time,
      dynamic data) async {
    await _firebaseFirestore
        .collection('users')
        .doc(loggedInUserUid)
        .collection('chats')
        .doc(receiverUid)
        .set({});

    await _firebaseFirestore
        .collection('users')
        .doc(loggedInUserUid)
        .collection('chats')
        .doc(receiverUid)
        .collection('allChats')
        .doc(time.toString())
        .set(data);

    await _firebaseFirestore
        .collection('users')
        .doc(receiverUid)
        .collection('chats')
        .doc(loggedInUserUid)
        .set({});

    _firebaseFirestore
        .collection('users')
        .doc(receiverUid)
        .collection('chats')
        .doc(loggedInUserUid)
        .collection('allChats')
        .doc(time.toString())
        .set(data);
  }

  void userSelected(String receiverUid) {
    emit(ChatcreateState(receiverUid: receiverUid));
  }

  String chatTime(dynamic timedata) {
    String formattedDate = DateFormat('dd-MM-yyyy - kk:mm').format(timedata);
    return formattedDate;
  }
}
