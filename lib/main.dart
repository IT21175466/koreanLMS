import 'package:flutter/material.dart';
import 'package:koreanlms/constants/primary_colors.dart';
import 'package:koreanlms/providers/mobile_validation/phone_validation_provider.dart';
import 'package:koreanlms/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PhoneValidationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primary,
        ),
        initialRoute: '/login',
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
