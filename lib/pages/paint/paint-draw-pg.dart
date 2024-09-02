// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:scribble/scribble.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ScribblePage extends StatefulWidget {
//   final String? existingFilePath;

//   ScribblePage({super.key, this.existingFilePath});

//   @override
//   _ScribblePageState createState() => _ScribblePageState();
// }

// class _ScribblePageState extends State<ScribblePage> {
//   late ScribbleNotifier notifier;
//   bool _isEraserMode = false;
//   ui.Image? _backgroundImage;
//   String? filePath;

//   @override
//   void initState() {
//     super.initState();
//     notifier = ScribbleNotifier();
//     _loadExistingNote();
//     notifier.addListener(_saveAutomatically);
//   }

//   @override
//   void dispose() {
//     notifier.removeListener(_saveAutomatically);
//     _saveCurrentSketch();
//     notifier.dispose();
//     super.dispose();
//   }

//   Future<void> _loadExistingNote() async {
//     final prefs = await SharedPreferences.getInstance();
//     final existingFilePath =
//         widget.existingFilePath ?? prefs.getString('savedImagePath');

//     if (existingFilePath != null) {
//       final file = File(existingFilePath);
//       if (await file.exists()) {
//         final bytes = await file.readAsBytes();
//         final image = await decodeImageFromList(bytes);
//         setState(() {
//           _backgroundImage = image;
//           filePath = existingFilePath;
//         });
//       }
//     }
//   }

//   Future<ui.Image> decodeImageFromList(Uint8List list) async {
//     final codec = await ui.instantiateImageCodec(list);
//     final frame = await codec.getNextFrame();
//     return frame.image;
//   }

//   void _saveAutomatically() async {
//     final directory = Directory('/storage/emulated/0/Download');

//     // 경로에 폴더가 없으면 생성
//     if (!await directory.exists()) {
//       await directory.create(recursive: true);
//     }

//     filePath ??= widget.existingFilePath ??
//         '${directory.path}/scribble_${DateTime.now().millisecondsSinceEpoch}.png';
//     print('자동 저장 경로: $filePath'); // 디버그 로그 추가

//     final imageBytes = await notifier.renderImage();
//     final file = File(filePath!);
//     await file.writeAsBytes(imageBytes.buffer.asUint8List());
//     print('자동 저장 성공'); // 디버그 로그 추가

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('savedImagePath', filePath!);
//   }

//   void _saveCurrentSketch() async {
//     if (filePath != null) {
//       final imageBytes = await notifier.renderImage();
//       final file = File(filePath!);
//       await file.writeAsBytes(imageBytes.buffer.asUint8List());
//       print('현재 스케치 저장 성공'); // 디버그 로그 추가
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('메모 작성'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.create),
//             onPressed: () {
//               setState(() {
//                 _isEraserMode = false;
//                 notifier.setColor(Colors.black);
//                 notifier.setStrokeWidth(2.0);
//               });
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.cleaning_services),
//             onPressed: () {
//               setState(() {
//                 _isEraserMode = !_isEraserMode;
//                 if (_isEraserMode) {
//                   notifier.setEraser();
//                   notifier.setStrokeWidth(10.0);
//                 } else {
//                   notifier.setColor(Colors.black);
//                   notifier.setStrokeWidth(2.0);
//                 }
//               });
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.undo),
//             onPressed: () {
//               notifier.undo();
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           if (_backgroundImage != null)
//             Positioned.fill(
//               child: CustomPaint(
//                 painter: ImagePainter(_backgroundImage!),
//               ),
//             ),
//           Scribble(
//             notifier: notifier,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ImagePainter extends CustomPainter {
//   final ui.Image image;

//   ImagePainter(this.image);

//   @override
//   void paint(Canvas canvas, Size size) {
//     paintImage(
//       canvas: canvas,
//       rect: Rect.fromLTWH(0, 0, size.width, size.height),
//       image: image,
//       fit: BoxFit.cover,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
