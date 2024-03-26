import 'dart:io';

import 'package:flutter/material.dart';
import 'package:koreanlms/providers/student_provider/student_provider.dart';
import 'package:koreanlms/widgets/button_widget.dart';
import 'package:koreanlms/widgets/user_info_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  void initState() {
    super.initState();
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    studentProvider.isLoading = true;
    studentProvider.getStudentData(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Consumer(
        builder: (BuildContext context, StudentProvider studentProvider,
                Widget? child) =>
            Column(
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
              height: screenHeight -
                  (AppBar().preferredSize.height * 2) -
                  (Platform.isIOS ? 92 : 70),
              width: screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Image.asset('assets/images/user.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    UserInfoCard(
                        hint: 'Full Name',
                        detail:
                            '${studentProvider.firstName} ${studentProvider.lastName}'),
                    UserInfoCard(
                        hint: 'Mobile Number',
                        detail: '${studentProvider.phoneNum}'),
                    UserInfoCard(
                        hint: 'Email', detail: '${studentProvider.email}'),
                    UserInfoCard(hint: 'NIC', detail: '${studentProvider.nic}'),
                    UserInfoCard(
                        hint: 'Batch', detail: '${studentProvider.batch}'),
                    UserInfoCard(
                        hint: 'Class',
                        detail: '${studentProvider.studentClass}'),
                    UserInfoCard(
                        hint: 'Payment', detail: '${studentProvider.payment}'),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        'Registed in ${studentProvider.registedDate}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('logedIn', false);

                        Navigator.pushNamedAndRemoveUntil(
                            context, '/loginsplash', (route) => false);
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
      ),
    );
  }
}
