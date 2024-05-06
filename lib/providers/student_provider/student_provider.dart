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
  String? registedDate = '...';
  String? deviceID = '...';

  List<String> myBatches = [];
  List<String> myClasses = [];
  List<String> myTerms = [];

  Future<void> getStudentBaches() async {
    await getStudentID();

    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection("New_Students")
          .doc(studentID)
          .get();

      if (documentSnapshot.exists) {
        final List<dynamic> batchData = documentSnapshot.data()!['Batches'];

        // Clear existing data in completedLessons list
        myBatches.clear();

        // Iterate through lessonsData and add them to completedLessons
        for (dynamic batchData in batchData) {
          myBatches.add(batchData
              .toString()); // Assuming lessonData is a String or can be converted to String
          print(batchData.toString());
        }

        if (documentSnapshot.exists) {
          final List<dynamic> classData = documentSnapshot.data()!['Classes'];

          // Clear existing data in completedLessons list
          myClasses.clear();

          // Iterate through lessonsData and add them to completedLessons
          for (dynamic classData in classData) {
            myClasses.add(classData
                .toString()); // Assuming lessonData is a String or can be converted to String
            print(classData.toString());
          }
        }

        if (documentSnapshot.exists) {
          final List<dynamic> termData = documentSnapshot.data()!['Terms'];

          // Clear existing data in completedLessons list
          myTerms.clear();

          // Iterate through lessonsData and add them to completedLessons
          for (dynamic termData in termData) {
            myTerms.add(termData
                .toString()); // Assuming lessonData is a String or can be converted to String
            print(termData.toString());
          }
        }

        notifyListeners();
        print('Fetched successfully.');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  getStudentID() async {
    final prefs = await SharedPreferences.getInstance();

    studentID = prefs.getString('userID');
    notifyListeners();
  }

  getStudentIDToHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      studentID = prefs.getString('userID');
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  getStudentData(BuildContext context) async {
    try {
      await getStudentID();

      final DocumentSnapshot studentDoc = await FirebaseFirestore.instance
          .collection("New_Students")
          .doc(studentID)
          .get();

      firstName = studentDoc.get('FirstName');
      lastName = studentDoc.get('LastName');
      email = studentDoc.get('Email');
      nic = studentDoc.get('NIC');
      phoneNum = studentDoc.get('PhoneNumber');
      dateOfBirth = studentDoc.get('DateOfBirth');
      registedDate = studentDoc.get('Registed_Date');
      deviceID = studentDoc.get('Device_ID');

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  getDeviceData(BuildContext context) async {
    try {
      await getStudentID();

      final DocumentSnapshot<Map<String, dynamic>> studentDoc =
          await FirebaseFirestore.instance
              .collection("New_Students")
              .doc(studentID)
              .get();

      // final DocumentSnapshot studentDoc = await FirebaseFirestore.instance
      //     .collection("Students")
      //     .doc(studentID)
      //     .get();

      // deviceID = studentDoc.get('Device_ID');

      if (studentDoc.exists) {
        Map<String, dynamic>? data = studentDoc.data();
        if (data != null && data.containsKey('Device_ID')) {
          deviceID = data['Device_ID'];
          notifyListeners();
        } else {
          deviceID = 'not';
          notifyListeners();
        }
      } else {
        print('Document does not exist');
        deviceID = 'not';
        notifyListeners();
      }
    } catch (e) {
      print(e);
    } finally {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
