import 'package:flutter/material.dart';
import 'package:the_social/presentation/screens/HomePage/Chatroom/chatPage.dart';
import 'package:the_social/presentation/screens/HomePage/Profile/profile.dart';
import 'package:the_social/presentation/screens/HomePage/home.dart';
import 'package:the_social/presentation/screens/LandingPage/landingPage.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/chatPage':
        return MaterialPageRoute(builder: (_) => ChatPage());

      case '/landing':
        return MaterialPageRoute(builder: (_) => LandingPage());

      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());

      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());

      default:
        return MaterialPageRoute(builder: (_) => LandingPage());
    }
  }
}
