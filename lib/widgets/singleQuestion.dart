import 'package:flutter/material.dart';
import 'package:koreanlms/models/answer.dart';
import 'package:koreanlms/providers/quiz/quiz_provider.dart';
import 'package:koreanlms/widgets/answer_tile.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleQuestion extends StatefulWidget {
  final String question;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String answer5;
  final bool isSample;
  final bool isBackEnable;
  final String questionVideo;
  final String questionImage;
  final String answer1Image;
  final String answer2Image;
  final String answer3Image;
  final String answer4Image;
  final String answer5Image;
  final String answer1Video;
  final String answer2Video;
  final String answer3Video;
  final String answer4Video;
  final String answer5Video;
  final String correctAnswer;
  final int timer;
  final String indexOfQuiz;
  const SingleQuestion({
    super.key,
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.answer5,
    required this.isSample,
    required this.isBackEnable,
    required this.questionVideo,
    required this.questionImage,
    required this.answer1Image,
    required this.answer2Image,
    required this.answer3Image,
    required this.answer4Image,
    required this.answer5Image,
    required this.answer1Video,
    required this.answer2Video,
    required this.answer3Video,
    required this.answer4Video,
    required this.answer5Video,
    required this.correctAnswer,
    required this.timer,
    required this.indexOfQuiz,
  });

  @override
  State<SingleQuestion> createState() => _SingleQuestionState();
}

class _SingleQuestionState extends State<SingleQuestion> {
  late YoutubePlayerController _controller;

