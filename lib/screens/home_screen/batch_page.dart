import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';
import 'package:koreanlms/providers/student_provider/student_provider.dart';
import 'package:koreanlms/screens/home_screen/class_page.dart';
import 'package:provider/provider.dart';

class BatchPage extends StatefulWidget {
  final String batchName;
  const BatchPage({super.key, required this.batchName});

  @override
  State<BatchPage> createState() => _BatchPageState();
}

class _BatchPageState extends State<BatchPage> {
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
                  '${widget.batchName} Batch',
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
          height: screenHeight,
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
                                if (studentProvider.myClasses
                                    .contains(docs[index]['Class_ID'])) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClassPage(
                                        batchName: widget.batchName,
                                        className: docs[index]['Class_Name'],
                                        classID: docs[index]['Class_ID'],
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: 60,
                                width: screenWidth,
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: studentProvider.myClasses
                                          .contains(docs[index]['Class_ID'])
                                      ? AppColors.lowAccentColor
                                      : Colors.black.withOpacity(0.4),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      docs[index]['Class_Name'],
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
                                      'Class',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: AppColors.accentColor,
                                      ),
                                    ),
                                    Spacer(),
                                    studentProvider.myClasses
                                            .contains(docs[index]['Class_ID'])
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
                      'No Classes',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    );
                  },
                ),

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       'Explore Classes',
          //       style: TextStyle(
          //         fontFamily: 'Poppins',
          //         fontWeight: FontWeight.w600,
          //         fontSize: 15,
          //         color: AppColors.accentColor,
          //       ),
          //     ),

          //   ],
          // ),
        ),
      ),
    );
  }
}
