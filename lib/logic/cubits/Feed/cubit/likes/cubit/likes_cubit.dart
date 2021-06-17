import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'likes_state.dart';

class LikesCubit extends Cubit<LikesState> {
  LikesCubit() : super(LikesState(isLiked: false));

  likingDisliking() {
    if (state.isLiked == false) {
      emit(LikesState(isLiked: true));
    } else if (state.isLiked == true) {
      emit(LikesState(isLiked: false));
    }
  }
}
