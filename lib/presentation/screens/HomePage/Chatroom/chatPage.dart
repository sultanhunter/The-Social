import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/blocs/typing/bloc/typing_bloc.dart';
import 'package:the_social/logic/cubits/chat/chatcreate_cubit.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController _messageController;
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String receiverUid =
        context.read<ChatcreateCubit>().state.receiverUid;
    final String loggedInUserUid = context.read<LoginCubit>().state.uid;
    return Scaffold(
      backgroundColor: kDarkColor,
      appBar: AppBar(
        backgroundColor: kBlueGreyColor.withOpacity(0.4),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 5,
              color: kRedColor,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    // backgroundBlendMode: BlendMode.color,
                    color: kBlueColor,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                height: MediaQuery.of(context).size.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        cursorColor: kDarkColor,
                        style: TextStyle(
                            color: kDarkColor,
                            fontSize: 16,
                            decoration: TextDecoration.none),
                        decoration: InputDecoration(
                          hintText: 'Enter a message',
                          hintStyle: TextStyle(color: kDarkColor),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(2),
                        ),
                        controller: _messageController,
                        onChanged: (value) {
                          context
                              .read<TypingBloc>()
                              .add(TypingText(text: value));
                        },
                      ),
                    ),
                    Container(child: BlocBuilder<TypingBloc, TypingState>(
                      builder: (context, state) {
                        if (state.typedMessage.isNotEmpty) {
                          return TextButton(
                              onPressed: () {
                                context
                                    .read<ChatcreateCubit>()
                                    .createChat(loggedInUserUid, receiverUid, {
                                  'message': _messageController.text,
                                  'time': Timestamp.now(),
                                });
                              },
                              child: Text(
                                'Send',
                                style: TextStyle(
                                    color: kDarkColor,
                                    fontWeight: FontWeight.bold),
                              ));
                        } else {
                          return Container(
                            height: 0,
                            width: 0,
                          );
                        }
                      },
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
