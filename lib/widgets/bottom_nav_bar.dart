import 'dart:io';

import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/providers/home/bottomnavbar_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (BuildContext context,
          BottomNavBarProvider bottomNavigationProvider, Widget? child) {
        return Container(
          height: Platform.isIOS ? 92 : 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
              horizontal: BorderSide(
                color: AppColors.textGaryColor,
                width: 0.3,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: bottomNavigationProvider.currentIndex,
            onTap: (index) {
              bottomNavigationProvider.setIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 20,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.question_answer,
                  size: 20,
                ),
                label: "Quizes",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  size: 20,
                ),
                label: "Notifications",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 20,
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
              fontSize: 12,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
            ),
            selectedItemColor: AppColors.orangeColor,
            unselectedItemColor: AppColors.accentColor,
            elevation: 20.0,
            selectedIconTheme: IconThemeData(
              color: AppColors.orangeColor,
            ),
          ),
        );
      },
    );
  }
}
