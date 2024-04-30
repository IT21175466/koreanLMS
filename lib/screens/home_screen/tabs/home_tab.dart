import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/global/variables.dart';
import 'package:koreanlms/providers/app_data/app_data_provider.dart';
import 'package:koreanlms/providers/authentication/login_provider.dart';
import 'package:koreanlms/providers/quiz/quiz_provider.dart';
import 'package:koreanlms/providers/video/video_provider.dart';
import 'package:koreanlms/widgets/play_video_sample.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController searchController = TextEditingController();

  String? studentID = '';

  var videoProvider = VideoProvider();
  var quizProvider = QuizProvider();

  String phone = '';

  bool isLoading = false;
  bool isSucess = false;

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref('watched_videos');

  @override
  void initState() {
    super.initState();
    getStudentID();

    final appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    appDataProvider.isLoading = true;
    appDataProvider.getImageData();
    appDataProvider.getbatchData();

    videoProvider = Provider.of<VideoProvider>(context, listen: false);
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
    // final notificationProvider =
    //     Provider.of<NotificationProvider>(context, listen: false);
    // notificationProvider.listnToNotifications();
    //listnToOngoings();
  }

  searchVideo(String query) {
    final suggestions = videoProvider.videos.where((video) {
      final title = video.title.toLowerCase();
      final input = query.toLowerCase();

      return title.contains(input);
    }).toList();

    if (query.isEmpty) {
      setState(() {
        videoProvider.getVideos();
      });
    } else {
      setState(() {
        videoProvider.videos = suggestions;
      });
    }
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

  void listnToOngoings() {
    databaseReference.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      Map<dynamic, dynamic>? values = dataSnapshot.value as Map?;

      if (values != null) {
        values.forEach((key, videoHistoryData) {
          if (key == studentID) {
            databaseReference.onValue.listen((event2) {
              DataSnapshot dataSnapshot2 = event2.snapshot.child(key);
              Map<dynamic, dynamic>? values2 = dataSnapshot2.value as Map?;

              if (values2 != null) {
                values2.forEach((key2, videoHistoryData2) {
                  print('Key: $key2');

                  if (videoProvider.watchedVideos
                      .contains(videoHistoryData2['paper_name'].toString())) {
                    print('This record available in the array list');
                  } else {
                    setState(() {
                      videoProvider.watchedVideos
                          .add(videoHistoryData2['paper_name'].toString());
                    });
                  }
                });
              }
            });
          }

          print('Key: $key');
        });
      } else {}
    });
  }

  Future<void> sendVerificationCode({
    String? phone,
    String? code,
  }) async {
    String Url =
        'http://send.ozonedesk.com/api/v2/send.php?user_id=105488&api_key=a50wpa6dx7wyzsq07&sender_id=DreamKorea&to=${phone}&message=Your video verification code is ${code}';

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
                  height: screenHeight / 4,
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
                                  color: AppColors.accentColor,
                                ),
                              ),
                              Text(
                                'Unlock Your Learning Potential Today!',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: AppColors.textGaryColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          // Icon(
                          //   Icons.person,
                          //   size: 30,
                          //   color: Colors.black,
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 236, 236),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        height: 50,
                        child: TextField(
                          style: TextStyle(
                            color: AppColors.textGaryColor,
                          ),
                          controller: searchController,
                          onChanged: searchVideo,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.textGaryColor,
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.textGaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 50,
                        width: screenWidth,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 135,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: AppColors.orangeColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '2024',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.accentColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.accentColor,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 135,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: AppColors.orangeColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '2023',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.accentColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.accentColor,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 135,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: AppColors.orangeColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '2022',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.accentColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.accentColor,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight / 4 * 3 -
                      (AppBar().preferredSize.height +
                          (Platform.isIOS ? 92 : 70)),
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('New_Initial_Videos')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Connection Error!',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              Center(
                                child: Text(
                                  'Loading.....',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }

                            if (snapshot.hasData) {
                              var docs = snapshot.data!.docs;
                              return ListView.builder(
                                  itemCount: docs.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PlayVideoSampleScreen(
                                              link:
                                                  '${YoutubePlayer.convertUrlToId(docs[index]['Video_URL'])}',
                                              title: docs[index]['Video_Title'],
                                              teacher: docs[index]
                                                  ['Teachers_Name'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: 'thumg',
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 15),
                                          child: YoutubePlayer(
                                            controller: YoutubePlayerController(
                                              initialVideoId:
                                                  '${YoutubePlayer.convertUrlToId(docs[index]['Video_URL'])}',
                                              flags: YoutubePlayerFlags(
                                                autoPlay: false,
                                                mute: false,
                                              ),
                                            ),
                                            showVideoProgressIndicator: true,
                                          ),
                                        ),
                                      ),
                                      // VideoCard(
                                      //   title: docs[index]['Video_Title'],
                                      //   teacher: docs[index]['Teachers_Name'],
                                      //   isAccepted: true,
                                      //   isWatched: false,
                                      // ),
                                    );
                                  });
                            }
                            return Text(
                              'No Videos',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            );
                          },
                        ),
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
