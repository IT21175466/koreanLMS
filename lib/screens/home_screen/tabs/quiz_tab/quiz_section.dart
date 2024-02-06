import 'package:flutter/material.dart';
import 'package:koreanlms/models/paper.dart';
import 'package:koreanlms/providers/quiz/quiz_provider.dart';
import 'package:koreanlms/screens/quiz/question_screen.dart';
import 'package:koreanlms/widgets/quiz_card.dart';
import 'package:provider/provider.dart';

class QuizSection extends StatefulWidget {
  const QuizSection({super.key});

  @override
  State<QuizSection> createState() => _QuizSectionState();
}

class _QuizSectionState extends State<QuizSection> {
  @override
  void initState() {
    super.initState();
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizProvider.quizzes = [];
  }

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
              : quizProvider.noBatch == false &&
                      quizProvider.payment == "not_yet"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text(
                          'Payment Required',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                      ],
                    )
                  : quizProvider.noPapers
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),
                            Text(
                              'No papers yet!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Spacer(),
                          ],
                        )
                      : ListView.builder(
                          itemCount: quizProvider.papers.length,
                          itemBuilder: (context, index) {
                            Paper paper = quizProvider.papers[index];
                            return quizProvider.papers.isEmpty
                                ? Center(
                                    child: Text(
                                      'No Quizzes yet!',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      await quizProvider
                                          .getQuizzes(paper.paperName);
                                      quizProvider.isSelected = false;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QuestionScreen(
                                              quizName: paper.paperName),
                                        ),
                                      );
                                      print(paper.paperName);
                                    },
                                    child: QuizCard(
                                      title: paper.paperName,
                                    ),
                                  );
                          },
                        ),
        ),
      ),
    );
  }
}
