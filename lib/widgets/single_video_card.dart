import 'package:flutter/material.dart';
import 'package:koreanlms/constants/app_colors.dart';

// ignore: must_be_immutable
class VideoCard extends StatelessWidget {
  bool isAccepted = false;
  bool isWatched = false;
  bool isLoading = false;
  String title;
  String teacher;
  VideoCard({
    super.key,
    required this.isAccepted,
    required this.isWatched,
    required this.title,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(
        //   color: Colors.grey,
        // ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            width: screenWidth,
            height: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/card.jpeg'),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Container(
              width: screenWidth,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: isAccepted
                    ? Container(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: Icon(
                            Icons.play_arrow,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      )
                    : Column(
                        children: [
                          Spacer(),
                          Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.lock,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          Text(
                            'Payment Required',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      teacher,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                isWatched == false
                    ? SizedBox()
                    : Column(
                        children: [
                          Icon(
                            Icons.done,
                            color: AppColors.grayColor,
                          ),
                          Text(
                            'Watched',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: AppColors.grayColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
