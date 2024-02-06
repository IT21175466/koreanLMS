import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koreanlms/models/paper.dart';
import 'package:koreanlms/models/quiz.dart';

class QuizProvider extends ChangeNotifier {
  bool noBatch = false;
  bool paymentDone = false;
  bool noPapers = false;

  String batch = '';
  String sClass = '';
  String payment = '';
  bool isLoading = false;

  List<Quiz> quizzes = [];
  List<Paper> papers = [];

  bool isSelected = false;

  String coorectAnswer = '';
  String selectedAnswer = '';

  checkUserInBatch(String sID) async {
    try {
      final DocumentSnapshot studentDoc = await FirebaseFirestore.instance
          .collection("Students")
          .doc(sID)
          .get();

      //Get All Data
      batch = studentDoc.get('Batch');
      sClass = studentDoc.get('Student_Class');
      payment = studentDoc.get('Payment');

      print(batch);
      print(sClass);
      print(payment);

      //Check Batch
      if (batch == 'no_batch' || sClass == 'no_class') {
        noBatch = true;
        notifyListeners();
      } else {
        noBatch = false;
        notifyListeners();

        //Check Payment
        if (payment == 'not_yet') {
          paymentDone = false;
          print('Not yet payment');
          notifyListeners();
        } else {
          //getQuizzes();
          getPapers();
          paymentDone = true;
          notifyListeners();
        }
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      // isLoading = false;
      // notifyListeners();
    }
  }

  Future<void> getPapers() async {
    FirebaseFirestore.instance
        .collection("Batches")
        .doc(batch)
        .collection("Classes")
        .doc(sClass)
        .collection("Papers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        noPapers = true;
        notifyListeners();
      } else {
        noPapers = false;
        querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          String documentId = documentSnapshot.id;
          Paper paper = Paper(
            paperName: documentId,
          );
          papers.add(paper);
          notifyListeners();
        });
      }
    });
  }

  Future<void> getQuizzes(String quizName) async {
    try {
      final QuerySnapshot quizQuerySnapshot = await FirebaseFirestore.instance
          .collection("Batches")
          .doc(batch)
          .collection("Classes")
          .doc(sClass)
          .collection("Papers")
          .doc(quizName)
          .collection("Questions")
          .get();

      for (QueryDocumentSnapshot quizDoc in quizQuerySnapshot.docs) {
        Map<String, dynamic> data = quizDoc.data() as Map<String, dynamic>;

        //String quizID = quizDoc['QuizID'];
        String question = quizDoc['Question'];
        //String paymentTerm = quizDoc['Payment_term'];
        String answer1 = quizDoc['Answer1'];
        String answer2 = quizDoc['Answer2'];
        String answer3 = quizDoc['Answer3'];
        String answer4 = quizDoc['Answer4'];
        String correctAnswer = quizDoc['CorrectAnswer'];
        String answer5 = '';

        if (data.containsKey('Answer5')) {
          answer5 = quizDoc['Answer5'];
        } else {
          answer5 = '';
        }

        bool isSample = quizDoc['isSample'];
        bool isBackEnable = quizDoc['isBackEnable'];
        String questionVideo = '';

        if (data.containsKey('questionVideo')) {
          questionVideo = quizDoc['questionVideo'];
        } else {
          questionVideo = '';
        }

        String questionImage = '';

        if (data.containsKey('questionImage')) {
          questionImage = quizDoc['questionImage'];
        } else {
          questionImage = '';
        }

        String answer1Image = '';

        if (data.containsKey('answer1Image')) {
          answer1Image = quizDoc['answer1Image'];
        } else {
          answer1Image = '';
        }

        String answer2Image = '';

        if (data.containsKey('answer2Image')) {
          answer2Image = quizDoc['answer2Image'];
        } else {
          answer2Image = '';
        }

        String answer3Image = '';

        if (data.containsKey('answer3Image')) {
          answer3Image = quizDoc['answer3Image'];
        } else {
          answer3Image = '';
        }

        String answer4Image = '';

        if (data.containsKey('answer4Image')) {
          answer4Image = quizDoc['answer4Image'];
        } else {
          answer4Image = '';
        }

        String answer5Image = '';

        if (data.containsKey('answer5Image')) {
          answer5Image = quizDoc['answer5Image'];
        } else {
          answer5Image = '';
        }

        String answer1Video = '';

        if (data.containsKey('answer1Video')) {
          answer1Video = quizDoc['answer1Video'];
        } else {
          answer1Video = '';
        }

        String answer2Video = '';

        if (data.containsKey('answer2Video')) {
          answer2Video = quizDoc['answer2Video'];
        } else {
          answer2Video = '';
        }

        String answer3Video = '';

        if (data.containsKey('answer3Video')) {
          answer3Video = quizDoc['answer3Video'];
        } else {
          answer3Video = '';
        }

        String answer4Video = '';

        if (data.containsKey('answer4Video')) {
          answer4Video = quizDoc['answer4Video'];
        } else {
          answer4Video = '';
        }

        String answer5Video = '';

        if (data.containsKey('answer5Video')) {
          answer5Video = quizDoc['answer5Video'];
        } else {
          answer5Video = '';
        }

        //String quizAmount = quizDoc['quizAmount'];

        Quiz quiz = Quiz(
          //quizID: quizID,
          question: question,
          answer1: answer1,
          answer2: answer2,
          answer3: answer3,
          answer4: answer4,
          answer5: answer5,
          //paymentTerm: paymentTerm,
          isSample: isSample,
          isBackEnable: isBackEnable,
          questionVideo: questionVideo,
          questionImage: questionImage,
          answer1Image: answer1Image,
          answer2Image: answer2Image,
          answer3Image: answer3Image,
          answer4Image: answer4Image,
          answer5Image: answer5Image,
          answer1Video: answer1Video,
          answer2Video: answer2Video,
          answer3Video: answer3Video,
          answer4Video: answer4Video,
          answer5Video: answer5Video, correctAnswer: correctAnswer,
          //quizAmount: quizAmount,
        );

        quizzes.add(quiz);
        notifyListeners();
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
