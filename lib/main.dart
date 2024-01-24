import 'package:flutter/material.dart';
import 'package:koreanlms/constants/primary_colors.dart';
import 'package:koreanlms/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primary,
      ),
      initialRoute: '/initsplash',
      routes: AppRoutes.getRoutes(),
    );
  }
}
