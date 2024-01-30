import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koreanlms/screens/authentication/otp_screen/otp_screen.dart';

class SignUPProvider extends ChangeNotifier {
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
}
