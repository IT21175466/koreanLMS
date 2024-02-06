class HistoryQuiz {
  final String studentID;
  final String quizName;
  final String marks;

  HistoryQuiz({
    required this.studentID,
    required this.quizName,
    required this.marks,
  });

  factory HistoryQuiz.fromJson(Map<String, dynamic> json) {
    return HistoryQuiz(
      studentID: json['StudentID'].toString(),
      quizName: json['QuizName'].toString(),
      marks: json['Marks'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'StudentID': studentID,
      'QuizName': quizName,
      'Marks': marks,
      'Date': DateTime.now().toString(),
    };
  }
}
