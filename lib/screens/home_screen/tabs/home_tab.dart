import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/global/variables.dart';
import 'package:koreanlms/models/video.dart';
import 'package:koreanlms/providers/app_data/app_data_provider.dart';
import 'package:koreanlms/providers/authentication/login_provider.dart';
import 'package:koreanlms/providers/quiz/quiz_provider.dart';
import 'package:koreanlms/providers/video/video_provider.dart';
import 'package:koreanlms/screens/video/video_verification.dart';
import 'package:koreanlms/widgets/search_textfiled.dart';
import 'package:koreanlms/widgets/single_video_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController sampleController = TextEditingController();

  String? studentID = '';

  var videoProvider = VideoProvider();
  var quizProvider = QuizProvider();

  String phone = '';

  bool isLoading = false;
  bool isSucess = false;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );
    super.initState();
    getStudentID();
    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    appDataProvider.isLoading = true;
    appDataProvider.getImageData();

    videoProvider = Provider.of<VideoProvider>(context, listen: false);
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
    // final notificationProvider =
    //     Provider.of<NotificationProvider>(context, listen: false);
    // notificationProvider.listnToNotifications();
  }

  getStudentID() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      studentID = prefs.getString('userID');
      globleStudentID = prefs.getString('userID');
    });

    videoProvider.checkUserInBatch(studentID!);
    quizProvider.checkUserInBatch(studentID!);
  }

  String generateRandomCode() {
    Random random = Random();
    int code = random.nextInt(900000) + 100000;
    return code.toString();
  }

  Future<void> sendVerificationCode({
    String? phone,
    String? code,
  }) async {
    String Url =
        'http://send.ozonedesk.com/api/v2/send.php?user_id=105281&api_key=evj05adndinxxahxh&sender_id=ozoneDEMO&to=${phone}&message=Your video verification code is ${code}';

    try {
      setState(() {
        isLoading = true;
      });
      var response = await http.get(
        Uri.parse(Url),
      );
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          isSucess = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Verification Code Sent',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please try again later!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Consumer2(
            builder: (BuildContext context, VideoProvider videoProvider,
                    LoginProvider loginProvider, Widget? child) =>
                Column(
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight / 6,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, ${loginProvider.userName}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                'Unlock Your Learning Potential Today!',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: AppColors.grayColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(
                            Icons.person,
                            size: 30,
                          ),
                        ],
                      ),
                      Spacer(),
                      SearchTextField(
                          controller: sampleController, labelText: "Search"),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight / 6 * 5 -
                      (AppBar().preferredSize.height +
                          (Platform.isIOS ? 92 : 70)),
                  //padding: EdgeInsets.symmetric(horizontal: 10),
                  child: videoProvider.noBatch
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: Image.asset('assets/images/admin.png'),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Please Contact Admin',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Spacer(),
                          ],
                        )
                      : videoProvider.paymentDone
                          ? ListView.builder(
                              itemCount: videoProvider.videos.length,
                              itemBuilder: (context, index) {
                                Video video = videoProvider.videos[index];
                                return GestureDetector(
                                  onTap: () async {
                                    if (videoProvider.payment ==
                                        video.paymentTerm) {
                                      String verificationCode =
                                          await generateRandomCode();

                                      await sendVerificationCode(
                                        phone: loginProvider.phoneNumber,
                                        code: verificationCode,
                                      );

                                      if (isSucess = true) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VideoVerificationScreen(
                                              msgCode: verificationCode,
                                              link: video.link,
                                              title: video.title,
                                              teacher: video.teacher,
                                              zoomLink: video.zoomLink,
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Make payment and try again!',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    }
                                  },
                                  child: VideoCard(
                                    isAccepted: videoProvider.payment ==
                                            video.paymentTerm
                                        ? true
                                        : false,
                                    isWatched: false,
                                    teacher: video.teacher,
                                    title: video.title,
                                  ),
                                );
                              },
                            )
                          : Column(
                              children: [
                                VideoCard(
                                  isAccepted: false,
                                  isWatched: false,
                                  title: 'Language Basics',
                                  teacher: 'Mr.Frenando',
                                ),
                                VideoCard(
                                  isAccepted: false,
                                  isWatched: false,
                                  title: 'Language Basics II',
                                  teacher: 'Mr.Frenando',
                                ),
                              ],
                            ),
                ),
              ],
            ),
          ),
        ),
        isLoading
            ? Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.75),
                    //borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            : SizedBox(),
        isLoading
            ? Positioned(
                top: screenHeight / 2 - 60,
                left: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Please Wait...."),
                    ],
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
