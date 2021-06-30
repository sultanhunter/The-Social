part of 'chatcreate_cubit.dart';

class ChatcreateState extends Equatable {
  final String receiverUid;

  const ChatcreateState({required this.receiverUid});

  @override
  List<Object> get props => [receiverUid];
}

// class ChatCreated extends ChatcreateState {
//   final String receiverUid;
//   ChatCreated({required this.receiverUid});

//   @override
//   List<Object> get props => [receiverUid];
// }


