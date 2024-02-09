import 'package:flutter/material.dart';
import 'package:koreanlms/widgets/button_widget.dart';
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

    _controller.addListener(() {
      if (_controller.value.isFullScreen != isFullScreen) {
        isFullScreen = _controller.value.isFullScreen;

        if (isFullScreen) {
          setState(() {
            isFullScreen = true;
            _controller.pause();
          });
        } else {
          setState(() {
            isFullScreen = false;
            _controller.pause();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 0,
        automaticallyImplyLeading: true,
      ),
      body: isFullScreen
          ? Container(
              height: screenHeight,
              width: screenWidth,
              color: Colors.black,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                  ),
                ),

                // AspectRatio(
                //   aspectRatio: 16 / 9,
                //   child: VimeoPlayer(
                //     videoId: widget.link,
                //   ),
                // ),

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
                      widget.zoomLink.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ZoomRecordingPlay(
                                //         zoomLink: widget.zoomLink),
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
                              child: CustomButton(
                                text: 'Zoom Video',
                                height: 50,
                                width: screenWidth / 2,
                                backgroundColor: Colors.green,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
