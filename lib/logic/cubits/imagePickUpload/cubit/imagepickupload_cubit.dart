import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'imagepickupload_state.dart';

class ImagepickuploadCubit extends Cubit<ImagepickuploadState> {
  ImagepickuploadCubit()
      : super(
          ImagepickuploadState(fileImage: File('null'), imageUrl: 'null'),
        );

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(
        ImagepickuploadState(
            fileImage: File(pickedFile.path), imageUrl: 'null'),
      );
    }
  }

  clearImage() {
    emit(
      ImagepickuploadState(fileImage: File('null'), imageUrl: 'null'),
    );
  }

  Future uploadUserImage() async {
    UploadTask imageUploadTask;
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('userProfileImage/${state.fileImage.path}/${DateTime.now()}');
    imageUploadTask = imageReference.putFile(state.fileImage);
    await imageUploadTask;
    final imageUrl = await imageReference.getDownloadURL();
    emit(ImagepickuploadState(
        fileImage: File(state.fileImage.path), imageUrl: imageUrl));
  }
}
