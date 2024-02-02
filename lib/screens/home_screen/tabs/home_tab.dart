import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/providers/app_data/app_data_provider.dart';
import 'package:koreanlms/widgets/search_textfiled.dart';
import 'package:koreanlms/widgets/single_video_card.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController sampleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    appDataProvider.isLoading = true;
    appDataProvider.getImageData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: AppBar().preferredSize.height,
          ),
          Container(
            width: screenWidth,
            height: screenHeight / 5,
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, User',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          'Unlock Your Learning Potential Today!',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.grayColor,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.person,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SearchTextField(
                    controller: sampleController, labelText: "Search"),
              ],
            ),
          ),
          Container(
            width: screenWidth,
            height: screenHeight / 5 * 4 - (AppBar().preferredSize.height + 60),
            //padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1st Payment',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  VideoCard(
                    isAccepted: false,
                    isWatched: false,
                    title: 'Language Basics',
                    teacher: 'Mr.Frenando',
                  ),
                  VideoCard(
                    isAccepted: false,
                    isWatched: false,
                    title: 'Language Basics II',
                    teacher: 'Mr.Frenando',
                  ),
                  SizedBox(
                    height: 10,
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
