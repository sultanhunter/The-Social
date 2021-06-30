import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'chatcreate_state.dart';

class ChatcreateCubit extends Cubit<ChatcreateState> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ChatcreateCubit() : super(ChatcreateState(receiverUid: 'null'));

  Future createChat(
      String loggedInUserUid, String receiverUid, dynamic data) async {
    await _firebaseFirestore
        .collection('users')
        .doc(loggedInUserUid)
        .collection('chats')
        .doc(receiverUid)
        .collection('allChats')
        .doc(Timestamp.now().toString())
        .set(data);

    _firebaseFirestore
        .collection('users')
        .doc(receiverUid)
        .collection('chats')
        .doc(loggedInUserUid)
        .collection('allChats')
        .doc(Timestamp.now().toString())
        .set(data);
  }

  void userSelected(String receiverUid) {
    emit(ChatcreateState(receiverUid: receiverUid));
  }
}
