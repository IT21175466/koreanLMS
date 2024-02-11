import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  bool isFullScreen = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final videoID = YoutubePlayer.convertUrlToId(widget.link);

    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
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
                Text(
                  "Video",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Spacer(),
                widget.zoomLink.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ZoomWebview(),
                          //   ),
                          // );
                          print(widget.zoomLink);
                          setState(() {
                            launchUrl(
                              Uri.parse(widget.zoomLink),
                              mode: LaunchMode.inAppWebView,
                            );
                          });
                        },
                        child: Text(
                          'Zoom Video',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            backgroundColor: Colors.green,
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: player,
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
