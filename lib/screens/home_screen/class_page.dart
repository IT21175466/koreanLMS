import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/providers/student_provider/student_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ClassPage extends StatefulWidget {
  final String batchName;
  final String className;
  final String classID;
  const ClassPage({
    super.key,
    required this.batchName,
    required this.className,
    required this.classID,
  });

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
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
                  '${widget.className} Class',
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
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight / 3 * 2 - AppBar().preferredSize.height,
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
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => ClassPage(
                                    //       batchName: widget.batchName,
                                    //       className: docs[index]['Class_Name'],
                                    //       classID: docs[index]['Class_ID'],
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    width: screenWidth,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: screenWidth / 3,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 20,
                child: Text(
                  'Explore Terms',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              height: screenHeight / 3 * 1 - AppBar().preferredSize.height - 20,
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
                                    if (studentProvider.myTerms
                                        .contains(docs[index]['Class_ID'])) {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => ClassPage(
                                      //       batchName: widget.batchName,
                                      //       className: docs[index]['Class_Name'],
                                      //       classID: docs[index]['Class_ID'],
                                      //     ),
                                      //   ),
                                      // );
                                    }
                                  },
                                  child: Container(
                                    height: 60,
                                    width: screenWidth,
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: studentProvider.myTerms
                                              .contains(docs[index]['Term_ID'])
                                          ? AppColors.lowAccentColor
                                          : Colors.black.withOpacity(0.4),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          docs[index]['Term_Name'],
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 30,
                                            color: AppColors.accentColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Term',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: AppColors.accentColor,
                                          ),
                                        ),
                                        Spacer(),
                                        studentProvider.myTerms.contains(
                                                docs[index]['Term_ID'])
                                            ? Icon(
                                                Icons.arrow_forward_ios,
                                                color: AppColors.accentColor,
                                              )
                                            : Icon(
                                                Icons.lock,
                                                color: Colors.white,
                                                size: 26,
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
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
