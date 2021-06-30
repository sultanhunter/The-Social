part of 'typing_bloc.dart';

abstract class TypingEvent extends Equatable {
  const TypingEvent();
}

class TypingText extends TypingEvent {
  const TypingText({required this.text});

  final String text;
  @override
  List<Object> get props => [text];
}
