import 'package:flutter/material.dart';
import 'package:koreanlms/providers/quiz/quiz_provider.dart';
import 'package:koreanlms/screens/quiz/singleQuestion_preview.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class QuizPreviewScreen extends StatefulWidget {
  final String sID;
  final String marks;
  final String name;
  const QuizPreviewScreen(
      {super.key, required this.sID, required this.marks, required this.name});

  @override
  State<QuizPreviewScreen> createState() => _QuizPreviewScreenState();
}

class _QuizPreviewScreenState extends State<QuizPreviewScreen> {
  String generateRandomId() {
    var uuid = Uuid();
    return uuid.v4();
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
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.all(20),
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
                questionVideo: quizProvider.quizzes[index].questionVideoLink,
                questionImage: quizProvider.quizzes[index].questionImage,
                answer1Image: quizProvider.quizzes[index].answer1Image,
                answer2Image: quizProvider.quizzes[index].answer2Image,
                answer3Image: quizProvider.quizzes[index].answer3Image,
                answer4Image: quizProvider.quizzes[index].answer4Image,
                answer5Image: quizProvider.quizzes[index].answer5Image,
                answer1Video: quizProvider.quizzes[index].answer1VideoLink,
                answer2Video: quizProvider.quizzes[index].answer2VideoLink,
                answer3Video: quizProvider.quizzes[index].answer3VideoLink,
                answer4Video: quizProvider.quizzes[index].answer4VideoLink,
                answer5Video: quizProvider.quizzes[index].answer5VideoLink,
                correctAnswer: quizProvider.quizzes[index].correctAnswer,
                indexOfQuiz: quizProvider.quizzes[index].toString(),
                userSelected: userSelectedAnser,
              );
            },
          ),
        ),
      ),
    );
  }
}
