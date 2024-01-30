import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:koreanlms/providers/mobile_validation/phone_validation_provider.dart';
import 'package:koreanlms/screens/authentication/otp_screen/otp_screen.dart';
import 'package:koreanlms/widgets/button_widget.dart';
import 'package:koreanlms/widgets/phone_textfiled.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  final images = [
    'https://firebasestorage.googleapis.com/v0/b/koreanlms-f3ced.appspot.com/o/feature-what-is-ppc.png?alt=media&token=dd8197e0-26c1-49bc-bc03-2fe6b45f7edb',
    'https://firebasestorage.googleapis.com/v0/b/koreanlms-f3ced.appspot.com/o/cocacola-ads-example-with-orange-background-slogan.png?alt=media&token=16a3a6b0-a434-4e87-b224-f6fb08ae655b',
    'https://firebasestorage.googleapis.com/v0/b/koreanlms-f3ced.appspot.com/o/advertisement.png?alt=media&token=1cd5f3d7-bd5f-4c23-9b4b-864b0730e2fe',
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Korean LMS',
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
        padding: EdgeInsets.symmetric(vertical: 10),
        width: screenWidth,
        child: Consumer(
          builder: (BuildContext context, PhoneValidationProvider phoneProvider,
                  Widget? child) =>
              Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: CarouselSlider(
                  items: images
                      .map(
                        (image) => Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 241, 240, 240),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      'Enter Your Mobile Number',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "We'll send you a verification code.",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PhoneTextField(
                      controller: phoneController,
                      labelText: 'Phone Number',
                      hintText: "71XXXXXXX",
                      prefix: GestureDetector(
                        onTap: () async {
                          phoneProvider.selectCountry(context);
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
                            phoneProvider.countryCode == null
                                ? '+1'
                                : '${phoneProvider.countryCode?.dialCode ?? '+1'}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPScreen(
                              mobileNumber:
                                  (phoneProvider.countryCode?.dialCode ?? '') +
                                      (' ') +
                                      phoneController.text,
                            ),
                          ),
                        );
                      },
                      child: CustomButton(
                        text: 'Next',
                        height: 50,
                        width: screenWidth,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
