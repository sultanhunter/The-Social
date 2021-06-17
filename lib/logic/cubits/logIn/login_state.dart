part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String userName;
  final String userEmail;
  final String userImage;
  final String uid;
  final bool isGoogleSignIn;
  final bool isEmailSigIn;
  LoginState({
    required this.uid,
    required this.userName,
    required this.userEmail,
    required this.userImage,
    required this.isEmailSigIn,
    required this.isGoogleSignIn,
  });

  @override
  List<Object?> get props =>
      [uid, userName, userEmail, userImage, isEmailSigIn, isGoogleSignIn];
}
