part of 'typing_bloc.dart';

class TypingState extends Equatable {
  final String typedMessage;
  TypingState({required this.typedMessage});

  @override
  List<Object> get props => [typedMessage];
}
