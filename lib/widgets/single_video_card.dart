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
      //height: 230,
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.accentColor,
          width: 0.5,
        ),
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
                image: AssetImage('assets/images/cardSample.JPG'),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Container(
              width: screenWidth,
              height: 130,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: isAccepted
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        isWatched == false
                            ? Container(
                                width: 100,
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black,
                                ),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Icon(
                                      Icons.play_circle_fill,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'To Watch',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              )
                            : Container(
                                width: 100,
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black,
                                ),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Icon(
                                      Icons.done,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Watched',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                        Spacer(),
                        Center(
                          child: SizedBox(
                              height: 50,
                              child: Image.asset('assets/images/youtube.png')),
                        ),
                        Spacer(),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 100,
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black,
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              Icon(
                                Icons.payment,
                                size: 15,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Pending',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Spacer(),
                        Center(
                          child: Container(
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
                        ),
                        Center(
                          child: Text(
                            'Payment Required',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
            ),
          ),
          //Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.accentColor,
                        ),
                      ),
                      Text(
                        teacher,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Spacer(),
        ],
      ),
    );
  }
}
