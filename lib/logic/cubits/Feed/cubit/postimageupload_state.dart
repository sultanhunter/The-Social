part of 'postimageupload_cubit.dart';

class PostimageuploadState extends Equatable {
  final File fileImage;
  final String imageUrl;

  PostimageuploadState({required this.fileImage, required this.imageUrl});

  @override
  List<Object> get props => [fileImage, imageUrl];
}
