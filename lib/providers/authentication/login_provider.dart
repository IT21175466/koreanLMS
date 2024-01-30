import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String vehicleType = '';

  checkUserIsSignUp(String userID, BuildContext context) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      //Users
      DocumentReference documentRefUsers =
          firestore.collection("Users").doc(userID);

      DocumentSnapshot docSnapshotUsers = await documentRefUsers.get();

      if (docSnapshotUsers.exists) {
        print("User document exists");
        Navigator.pushReplacementNamed(context, '/home');
        notifyListeners();
      } else {
        print("Any document does not exist");
        Navigator.pushReplacementNamed(context, '/signup');
        notifyListeners();
      }
    } catch (error) {
      print("Error checking document: $error");
    }
  }
}
