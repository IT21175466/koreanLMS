import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:koreanlms/constants/primary_colors.dart';
import 'package:koreanlms/providers/authentication/signup_provider.dart';
import 'package:koreanlms/providers/home/bottomnavbar_provider.dart';
import 'package:koreanlms/providers/mobile_validation/phone_validation_provider.dart';
import 'package:koreanlms/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PhoneValidationProvider()),
        ChangeNotifierProvider(create: (context) => SignUPProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primary,
        ),
        initialRoute: '/initsplash',
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
