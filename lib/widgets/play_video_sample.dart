import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoSampleScreen extends StatefulWidget {
  final String link;
  final String title;
  final String teacher;

  const PlayVideoSampleScreen({
    super.key,
    required this.link,
    required this.title,
    required this.teacher,
  });

  @override
  State<PlayVideoSampleScreen> createState() => _PlayVideoSampleScreenState();
}

class _PlayVideoSampleScreenState extends State<PlayVideoSampleScreen> {
  bool isFullScreen = false;
  late YoutubePlayerController _controller;

  void videoInfoAlertDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text(
            "Video Details",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          content: Container(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  "${widget.teacher} ",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            "Video Details",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          content: Container(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  "${widget.teacher} ",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // final videoID = YoutubePlayer.convertUrlToId(
    //     'https://www.youtube.com/live/2YA-C56EVVA');

    _controller = YoutubePlayerController(
      initialVideoId: widget.link,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
        builder: (context, player) => Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Row(
              children: [
                Spacer(),
                Text(
                  "Video Player",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    videoInfoAlertDialog();
                  },
                  icon: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: Center(child: player),
          //isFullScreen
          // ? Container(
          //     height: screenHeight,
          //     width: screenWidth,
          //     color: Colors.black,
          //     child: AspectRatio(
          //       aspectRatio: 16 / 9,
          //       child: YoutubePlayer(
          //         controller: _controller,
          //         showVideoProgressIndicator: true,
          //       ),
          //     ),
          //   )
          // :
          // Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       AspectRatio(
          //         aspectRatio: 16 / 9,
          //         child: YoutubePlayer(
          //           controller: _controller,
          //           showVideoProgressIndicator: true,
          //         ),
          //       ),

          //       // AspectRatio(
          //       //   aspectRatio: 16 / 9,
          //       //   child: VimeoPlayer(
          //       //     videoId: widget.link,
          //       //   ),
          //       // ),

          //       Container(
          //         padding: EdgeInsets.all(15),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               widget.title,
          //               style: TextStyle(
          //                 fontFamily: 'Poppins',
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 20,
          //               ),
          //             ),
          //             Text(
          //               widget.teacher,
          //               style: TextStyle(
          //                 fontFamily: 'Poppins',
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 16,
          //                 color: Colors.grey,
          //               ),
          //             ),
          //             SizedBox(
          //               height: 15,
          //             ),
          //             widget.zoomLink.isNotEmpty
          //                 ? GestureDetector(
          //                     onTap: () {
          //                       // Navigator.push(
          //                       //   context,
          //                       //   MaterialPageRoute(
          //                       //     builder: (context) => ZoomWebview(),
          //                       //   ),
          //                       // );
          //                       print(widget.zoomLink);
          //                       setState(() {
          //                         launchUrl(
          //                           Uri.parse(widget.zoomLink),
          //                           mode: LaunchMode.inAppWebView,
          //                         );
          //                       });
          //                     },
          //                     child: CustomButton(
          //                       text: 'Zoom Video',
          //                       height: 50,
          //                       width: screenWidth / 2,
          //                       backgroundColor: Colors.green,
          //                     ),
          //                   )
          //                 : SizedBox(),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
        ),
      ),
    );
  }
}
