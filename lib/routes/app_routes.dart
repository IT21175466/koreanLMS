import 'package:flutter/material.dart';
import 'package:koreanlms/screens/authentication/login_screen/login_page.dart';
import 'package:koreanlms/screens/authentication/signup_screen/signup_screen.dart';
import 'package:koreanlms/screens/home_screen/home_screen.dart';
import 'package:koreanlms/screens/quiz/question_screen.dart';
import 'package:koreanlms/screens/quiz/quiz_ending.dart';
import 'package:koreanlms/screens/splash_screen/initial_splash.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/initsplash': (context) => InitialSplash(),
      '/login': (context) => LoginScreen(),
      '/signup': (context) => SignUPScreen(),
      '/home': (context) => HomeScreen(),
      '/quiz': (context) => QuestionScreen(),
      '/quizend': (context) => QuizEnd(),
    };
  }
}
