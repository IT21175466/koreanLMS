import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/providers/quiz/quiz_provider.dart';
import 'package:koreanlms/widgets/button_widget.dart';
import 'package:koreanlms/widgets/outline_button.dart';
import 'package:koreanlms/widgets/singleQuestion.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatefulWidget {
  final String quizName;
  const QuestionScreen({
    super.key,
    required this.quizName,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );
    super.initState();
  }

  int index = 0;

  void goToNextQuestion() {
    setState(() {
      index++;
    });
  }

  void goToPrevousQuestion() {
    setState(() {
      index--;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(
      builder:
          (BuildContext context, QuizProvider quizProvider, Widget? child) =>
              Scaffold(
        body: Container(
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
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.quizName,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Question ${index + 1} / ${quizProvider.quizzes.length}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: AppColors.grayColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (Platform.isIOS) {
                              showCupertinoDialog(
                                context: context,
                                builder: (ctx) => CupertinoAlertDialog(
                                  title: Text(
                                    "Alert",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: Text(
                                    "Do you want to exit in exam?",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text(
                                    "Alert",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: Text(
                                    "Do you want to exit in exam?",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(ctx).pop();
                                        Navigator.of(ctx).pop();
                                        quizProvider.quizzes = await [];
                                      },
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: Icon(
                            Icons.exit_to_app_outlined,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight - (AppBar().preferredSize.height * 2),
                width: screenWidth,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleQuestion(
                        question: quizProvider.quizzes[index].question,
                        answer1: quizProvider.quizzes[index].answer1,
                        answer2: quizProvider.quizzes[index].answer2,
                        answer3: quizProvider.quizzes[index].answer3,
                        answer4: quizProvider.quizzes[index].answer4,
                        answer5: quizProvider.quizzes[index].answer5,
                        isSample: quizProvider.quizzes[index].isSample,
                        isBackEnable: quizProvider.quizzes[index].isBackEnable,
                        questionVideo:
                            quizProvider.quizzes[index].questionVideo,
                        questionImage:
                            quizProvider.quizzes[index].questionImage,
                        answer1Image: quizProvider.quizzes[index].answer1Image,
                        answer2Image: quizProvider.quizzes[index].answer2Image,
                        answer3Image: quizProvider.quizzes[index].answer3Image,
                        answer4Image: quizProvider.quizzes[index].answer4Image,
                        answer5Image: quizProvider.quizzes[index].answer5Image,
                        answer1Video: quizProvider.quizzes[index].answer1Video,
                        answer2Video: quizProvider.quizzes[index].answer2Video,
                        answer3Video: quizProvider.quizzes[index].answer3Video,
                        answer4Video: quizProvider.quizzes[index].answer4Video,
                        answer5Video: quizProvider.quizzes[index].answer5Video,
                      ),
                      Row(
                        children: [
                          quizProvider.quizzes[index].isBackEnable
                              ? GestureDetector(
                                  onTap: () {
                                    goToPrevousQuestion();
                                  },
                                  child: CustomOutlineButton(
                                    text: 'Previous',
                                    height: 45,
                                    width: screenWidth / 2 - 20,
                                    borderColor: Colors.green,
                                    textColor: Colors.green,
                                  ),
                                )
                              : SizedBox(
                                  height: 45,
                                  width: screenWidth / 2 - 20,
                                ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              goToNextQuestion();
                            },
                            child: CustomButton(
                              text: 'Next',
                              height: 45,
                              width: screenWidth / 2 - 20,
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Platform.isIOS ? 60 : 30,
                      ),
                    ],
                  ),
                ),
                // VideoCard(
                //   isAccepted: videoProvider.payment ==
                //           video.paymentTerm
                //       ? true
                //       : false,
                //   isWatched: false,
                //   teacher: video.teacher,
                //   title: video.title,
                // );
              ),
            ],
          ),
        ),
      ),
    );
  }
}
