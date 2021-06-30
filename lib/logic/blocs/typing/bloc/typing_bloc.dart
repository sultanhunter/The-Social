import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'typing_event.dart';
part 'typing_state.dart';

class TypingBloc extends Bloc<TypingEvent, TypingState> {
  TypingBloc() : super(TypingState(typedMessage: ""));

  @override
  Stream<TypingState> mapEventToState(
    TypingEvent event,
  ) async* {
    if (event is TypingText) {
      yield TypingState(typedMessage: event.text);
    }
  }
}
