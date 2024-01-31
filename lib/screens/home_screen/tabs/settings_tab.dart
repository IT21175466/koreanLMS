import 'package:flutter/material.dart';
import 'package:koreanlms/widgets/button_widget.dart';
import 'package:koreanlms/widgets/user_info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            width: screenWidth,
            height: AppBar().preferredSize.height * 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight - (AppBar().preferredSize.height * 2) - 60,
            width: screenWidth,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/addProfilePic.png'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  UserInfoCard(hint: 'Full Name', detail: 'User full name'),
                  UserInfoCard(hint: 'Mobile Number', detail: '+94 6787123'),
                  UserInfoCard(hint: 'Email', detail: 'user@gmail.com'),
                  UserInfoCard(hint: 'NIC', detail: '123412341234V'),
                  UserInfoCard(hint: 'Batch', detail: '2022'),
                  UserInfoCard(hint: 'Class', detail: 'A'),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('logedIn', false);

                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                    child: CustomButton(
                      text: 'Logout',
                      height: 50,
                      width: screenWidth,
                      backgroundColor: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
