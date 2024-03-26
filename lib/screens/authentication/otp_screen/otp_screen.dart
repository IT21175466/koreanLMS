import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/providers/authentication/otp_provider.dart';
import 'package:koreanlms/widgets/button_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;
  final String verificationID;
  const OTPScreen(
      {super.key, required this.mobileNumber, required this.verificationID});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.manual,
  //     overlays: [
  //       SystemUiOverlay.top,
  //       SystemUiOverlay.bottom,
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Phone Verification',
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: screenWidth,
        height: screenHeight,
        child: Consumer(
          builder:
              (BuildContext context, OTPProvider otpProvider, Widget? child) =>
                  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "We have send an OTP to your number",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.mobileNumber,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                controller: otpController,
                length: 6,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.grayColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  if (otpController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please enter OTP"),
                      ),
                    );
                  } else {
                    otpProvider.loading = true;
                    otpProvider.getOTPCode(
                        widget.verificationID, otpController.text, context);
                  }
                },
                child: otpProvider.loading
                    ? Container(
                        height: 50,
                        width: screenWidth,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : CustomButton(
                        text: 'Verify',
                        height: 50,
                        width: screenWidth,
                        backgroundColor: Colors.green,
                      ),
              ),
              Spacer(),
              Spacer(),
              Spacer(),
              SizedBox(
                height: 70,
                width: 70,
                child: Image.asset('assets/images/icon.png'),
              ),
              SizedBox(
                height: Platform.isIOS ? 60 : 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
