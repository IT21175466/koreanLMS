class Quiz {
  final String questionNumber;
  final String question;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String answer5;
  final String correctAnswer;
  final bool isSample;
  final bool isBackEnable;
  final int timer;
  //Images
  final String questionImage;
  final String answer1Image;
  final String answer2Image;
  final String answer3Image;
  final String answer4Image;
  final String answer5Image;
  //Video Link
  final String questionVideoLink;
  final String answer1VideoLink;
  final String answer2VideoLink;
  final String answer3VideoLink;
  final String answer4VideoLink;
  final String answer5VideoLink;

  Quiz({
    required this.questionNumber,
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.answer5,
    required this.correctAnswer,
    required this.questionImage,
    required this.answer1Image,
    required this.answer2Image,
    required this.answer3Image,
    required this.answer4Image,
    required this.answer5Image,
    required this.questionVideoLink,
    required this.answer1VideoLink,
    required this.answer2VideoLink,
    required this.answer3VideoLink,
    required this.answer4VideoLink,
    required this.answer5VideoLink,
    required this.isSample,
    required this.isBackEnable,
    required this.timer,
  });
}
