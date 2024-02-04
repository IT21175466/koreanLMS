import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/screens/home_screen/tabs/quiz_tab/history_section.dart';
import 'package:koreanlms/screens/home_screen/tabs/quiz_tab/quiz_section.dart';

class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Quizzes',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.lightGrayColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(
                      text: "Quizzes",
                    ),
                    Tab(
                      text: "History",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    QuizSection(),
                    HistorySection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
