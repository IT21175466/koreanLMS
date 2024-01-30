import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';

class QuizHistoryCard extends StatefulWidget {
  const QuizHistoryCard({super.key});

  @override
  State<QuizHistoryCard> createState() => _QuizHistoryCardState();
}

class _QuizHistoryCardState extends State<QuizHistoryCard> {
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
            Icons.history,
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
                'Language Basics',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                '30 min',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.grayColor,
                ),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          Text(
            '80%',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColors.grayColor,
            ),
          ),
        ],
      ),
    );
  }
}
