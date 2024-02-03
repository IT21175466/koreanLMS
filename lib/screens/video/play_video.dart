//import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:koreanlms/widgets/button_widget.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class PlayVideoScreen extends StatefulWidget {
  final String link;
  final String title;
  final String teacher;
  final String zoomLink;

  const PlayVideoScreen({
    super.key,
    required this.link,
    required this.title,
    required this.teacher,
    required this.zoomLink,
  });

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppBar().preferredSize.height,
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: VimeoPlayer(
              videoId: widget.link,
            ),
            // BetterPlayer.network(
            //   widget.link,
            //   betterPlayerConfiguration: BetterPlayerConfiguration(
            //     aspectRatio: 16 / 9,
            //   ),
            // ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Text(
                  widget.teacher,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  text: 'Zoom Video',
                  height: 50,
                  width: screenWidth / 2,
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
