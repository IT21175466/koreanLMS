import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUPProvider extends ChangeNotifier {
  TextEditingController brithdayController = TextEditingController();
  String selectedDate = '';
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;

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
}
