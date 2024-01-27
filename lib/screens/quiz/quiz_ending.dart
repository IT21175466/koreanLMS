import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/widgets/button_widget.dart';
import 'package:koreanlms/widgets/outline_button.dart';

class QuizEnd extends StatefulWidget {
  const QuizEnd({super.key});

  @override
  State<QuizEnd> createState() => _QuizEndState();
}

class _QuizEndState extends State<QuizEnd> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: AppBar().preferredSize.height * 2 + 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppBar().preferredSize.height,
                  ),
                  Text(
                    'Quizzes',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    'Quiz Finished',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.grayColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: screenHeight - (AppBar().preferredSize.height * 2 + 10),
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/images/goodJob.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Good Job',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        width: 100,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue,
                        ),
                        child: Column(
                          children: [
                            Text(
                              '20',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Questions',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 100,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green,
                        ),
                        child: Column(
                          children: [
                            Text(
                              '15',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Correct',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 100,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red,
                        ),
                        child: Column(
                          children: [
                            Text(
                              '5',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Incorrect',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  Spacer(),
                  CustomOutlineButton(
                    text: 'Preview',
                    height: 50,
                    width: screenWidth,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: CustomButton(
                      text: 'Done',
                      height: 50,
                      width: screenWidth,
                      backgroundColor: Colors.green,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
