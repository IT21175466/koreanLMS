import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoProvider extends ChangeNotifier {
  bool noBatch = false;
  bool paymentDone = false;
  String batch = '';
  String sClass = '';
  String payment = '';
  bool isLoading = false;

  List<String> videoDocumentIDs = [];

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
          getVideos();
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

  Future<List<String>> getVideos() async {
    try {
      print('Want to get video document IDs');
      final QuerySnapshot videoQuerySnapshot = await FirebaseFirestore.instance
          .collection("Batches")
          .doc(batch)
          .collection("Classes")
          .doc(sClass)
          .collection('Payments')
          .doc(payment)
          .collection("Videos")
          .get();

      for (QueryDocumentSnapshot videoDoc in videoQuerySnapshot.docs) {
        String videoDocumentID = videoDoc.id;
        videoDocumentIDs.add(videoDocumentID);
        notifyListeners();
      }
      print(videoDocumentIDs);
    } catch (e) {
      print(e);
    }

    return videoDocumentIDs;
  }
}
