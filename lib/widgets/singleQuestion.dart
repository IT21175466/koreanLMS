import 'package:flutter/material.dart';
import 'package:koreanlms/widgets/answer_tile.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
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
          AnswerTile(
            answer: widget.answer1,
            answerImage: widget.answer1Image,
          ),
          AnswerTile(
            answer: widget.answer2,
            answerImage: widget.answer2Image,
          ),
          AnswerTile(
            answer: widget.answer3,
            answerImage: widget.answer3Image,
          ),
          AnswerTile(
            answer: widget.answer4,
            answerImage: widget.answer4Image,
          ),
          widget.answer5.isEmpty
              ? SizedBox()
              : AnswerTile(
                  answer: widget.answer5,
                  answerImage: widget.answer5Image,
                ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
