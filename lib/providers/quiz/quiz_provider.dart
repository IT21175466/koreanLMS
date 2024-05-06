import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koreanlms/models/answer.dart';
import 'package:koreanlms/models/history_quiz.dart';
import 'package:koreanlms/models/paper.dart';
import 'package:koreanlms/models/quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;

  bool noBatch = false;
  bool paymentDone = false;
  bool noPapers = false;

  String batch = '';
  String sClass = '';
  String payment = '';
  bool isLoading = false;

  List<Quiz> quizzes = [];
  List<Paper> papers = [];
  List<Answer> answers = [];

  List<String> selectedAnswers = [];

  String? studentID = '';

  bool isSelected = false;

  String coorectAnswer = '';
  String selectedAnswer = '';

  bool loading = false;

  bool timerDone = false;

  getStudentID() async {
    final prefs = await SharedPreferences.getInstance();

    studentID = prefs.getString('userID');
    notifyListeners();
  }

  Future<void> getQuizzes(
      String paName, String aBatch, String aClass, String aTerm) async {
    try {
      final QuerySnapshot quizQuerySnapshot = await FirebaseFirestore.instance
          .collection('New_Batches')
          .doc(aBatch)
          .collection("Classes")
          .doc(aClass)
          .collection("Terms")
          .doc(aTerm)
          .collection("Papers")
          .doc(paName)
          .collection("Questions")
          .get();

      for (QueryDocumentSnapshot quizDoc in quizQuerySnapshot.docs) {
        Map<String, dynamic> data = quizDoc.data() as Map<String, dynamic>;

        String quizNumber = quizDoc['QuestionNo'];
        String question = quizDoc['Question'];
        String answer1 = quizDoc['Answer1'];
        String answer2 = quizDoc['Answer2'];
        String answer3 = quizDoc['Answer3'];
        String answer4 = quizDoc['Answer4'];
        String correctAnswer = quizDoc['CorrectAnswer'];
        int timer;

        if (data.containsKey('Timer')) {
          timer = quizDoc['Timer'];
        } else {
          timer = 0;
        }

        String answer5 = '';

        if (data.containsKey('Answer5')) {
          answer5 = quizDoc['Answer5'];
        } else {
          answer5 = '';
        }

        bool isSample = quizDoc['Is_Sample'];
        bool isBackEnable = quizDoc['Is_BackEnable'];
        String questionVideo = '';

        if (data.containsKey('Question_VideoLink')) {
          questionVideo = quizDoc['Question_VideoLink'];
        } else {
          questionVideo = '';
        }

        String questionImage = '';

        if (data.containsKey('Question_Image')) {
          questionImage = quizDoc['Question_Image'];
        } else {
          questionImage = '';
        }

        String answer1Image = '';

        if (data.containsKey('Answer1_Image')) {
          answer1Image = quizDoc['Answer1_Image'];
        } else {
          answer1Image = '';
        }

        String answer2Image = '';

        if (data.containsKey('Answer2_Image')) {
          answer2Image = quizDoc['Answer2_Image'];
        } else {
          answer2Image = '';
        }

        String answer3Image = '';

        if (data.containsKey('Answer3_Image')) {
          answer3Image = quizDoc['Answer3_Image'];
        } else {
          answer3Image = '';
        }

        String answer4Image = '';

        if (data.containsKey('Answer4_Image')) {
          answer4Image = quizDoc['Answer4_Image'];
        } else {
          answer4Image = '';
        }

        String answer5Image = '';

        if (data.containsKey('Answer5_Image')) {
          answer5Image = quizDoc['Answer5_Image'];
        } else {
          answer5Image = '';
        }

        String answer1Video = '';

        if (data.containsKey('Answer1_VideoLink')) {
          answer1Video = quizDoc['Answer1_VideoLink'];
        } else {
          answer1Video = '';
        }

        String answer2Video = '';

        if (data.containsKey('Answer2_VideoLink')) {
          answer2Video = quizDoc['Answer2_VideoLink'];
        } else {
          answer2Video = '';
        }

        String answer3Video = '';

        if (data.containsKey('Answer3_VideoLink')) {
          answer3Video = quizDoc['Answer3_VideoLink'];
        } else {
          answer3Video = '';
        }

        String answer4Video = '';

        if (data.containsKey('Answer4_VideoLink')) {
          answer4Video = quizDoc['Answer4_VideoLink'];
        } else {
          answer4Video = '';
        }

        String answer5Video = '';

        if (data.containsKey('Answer5_VideoLink')) {
          answer5Video = quizDoc['Answer5_VideoLink'];
        } else {
          answer5Video = '';
        }

        Quiz quiz = Quiz(
          questionNumber: quizNumber,
          question: question,
          answer1: answer1,
          answer2: answer2,
          answer3: answer3,
          answer4: answer4,
          answer5: answer5,
          correctAnswer: correctAnswer,
          questionImage: questionImage,
          answer1Image: answer1Image,
          answer2Image: answer2Image,
          answer3Image: answer3Image,
          answer4Image: answer4Image,
          answer5Image: answer5Image,
          questionVideoLink: questionVideo,
          answer1VideoLink: answer1Video,
          answer2VideoLink: answer2Video,
          answer3VideoLink: answer3Video,
          answer4VideoLink: answer4Video,
          answer5VideoLink: answer5Video,
          isSample: isSample,
          isBackEnable: isBackEnable,
          timer: timer,
        );

        quizzes.add(quiz);
        notifyListeners();
      }
      print(quizzes);
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }
  }

  void addQuizToFirebase(
      HistoryQuiz historyQuiz, BuildContext context, String s) async {
    await getStudentID();

    await FirebaseFirestore.instance
        .collection("New_History")
        .doc(studentID)
        .collection("Papers")
        .doc()
        .set(historyQuiz.toJson())
        .then((value) => {loading = false});
  }
}
