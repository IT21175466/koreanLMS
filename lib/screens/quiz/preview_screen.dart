import 'package:flutter/material.dart';
import 'package:koreanlms/providers/quiz/quiz_provider.dart';
import 'package:koreanlms/screens/home_screen/home_screen.dart';
import 'package:koreanlms/screens/quiz/singleQuestion_preview.dart';
import 'package:koreanlms/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class QuizPreviewScreen extends StatefulWidget {
  const QuizPreviewScreen({super.key});

  @override
  State<QuizPreviewScreen> createState() => _QuizPreviewScreenState();
}

class _QuizPreviewScreenState extends State<QuizPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer(
        builder:
            (BuildContext context, QuizProvider quizProvider, Widget? child) =>
                Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: quizProvider.quizzes.length,
                  itemBuilder: (context, index) {
                    final String userSelectedAnser =
                        quizProvider.answers[index].selectedAnswer;
                    return SingleQuestionToPreview(
                      question: quizProvider.quizzes[index].question,
                      answer1: quizProvider.quizzes[index].answer1,
                      answer2: quizProvider.quizzes[index].answer2,
                      answer3: quizProvider.quizzes[index].answer3,
                      answer4: quizProvider.quizzes[index].answer4,
                      answer5: quizProvider.quizzes[index].answer5,
                      questionVideo: quizProvider.quizzes[index].questionVideo,
                      questionImage: quizProvider.quizzes[index].questionImage,
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
                      correctAnswer: quizProvider.quizzes[index].correctAnswer,
                      indexOfQuiz: quizProvider.quizzes[index].toString(),
                      userSelected: userSelectedAnser,
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    quizProvider.answers = [];
                    quizProvider.quizzes = [];
                    quizProvider.isSelected = false;
                    quizProvider.correctAnswers = 0;
                    quizProvider.wrongAnswers = 0;
                    quizProvider.coorectAnswer = '';
                    quizProvider.selectedAnswer = '';
                    quizProvider.papers = [];

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false);
                  });
                },
                child: CustomButton(
                  text: 'Done',
                  height: 50,
                  width: screenWidth,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
