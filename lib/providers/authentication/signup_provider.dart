import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koreanlms/models/student.dart';
import 'package:koreanlms/screens/authentication/otp_screen/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUPProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;

  TextEditingController brithdayController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String selectedDate = '';
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  bool loading = false;

  Future<void> selectBirthDay(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );

    if (picked != null && picked != DateTime.now()) {
      brithdayController.text = DateFormat.yMMMMd().format(picked);
      notifyListeners();
    }
  }

  selectCountry(BuildContext context) async {
    countryCode = await countryPicker.showPicker(
      pickerMinHeight: 30,
      context: context,
    );
    notifyListeners();
  }

  verifyPhoneNumber(String phone, BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException ex) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(ex.message.toString()),
            ),
          );
          print(ex.message.toString());
          loading = false;
          notifyListeners();
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                mobileNumber: (countryCode?.dialCode ?? '') +
                    (' ') +
                    phoneController.text,
                verificationID: verificationId,
              ),
            ),
          );
          loading = false;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: countryCode!.dialCode + phone,
      );
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  addStudentToFirebase(
      Student student, BuildContext context, String uID) async {
    try {
      db
          .collection("Students")
          .doc(uID)
          .set(student.toJson())
          .then((value) async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('logedIn', true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User Registration Success!"),
          ),
        );

        loading = false;
        Navigator.pushReplacementNamed(context, '/home');
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      notifyListeners();
    }
  }
}
