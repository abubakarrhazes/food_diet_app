// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_diet_app/screens/forgot_password_screen/forgot_password.dart';
import 'package:food_diet_app/screens/login_screen/login.dart';
import 'package:food_diet_app/screens/onboard_screen/onboard.dart';
import 'package:food_diet_app/screens/pages/home_page.dart';
import 'package:food_diet_app/screens/register_screen/register.dart';
import 'package:food_diet_app/screens/splash_screen/splash_screen.dart';

class AppRoutes {
  String onboard = '/';
  String splash = '/splash';
  String welcome = '/welcome';
  String login = '/login';
  String register = '/register';
  String forgot = '/forgot';
  String home = '/home';

  Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Onboard());
      case '/splash':
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (context) => Register());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/forgot':
        return MaterialPageRoute(builder: (context) => ForgotPassword());
      default:
        throw ("Undefined Routes");
    }
  }
}
