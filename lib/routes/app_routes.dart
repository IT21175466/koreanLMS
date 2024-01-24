import 'package:flutter/material.dart';
import 'package:koreanlms/screens/authentication/login_screen/login_page.dart';
import 'package:koreanlms/screens/splash_screen/initial_splash.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/initsplash': (context) => InitialSplash(),
      '/login': (context) => LoginScreen(),
    };
  }
}
