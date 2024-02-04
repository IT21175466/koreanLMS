import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  final controller = WebViewController();

  @override
  void initState() {
    super.initState();
    controller
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.zoomLink));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
