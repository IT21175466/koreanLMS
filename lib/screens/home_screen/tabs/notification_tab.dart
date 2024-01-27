import 'package:flutter/material.dart';
import 'package:koreanlms/widgets/notification_card.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({super.key});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
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
                  'Notifications',
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
                children: [
                  NotificationCard(),
                  NotificationCard(),
                  NotificationCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}