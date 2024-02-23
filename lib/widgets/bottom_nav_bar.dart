import 'dart:io';

import 'package:flutter/material.dart';
import 'package:koreanlms/providers/home/bottomnavbar_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (BuildContext context,
          BottomNavBarProvider bottomNavigationProvider, Widget? child) {
        return Container(
          height: Platform.isIOS ? 92 : 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: bottomNavigationProvider.currentIndex,
            onTap: (index) {
              bottomNavigationProvider.setIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.question_answer_outlined,
                ),
                label: "Quizes",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_none_outlined,
                ),
                label: "Notifications",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: "Settings",
              ),
            ],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
            ),
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            elevation: 20.0,
            selectedIconTheme: IconThemeData(
              color: Colors.green,
            ),
          ),
        );
      },
    );
  }
}
