import 'package:flutter/material.dart';
import 'package:koreanlms/providers/home/bottomnavbar_provider.dart';
import 'package:koreanlms/screens/home_screen/tabs/home_tab.dart';
import 'package:koreanlms/screens/home_screen/tabs/notification_tab.dart';
import 'package:koreanlms/screens/home_screen/tabs/quiz_tab/quizes_tab.dart';
import 'package:koreanlms/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Tabs
  final List<Widget> pages = [
    HomeTab(),
    QuizTab(),
    NotificationTab(),
    Center(
      child: Text("Settings"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 240, 240),
          //borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            opacity: 0.2,
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/koreanlms-f3ced.appspot.com/o/app_background%2Fbackground.jpg?alt=media&token=dd221373-4155-4233-83d9-27f4fcb9c47c'),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer(
          builder: (BuildContext context,
                  BottomNavBarProvider bottomNavigationProvider,
                  Widget? child) =>
              IndexedStack(
            index: bottomNavigationProvider.currentIndex,
            children: pages,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
