import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_social/constants/Constantcolors.dart';
import 'package:the_social/logic/cubits/Feed/cubit/postimageupload_cubit.dart';
import 'package:the_social/logic/cubits/chat/Typing/bloc/typing_bloc.dart';
import 'package:the_social/logic/cubits/imagePickUpload/cubit/imagepickupload_cubit.dart';
import 'package:the_social/logic/cubits/logIn/login_cubit.dart';
import 'package:the_social/logic/cubits/pageView/cubit/pageview_cubit.dart';
import 'package:the_social/presentation/routes/routes.dart';
import 'package:the_social/presentation/screens/SplashScreen/splashScreen.dart';
import './constants/Constantcolors.dart';

void main() {
  runApp(MyApp());
}

void initializeFirebase() async {
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _router = AppRouter();
  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<ImagepickuploadCubit>(
          create: (context) => ImagepickuploadCubit(),
        ),
        BlocProvider<PageviewCubit>(
          create: (context) => PageviewCubit(),
        ),
        BlocProvider<PostimageuploadCubit>(
          create: (context) => PostimageuploadCubit(),
        ),
        BlocProvider<TypingBloc>(
          create: (context) => TypingBloc(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: _router.onGenerateRoute,
        theme: ThemeData(
            accentColor: kBlueColor,
            fontFamily: 'Poppins',
            canvasColor: Colors.transparent),
        home: SplashScreen(),
      ),
    );
  }
}
