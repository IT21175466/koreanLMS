// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:koreanlms/providers/video/video_provider.dart';
// import 'package:provider/provider.dart';

// class ZoomRecordingPlay extends StatefulWidget {
//   final String zoomLink;
//   const ZoomRecordingPlay({
//     super.key,
//     required this.zoomLink,
//   });

//   @override
//   State<ZoomRecordingPlay> createState() => _ZoomRecordingPlayState();
// }

// class _ZoomRecordingPlayState extends State<ZoomRecordingPlay> {
//   // double _progress = 0;
//   // late InAppWebViewController inAppWebViewController;

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//                 appBar: AppBar(
//       title: Text(
//         'Zoom Video',
//         style: TextStyle(
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w500,
//           color: Colors.white,
//         ),
//       ),
//       centerTitle: true,
//       backgroundColor: Colors.green,
//       automaticallyImplyLeading: false,
//                 ),
//                 body: Stack(
//       children: [
//         InAppWebView(
//           initialUrlRequest: URLRequest(
//             url: Uri.parse(widget.zoomLink),
//           ),
//           onWebViewCreated: (InAppWebViewController controller) {
//             inAppWebViewController = controller;
//           },
//           onProgressChanged:
//               (InAppWebViewController controller, int progress) {
//             setState(() {
//               _progress = progress / 100;
//             });
//           },
//         ),
//         _progress < 1
//             ? Positioned(
//                 top: screenHeight / 2 - 60,
//                 left: 20,
//                 right: 20,
//                 child: Container(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                   ),
//                   child: Row(
//                     children: [
//                       CircularProgressIndicator(),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Text("Please Wait...."),
//                     ],
//                   ),
//                 ),
//               )
//             : SizedBox(),
//       ],
//                 ),
//               ),
//     );
//   }
// }
