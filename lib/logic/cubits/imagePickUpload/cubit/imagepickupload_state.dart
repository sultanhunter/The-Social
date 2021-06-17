part of 'imagepickupload_cubit.dart';

class ImagepickuploadState extends Equatable {
  final File fileImage;
  final String imageUrl;
  // final String assetImage;
  ImagepickuploadState({required this.fileImage, required this.imageUrl});

  @override
  List<Object> get props => [fileImage.path, imageUrl];
}
