import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/models/student.dart';
import 'package:koreanlms/providers/authentication/signup_provider.dart';
import 'package:koreanlms/widgets/button_widget.dart';
import 'package:koreanlms/widgets/phone_textfiled.dart';
import 'package:koreanlms/widgets/textfiled_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUPScreen extends StatefulWidget {
  const SignUPScreen({super.key});

  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? userID = '';

  getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getString('userID');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserID();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign UP',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        width: screenWidth,
        child: SingleChildScrollView(
          child: Consumer(
            builder: (BuildContext context, SignUPProvider signUPProvider,
                    Widget? child) =>
                Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset('assets/images/gPhotosLogo.png'),
                  ),
                ),
                CustomTextField(
                    controller: firstNameController, labelText: 'First Name'),
                CustomTextField(
                    controller: lastNameController, labelText: 'Last Name'),
                CustomTextField(
                    controller: emailController, labelText: 'Email'),
                CustomTextField(controller: nicController, labelText: 'NIC'),
                PhoneTextField(
                  controller: phoneController,
                  labelText: 'Phone Number',
                  hintText: "71XXXXXXX",
                  prefix: GestureDetector(
                    onTap: () async {
                      signUPProvider.selectCountry(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        signUPProvider.countryCode == null
                            ? '+1'
                            : '${signUPProvider.countryCode?.dialCode ?? '+1'}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 7),
                  height: 50,
                  child: TextField(
                    readOnly: true,
                    controller: signUPProvider.brithdayController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                        borderSide: const BorderSide(
                          color: AppColors.grayColor,
                          width: 0.5,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          signUPProvider.selectBirthDay(context);
                        },
                        child: Icon(Icons.calendar_month),
                      ),
                      labelText: "Date of birth*",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                GestureDetector(
                  onTap: () async {
                    if (firstNameController.text.isEmpty ||
                        lastNameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        nicController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        signUPProvider.brithdayController.text.isEmpty ||
                        signUPProvider.countryCode?.name == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            "Please enter all required details correctly!",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    } else {
                      // userProvider.userID =
                      //     userProvider.generateRandomId().toString();

                      String phoneNo =
                          "${signUPProvider.countryCode?.dialCode}" +
                              phoneController.text;
                      signUPProvider.loading = true;

                      final addStudent = Student(
                        userID: userID!,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        nic: nicController.text,
                        phoneNum: phoneNo,
                        date: DateFormat.yMMMMd()
                            .format(DateTime.now())
                            .toString(),
                        dateOfBirth: signUPProvider.brithdayController.text,
                        batch: 'no_batch',
                        studentClass: 'no_class',
                        payment: 'not_yet',
                      );
                      // User(
                      //   userID: userID!,
                      //   firstName: firstNameController.text,
                      //   lastName: lastNameController.text,
                      //   email: emailController.text,
                      //   province: provinceController.text,
                      //   district: districtController.text,
                      //   phoneNum: phoneNo,
                      //   date: DateTime.now(),
                      // );

                      signUPProvider.addStudentToFirebase(
                          addStudent, context, userID!);
                    }
                  },
                  child: CustomButton(
                    text: 'Continue',
                    height: 50,
                    width: screenWidth,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
