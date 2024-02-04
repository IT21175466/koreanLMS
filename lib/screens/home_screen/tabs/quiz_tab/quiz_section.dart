import 'package:flutter/material.dart';
import 'package:koreanlms/providers/quiz/quiz_provider.dart';
import 'package:koreanlms/widgets/quiz_card.dart';
import 'package:provider/provider.dart';

class QuizSection extends StatefulWidget {
  const QuizSection({super.key});

  @override
  State<QuizSection> createState() => _QuizSectionState();
}

class _QuizSectionState extends State<QuizSection> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer(
        builder:
            (BuildContext context, QuizProvider quizProvider, Widget? child) =>
                Container(
          width: screenWidth,
          height: screenHeight,
          child: quizProvider.noBatch
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset('assets/images/admin.png'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Please Contact Admin',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        //Navigator.pushNamed(context, '/quiz');
                      },
                      child: QuizCard(),
                    ),
                    QuizCard(),
                    QuizCard(),
                    QuizCard(),
                    QuizCard(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
