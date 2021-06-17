import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  LoginCubit()
      : super(
          LoginState(
              uid: 'null',
              userEmail: 'null',
              userImage: 'null',
              userName: 'null',
              isEmailSigIn: false,
              isGoogleSignIn: false),
        );

  Future logIntoAccount(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    if (user != null) {
      await _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .get()
          .then((doc) {
        emit(LoginState(
            uid: user.uid,
            userEmail: doc.data()!['useremail'],
            userName: doc.data()!['username'],
            userImage: doc.data()!['userimage'],
            isEmailSigIn: true,
            isGoogleSignIn: false));
      });
    }
  }

  Future createAccount(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    if (user != null) {
      emit(LoginState(
          uid: user.uid,
          userName: 'null',
          userEmail: 'null',
          userImage: 'null',
          isEmailSigIn: true,
          isGoogleSignIn: false));
    }
  }

  Future logOutWithEmail() async {
    emit(LoginState(
        uid: 'null',
        userEmail: 'null',
        userImage: 'null',
        userName: 'null',
        isEmailSigIn: false,
        isGoogleSignIn: false));
    return _firebaseAuth.signOut();
  }

  Future sigInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(authCredential);

    final User? user = userCredential.user;
    if (user != null) {
      emit(LoginState(
          uid: user.uid,
          userEmail: user.email as String,
          userName: user.displayName as String,
          userImage: user.photoURL as String,
          isEmailSigIn: false,
          isGoogleSignIn: true));
    }
  }

  Future signOutWithGoogle() async {
    emit(LoginState(
        uid: 'null',
        userEmail: 'null',
        userImage: 'null',
        userName: 'null',
        isEmailSigIn: false,
        isGoogleSignIn: false));
    return _googleSignIn.signOut();
  }

  Future createUserCollection(dynamic data) async {
    await _firebaseFirestore.collection('users').doc(state.uid).set(data);
    emit(
      LoginState(
          uid: state.uid,
          userName: data['username'],
          userEmail: data['useremail'],
          userImage: data['userimage'],
          isEmailSigIn: true,
          isGoogleSignIn: false),
    );
  }

  Future createGoogleUserCollection(dynamic data) async {
    await _firebaseFirestore.collection('users').doc(state.uid).set(data);
  }

  Future deleteUserData(String uid) {
    return _firebaseFirestore.collection('users').doc(uid).delete();
  }
}
