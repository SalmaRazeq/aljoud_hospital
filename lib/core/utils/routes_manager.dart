import 'package:aljoud_hospital/presntation/screens/auth/log_in/login.dart';
import 'package:aljoud_hospital/presntation/screens/auth/register/register.dart';
import 'package:aljoud_hospital/presntation/screens/start/start.dart';
import 'package:flutter/material.dart';
import '../../presntation/screens/home/home.dart';
import '../../presntation/screens/splash/splash.dart';

class RoutesManager{
  static const String splash = '/splash';
  static const String home = '/home';
  static const String start = '/start';
  static const String login = '/login';
  static const String register = '/register';



  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case start:
        return MaterialPageRoute(
          builder: (context) => const StartScreen(),
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case register:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
    }
  }
}