  void initializeController() {
    if (widget.questionVideo.isNotEmpty) {
      final videoID = YoutubePlayer.convertUrlToId(widget.questionVideo);

      _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          //hideControls: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeController();
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      //height: screenHeight - (AppBar().preferredSize.height * 2),
      width: screenWidth,
      child: Consumer(
        builder:
            (BuildContext context, QuizProvider quizProvider, Widget? child) =>
                Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            // widget.timer == 0
            //     ? SizedBox()
            //     : Container(
            //         width: screenWidth,
            //         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            //         decoration: BoxDecoration(
            //           color: _seconds < 10 ? Colors.red : Colors.green,
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: Text(
            //           '$_seconds seconds remaining',
            //           style: TextStyle(
            //             fontFamily: 'Poppins',
            //             fontWeight: FontWeight.w400,
            //             fontSize: 12,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.question,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            widget.questionImage.isEmpty && widget.questionVideo.isEmpty
                ? SizedBox()
                : Container(
                    height: 200,
                    width: screenWidth,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 224, 222, 222),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: widget.questionVideo.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: YoutubePlayer(
                                controller: _controller,
                                showVideoProgressIndicator: true,
                                bottomActions: [
                                  FullScreenButton(
                                    color: Colors.transparent,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Image.network(
                            '${widget.questionImage}',
                            fit: BoxFit.contain,
                          ),
                  ),
            SizedBox(
              height: 15,
            ),

            GestureDetector(
              onTap: () {
                if (quizProvider.isSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You already selected a answer!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  );
                } else {
                  setState(() {
                    quizProvider.isSelected = true;
                    quizProvider.coorectAnswer = widget.correctAnswer;
                    quizProvider.selectedAnswer = widget.answer1;
                    quizProvider.countCorrectWrong();

                    Answer answer = Answer(
                      indexOfQuiz: widget.indexOfQuiz,
                      correctAnswer: quizProvider.coorectAnswer,
                      selectedAnswer: quizProvider.selectedAnswer,
                    );

                    quizProvider.answers.add(answer);
                  });
                }
              },
              child: AnswerTile(
                answer: widget.answer1,
                answerImage: widget.answer1Image,
                textColor: quizProvider.selectedAnswer == widget.answer1
                    ? quizProvider.coorectAnswer == widget.correctAnswer
                        ? Colors.white
                        : Colors.grey
                    : Colors.grey,
                backgroundColor: quizProvider.selectedAnswer == widget.answer1
                    ? quizProvider.selectedAnswer == widget.correctAnswer
                        ? Colors.green
                        : Colors.red
                    : Colors.white,
                icon: quizProvider.selectedAnswer == widget.answer1
                    ? quizProvider.selectedAnswer == widget.correctAnswer
                        ? Image.asset('assets/images/correct.png')
                        : Image.asset('assets/images/wrong.png')
                    : Image.asset('assets/images/correct.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (quizProvider.isSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You already selected a answer!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  );
                } else {
                  setState(() {
                    quizProvider.isSelected = true;
                    quizProvider.coorectAnswer = widget.correctAnswer;
                    quizProvider.selectedAnswer = widget.answer2;
                    quizProvider.countCorrectWrong();

                    Answer answer = Answer(
                      indexOfQuiz: widget.indexOfQuiz,
                      correctAnswer: quizProvider.coorectAnswer,
                      selectedAnswer: quizProvider.selectedAnswer,
                    );

                    quizProvider.answers.add(answer);
                  });
                }
              },
              child: AnswerTile(
                answer: widget.answer2,
                answerImage: widget.answer2Image,
                textColor: quizProvider.selectedAnswer == widget.answer2
                    ? quizProvider.coorectAnswer == widget.correctAnswer
                        ? Colors.white
                        : Colors.grey
                    : Colors.grey,
                backgroundColor: quizProvider.selectedAnswer == widget.answer2
                    ? quizProvider.selectedAnswer == widget.correctAnswer
                        ? Colors.green
                        : Colors.red
                    : Colors.white,
                icon: quizProvider.selectedAnswer == widget.answer2
                    ? quizProvider.selectedAnswer == widget.correctAnswer
                        ? Image.asset('assets/images/correct.png')
                        : Image.asset('assets/images/wrong.png')
                    : Image.asset('assets/images/correct.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (quizProvider.isSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You already selected a answer!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  );
                } else {
                  setState(() {
                    quizProvider.isSelected = true;
                    quizProvider.selectedAnswer = widget.answer3;
                    quizProvider.coorectAnswer = widget.correctAnswer;
                    quizProvider.countCorrectWrong();

                    Answer answer = Answer(
                      indexOfQuiz: widget.indexOfQuiz,
                      correctAnswer: quizProvider.coorectAnswer,
                      selectedAnswer: quizProvider.selectedAnswer,
                    );

                    quizProvider.answers.add(answer);
                  });
                }
              },
              child: AnswerTile(
                answer: widget.answer3,
                answerImage: widget.answer3Image,
                textColor: quizProvider.selectedAnswer == widget.answer3
                    ? quizProvider.coorectAnswer == widget.correctAnswer
                        ? Colors.white
                        : Colors.grey
                    : Colors.grey,
                backgroundColor: quizProvider.selectedAnswer == widget.answer3
                    ? quizProvider.selectedAnswer == widget.correctAnswer
                        ? Colors.green
                        : Colors.red
                    : Colors.white,
                icon: quizProvider.selectedAnswer == widget.answer3
                    ? quizProvider.selectedAnswer == widget.correctAnswer
                        ? Image.asset('assets/images/correct.png')
                        : Image.asset('assets/images/wrong.png')
                    : Image.asset('assets/images/correct.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (quizProvider.isSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You already selected a answer!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  );
                } else {
                  setState(() {
                    quizProvider.isSelected = true;
                    quizProvider.selectedAnswer = widget.answer4;
                    quizProvider.coorectAnswer = widget.correctAnswer;
                    quizProvider.countCorrectWrong();

                    Answer answer = Answer(
                      indexOfQuiz: widget.indexOfQuiz,
                      correctAnswer: quizProvider.coorectAnswer,
                      selectedAnswer: quizProvider.selectedAnswer,
                    );

                    quizProvider.answers.add(answer);
                  });
                }
              },
              child: AnswerTile(
                answer: widget.answer4,
                answerImage: widget.answer4Image,
                textColor: quizProvider.selectedAnswer == widget.answer4
                    ? quizProvider.coorectAnswer == widget.correctAnswer
                        ? Colors.white
                        : Colors.grey
                    : Colors.grey,
                backgroundColor: quizProvider.selectedAnswer == widget.answer4
                    ? quizProvider.selectedAnswer == widget.correctAnswer
                        ? Colors.green
                        : Colors.red
                    : Colors.white,
                icon: quizProvider.selectedAnswer == widget.answer4
                    ? quizProvider.selectedAnswer == widget.correctAnswer
                        ? Image.asset('assets/images/correct.png')
                        : Image.asset('assets/images/wrong.png')
                    : Image.asset('assets/images/correct.png'),
              ),
            ),
            widget.answer5.isEmpty
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      if (quizProvider.isSelected) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You already selected a answer!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          quizProvider.isSelected = true;
                          quizProvider.coorectAnswer = widget.correctAnswer;
                          quizProvider.selectedAnswer = widget.answer5;
                          quizProvider.countCorrectWrong();

                          Answer answer = Answer(
                            indexOfQuiz: widget.indexOfQuiz,
                            correctAnswer: quizProvider.coorectAnswer,
                            selectedAnswer: quizProvider.selectedAnswer,
                          );

                          quizProvider.answers.add(answer);
                        });
                      }
                    },
                    child: AnswerTile(
                      answer: widget.answer5,
                      answerImage: widget.answer5Image,
                      textColor: quizProvider.selectedAnswer == widget.answer5
                          ? quizProvider.coorectAnswer == widget.correctAnswer
                              ? Colors.white
                              : Colors.grey
                          : Colors.grey,
                      backgroundColor: quizProvider.selectedAnswer ==
                              widget.answer5
                          ? quizProvider.selectedAnswer == widget.correctAnswer
                              ? Colors.green
                              : Colors.red
                          : Colors.white,
                      icon: quizProvider.selectedAnswer == widget.answer5
                          ? quizProvider.selectedAnswer == widget.correctAnswer
                              ? Image.asset('assets/images/correct.png')
                              : Image.asset('assets/images/wrong.png')
                          : Image.asset('assets/images/correct.png'),
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            quizProvider.isSelected == false
                ? SizedBox()
                : Row(
                    children: [
                      Text(
                        "Correct Answer : ",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.correctAnswer,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
