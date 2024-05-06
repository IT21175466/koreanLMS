import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koreanlms/providers/quiz/quiz_provider.dart';
import 'package:koreanlms/screens/quiz/question_screen.dart';
import 'package:koreanlms/widgets/quiz_card.dart';
import 'package:provider/provider.dart';

class TermPapersTab extends StatefulWidget {
  final String batchName;
  final String className;
  final String classID;
  final String termName;
  final String termID;
  const TermPapersTab(
      {super.key,
      required this.batchName,
      required this.className,
      required this.classID,
      required this.termName,
      required this.termID});

  @override
  State<TermPapersTab> createState() => _TermPapersTabState();
}

class _TermPapersTabState extends State<TermPapersTab> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer(
        builder:
            (BuildContext context, QuizProvider quizProvider, Widget? child) =>
                Container(
          height: screenHeight,
          width: screenWidth,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('New_Batches')
                .doc(widget.batchName)
                .collection("Classes")
                .doc(widget.classID)
                .collection("Terms")
                .doc(widget.termID)
                .collection("Papers")
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
                              builder: (context) => QuestionScreen(
                                quizName: docs[index]['Paper_Name'],
                                paperTimer: docs[index]['Paper_Timer'],
                                batchName: widget.batchName,
                                className: widget.className,
                                classID: widget.classID,
                                termName: widget.termName,
                                termID: widget.termID,
                              ),
                            ),
                          );
                        },
                        child: QuizCard(
                          title: docs[index]['Paper_Name'],
                          color: Colors.blueAccent.withOpacity(0.1),
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    });
              }
              return Text(
                'No Papers',
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
