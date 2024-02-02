import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProvider extends ChangeNotifier {
  String? studentID = '';
  bool isLoading = false;

  //Student
  String firstName = '...';
  String? lastName = '...';
  String? email = '...';
  String? nic = '...';
  String? phoneNum = '...';
  String? dateOfBirth = '...';
  String? batch = '...';
  String? studentClass = '...';
  String? registedDate = '...';

  getStudentID() async {
    final prefs = await SharedPreferences.getInstance();

    studentID = prefs.getString('userID');
    notifyListeners();
  }

  getStudentData(BuildContext context) async {
    try {
      await getStudentID();

      final DocumentSnapshot studentDoc = await FirebaseFirestore.instance
          .collection("Students")
          .doc(studentID)
          .get();

      firstName = studentDoc.get('FirstName');
      lastName = studentDoc.get('LastName');
      email = studentDoc.get('Email');
      nic = studentDoc.get('NIC');
      phoneNum = studentDoc.get('PhoneNumber');
      dateOfBirth = studentDoc.get('DateOfBirth');
      batch = studentDoc.get('Batch');
      studentClass = studentDoc.get('Student_Class');
      registedDate = studentDoc.get('Registed_Date');

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }
}
