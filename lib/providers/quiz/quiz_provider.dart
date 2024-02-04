import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koreanlms/models/quiz.dart';

class QuizProvider extends ChangeNotifier {
  bool noBatch = false;
  bool paymentDone = false;

  String batch = '';
  String sClass = '';
  String payment = '';
  bool isLoading = false;

  List<Quiz> quizzes = [];

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
          getQuizzes();
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

  Future<void> getQuizzes() async {
    try {
      final QuerySnapshot quizQuerySnapshot = await FirebaseFirestore.instance
          .collection("Batches")
          .doc(batch)
          .collection("Classes")
          .doc(sClass)
          .collection("Papers")
          .get();

      for (QueryDocumentSnapshot quizDoc in quizQuerySnapshot.docs) {
        String quizID = quizDoc['QuizID'];
        String question = quizDoc['Question'];
        String paymentTerm = quizDoc['Payment_term'];
        String answers = quizDoc['Answers'];

        Quiz quiz = Quiz(
          quizID: quizID,
          question: question,
          answers: answers,
          paymentTerm: paymentTerm,
        );

        quizzes.add(quiz);
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
