import 'package:flutter/material.dart';

class QuizCard extends StatefulWidget {
  final String title;
  const QuizCard({
    super.key,
    required this.title,
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.document_scanner,
            size: 35,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Text(
                '${widget.title}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              // Text(
              //   "${widget.quizAmount} Questions",
              //   style: TextStyle(
              //     fontFamily: 'Poppins',
              //     fontWeight: FontWeight.w600,
              //     fontSize: 14,
              //     color: AppColors.grayColor,
              //   ),
              // ),
              Spacer(),
            ],
          ),
          Spacer(),
          Icon(
            Icons.arrow_circle_right_outlined,
            size: 35,
          ),
        ],
      ),
    );
  }
}
