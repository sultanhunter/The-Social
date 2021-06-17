part of 'likes_cubit.dart';

class LikesState extends Equatable {
  final bool isLiked;

  LikesState({required this.isLiked});

  @override
  List<Object> get props => [isLiked];
}
