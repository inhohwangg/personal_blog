// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';

// class RtspTestPage extends StatefulWidget {
//   const RtspTestPage({super.key});

//   @override
//   State<RtspTestPage> createState() => _RtspTestPageState();
// }

// class _RtspTestPageState extends State<RtspTestPage> {
//   late VlcPlayerController vlcPlayerController;

//   List<String> rtspLinks = [
//     'https://topiscctv1.eseoul.go.kr/sd2/ch33.stream/playlist.m3u8',
//     'https://topiscctv1.eseoul.go.kr/sd2/ch41.stream/playlist.m3u8',
//     // 'https://topiscctv1.eseoul.go.kr/edge6/ch103.stream/playlist.m3u8'
//     'rtsp://210.99.70.120:1935/live/cctv001.stream',
//     'rtsp://210.99.70.120:1935/live/cctv002.stream',
//     'rtsp://210.99.70.120:1935/live/cctv003.stream',
//   ];
//   int currentIndex = 0;
//   Timer? timer;
//   int remainingTime = 60;

//   void startTimer() {
//     timer?.cancel();
//     remainingTime = 60;
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (remainingTime > 0) {
//           remainingTime--;
//         } else {
//           currentIndex = (currentIndex + 1) % rtspLinks.length;
//           vlcPlayerController.setMediaFromNetwork(rtspLinks[currentIndex]);
//           remainingTime = 60;
//         }
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     vlcPlayerController = VlcPlayerController.network(
//         // 'rtsp://210.99.70.120:1935/live/cctv001.stream',
//         rtspLinks[currentIndex],
//         hwAcc: HwAcc.full,
//         autoPlay: true,
//         options: VlcPlayerOptions());
//     startTimer();
//   }

//   @override
//   void dispose() {
//     vlcPlayerController.stop();
//     vlcPlayerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Center(
//             child: VlcPlayer(
//               controller: vlcPlayerController,
//               aspectRatio: 16 / 9,
//               placeholder: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 20,
//             right: 20,
//             child: Container(
//               padding: EdgeInsets.all(10),
//               color: Colors.black54,
//               child: Text(
//                 '남은 시간 : $remainingTime',
//                 style: TextStyle(color: Colors.black, fontSize: 20),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// //rtsp://10.1.120.33:554/vurix/100122/0
// //rtsp://10.1.120.35:554/vurix/100492/0