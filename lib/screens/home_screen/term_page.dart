import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/providers/student_provider/student_provider.dart';
import 'package:koreanlms/widgets/play_video_sample.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TermPage extends StatefulWidget {
  final String batchName;
  final String className;
  final String classID;
  final String termName;
  final String termID;
  const TermPage({
    super.key,
    required this.batchName,
    required this.className,
    required this.classID,
    required this.termID,
    required this.termName,
  });

  @override
  State<TermPage> createState() => _TermPageState();
}

class _TermPageState extends State<TermPage> {
  @override
  void initState() {
    super.initState();
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    studentProvider.isLoading = true;
    studentProvider.getStudentBaches();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.accentColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${widget.termName} Term',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: AppColors.accentColor,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 45,
                  child: Image.asset('assets/images/splashLogo.png'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Consumer(
        builder: (BuildContext context, StudentProvider studentProvider,
                Widget? child) =>
            Container(
          height: screenHeight - AppBar().preferredSize.height,
          width: screenWidth,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: studentProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('New_Batches')
                      .doc(widget.batchName)
                      .collection("Classes")
                      .doc(widget.classID)
                      .collection("Terms")
                      .doc(widget.termID)
                      .collection("Videos")
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

                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                                    builder: (context) => PlayVideoSampleScreen(
                                      link:
                                          '${YoutubePlayer.convertUrlToId(docs[index]['Video_URL'])}',
                                      title: docs[index]['Video_Title'],
                                      teacher: docs[index]['Teachers_Name'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 15),
                                width: screenWidth,
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: screenWidth / 3,
                                        child: Stack(
                                          children: [
                                            YoutubePlayer(
                                              controller:
                                                  YoutubePlayerController(
                                                initialVideoId:
                                                    '${YoutubePlayer.convertUrlToId(docs[index]['Video_URL'])}',
                                                flags: YoutubePlayerFlags(
                                                  hideControls: true,
                                                  autoPlay: false,
                                                  mute: false,
                                                ),
                                              ),
                                              showVideoProgressIndicator: true,
                                            ),
                                            Positioned(
                                              top: 0,
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Center(
                                                child: SizedBox(
                                                  height: 40,
                                                  child: Image.asset(
                                                    'assets/images/youtube.png',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          docs[index]['Video_Title'],
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: AppColors.accentColor,
                                          ),
                                        ),
                                        Text(
                                          docs[index]['Teachers_Name'],
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.textGaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    return Text(
                      'No Terms',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
