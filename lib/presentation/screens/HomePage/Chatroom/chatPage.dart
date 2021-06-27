import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/chat/Typing/bloc/typing_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

final TextEditingController _messageController = TextEditingController();

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
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
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            hintText: 'Enter a message',
                            hintStyle: TextStyle(color: kDarkColor),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(2)),
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
                              onPressed: () {},
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