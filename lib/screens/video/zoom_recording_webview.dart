import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ZoomRecordingPlay extends StatefulWidget {
  final String zoomLink;
  const ZoomRecordingPlay({
    super.key,
    required this.zoomLink,
  });

  @override
  State<ZoomRecordingPlay> createState() => _ZoomRecordingPlayState();
}

class _ZoomRecordingPlayState extends State<ZoomRecordingPlay> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Zoom Video',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse("https://zoom.us/"),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                inAppWebViewController = controller;
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
            ),
            _progress < 1
                ? Container(
                    child: LinearProgressIndicator(
                      color: Colors.blue,
                      value: _progress,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
