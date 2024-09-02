// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:personal_blog/controller/paint/paint-pg-ctl.dart';
// import 'package:personal_blog/global/g_print.dart';
// import 'package:personal_blog/pages/paint/paint-draw-pg.dart';
// import 'package:scribble/scribble.dart';

// // // class PaintPage extends GetView<PaintPageController> {
// // //   PaintPage({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final controller = Get.put(PaintPageController());
// // //     return Scaffold(
// // //       body: Stack(
// // //         children: [
// // //           GestureDetector(
// // //             onTapDown: (details) {
// // //               controller.handleTap(details.localPosition);
// // //             },
// // //             child: Obx(() {
// // //               return MouseRegion(
// // //                 cursor: controller.isEraseMode.value
// // //                     ? SystemMouseCursors.click
// // //                     : SystemMouseCursors.basic,
// // //                 child: Scribble(
// // //                   notifier: controller.notifier,
// // //                 ),
// // //               );
// // //             }),
// // //           ),
// // //           Positioned(
// // //             right: 30,
// // //             bottom: 30,
// // //             child: GestureDetector(
// // //               onTap: () {
// // //                 controller.notifier.clear();
// // //               },
// // //               child: Text(
// // //                 'clear',
// // //               ),
// // //             ),
// // //           ),
// // //           Positioned(
// // //             right: 60,
// // //             bottom: 60,
// // //             child: GestureDetector(
// // //               onTap: () {
// // //                 controller.notifier.undo();
// // //               },
// // //               child: Text(
// // //                 'undo',
// // //               ),
// // //             ),
// // //           ),
// // //           Positioned(
// // //             right: 90,
// // //             bottom: 90,
// // //             child: GestureDetector(
// // //               onTap: () {
// // //                 controller.toggleEraseMode();
// // //               },
// // //               child: Obx(() {
// // //                 return Text(
// // //                   controller.isEraseMode.value
// // //                       ? 'Erase Mode On'
// // //                       : 'Erase Mode Off',
// // //                 );
// // //               }),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // class ScribbleExample extends StatefulWidget {
// //   const ScribbleExample({super.key});

// //   @override
// //   _ScribbleExampleState createState() => _ScribbleExampleState();
// // }

// // class _ScribbleExampleState extends State<ScribbleExample> {
// //   late ScribbleNotifier notifier;
// //   bool _isEraserMode = false;
// //   String? filePath;
// //   final List<String> savedFiles = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     notifier = ScribbleNotifier();
// //     notifier.addListener(() {
// //       _saveAutomatically();
// //     });
// //     _requestStoragePermission();
// //   }

// //   @override
// //   void dispose() {
// //     notifier.removeListener(_saveAutomatically);
// //     notifier.dispose();
// //     super.dispose();
// //   }

// //   Future<void> _requestStoragePermission() async {
// //     await Permission.storage.request();
// //   }

// //   void _saveAutomatically() async {
// //     if (filePath == null) {
// //       final directory = Directory('/storage/emulated/0/Download');
// //       filePath =
// //           '${directory.path}/scribble_${DateTime.now().millisecondsSinceEpoch}.png';

// //       // 경로에 폴더가 없으면 생성
// //       if (!await directory.exists()) {
// //         await directory.create(recursive: true);
// //       }
// //     }

// //     print('자동 저장 경로: $filePath'); // 디버그 로그 추가

// //     final imageBytes = await notifier.renderImage();
// //     final file = File(filePath!);
// //     await file.writeAsBytes(imageBytes.buffer.asUint8List());
// //     savedFiles.add(filePath!);
// //     print('자동 저장 성공'); // 디버그 로그 추가
// //   }

// //   void _showSavedFiles() async {
// //     final directory = Directory('/storage/emulated/0/Download');
// //     final List<String> files = [];

// //     if (await directory.exists()) {
// //       final fileList = directory.listSync();
// //       for (var file in fileList) {
// //         if (file.path.endsWith('.png')) {
// //           files.add(file.path);
// //         }
// //       }
// //     }

// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text('저장된 파일 목록'),
// //           content: SizedBox(
// //             width: double.maxFinite,
// //             height: 300,
// //             child: ListView.builder(
// //               itemCount: files.length,
// //               itemBuilder: (context, index) {
// //                 return ListTile(
// //                   title: Text(files[index]),
// //                 );
// //               },
// //             ),
// //           ),
// //           actions: <Widget>[
// //             TextButton(
// //               child: Text('닫기'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('메모 앱'),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.create),
// //             onPressed: () {
// //               setState(() {
// //                 _isEraserMode = false;
// //                 notifier.setColor(Colors.black);
// //                 notifier.setStrokeWidth(2.0);
// //               });
// //             },
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.cleaning_services),
// //             onPressed: () {
// //               setState(() {
// //                 _isEraserMode = !_isEraserMode;
// //                 if (_isEraserMode) {
// //                   notifier.setEraser();
// //                   notifier.setStrokeWidth(10.0);
// //                 } else {
// //                   notifier.setColor(Colors.black);
// //                   notifier.setStrokeWidth(2.0);
// //                 }
// //               });
// //             },
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.undo),
// //             onPressed: () {
// //               notifier.undo();
// //             },
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.save),
// //             onPressed: () async {
// //               // 이제 수동 저장은 필요하지 않지만, 여전히 저장 버튼을 눌러서 저장할 수 있도록 유지합니다.
// //               _saveAutomatically();
// //             },
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.list),
// //             onPressed: () {
// //               _showSavedFiles();
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Scribble(
// //         notifier: notifier,
// //         drawEraser: _isEraserMode,
// //       ),
// //     );
// //   }

// //   Future<void> _saveToFile() async {
// //     // 권한 요청
// //     if (await Permission.storage.request().isGranted) {
// //       if (filePath == null) {
// //         final directory = Directory('/storage/emulated/0/Download');
// //         filePath = '${directory.path}/scribble.png';

// //         // 경로에 폴더가 없으면 생성
// //         if (!await directory.exists()) {
// //           await directory.create(recursive: true);
// //         }
// //       }

// //       print('저장 경로: $filePath'); // 디버그 로그 추가

// //       final imageBytes = await notifier.renderImage();
// //       final file = File(filePath!);
// //       await file.writeAsBytes(imageBytes.buffer.asUint8List());
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('파일이 저장되었습니다: $filePath')),
// //       );
// //       print('파일 저장 성공'); // 디버그 로그 추가
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('저장소 권한이 필요합니다.')),
// //       );
// //       print('저장소 권한 없음'); // 디버그 로그 추가
// //     }
// //   }
// // }
// class NoteListPage extends StatefulWidget {
//   const NoteListPage({super.key});

//   @override
//   _NoteListPageState createState() => _NoteListPageState();
// }

// class _NoteListPageState extends State<NoteListPage> {
//   List<String> files = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedFiles();
//     _requestStoragePermission();
//   }

//   Future<void> _requestStoragePermission() async {
//     await Permission.storage.request();
//   }

//   void _loadSavedFiles() async {
//     final directory = Directory('/storage/emulated/0/Download');
//     if (await directory.exists()) {
//       final fileList = directory.listSync();
//       setState(() {
//         files = fileList
//             .where((file) => file.path.endsWith('.png'))
//             .map((file) => file.path)
//             .toList();
//       });
//     }
//   }

//   void _openNewNote() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ScribblePage()),
//     ).then((_) {
//       _loadSavedFiles(); // 메모 페이지에서 돌아왔을 때 파일 목록 갱신
//     });
//   }

//   void _openNote(String filePath) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => ScribblePage(existingFilePath: filePath)),
//     ).then((_) {
//       _loadSavedFiles(); // 메모 페이지에서 돌아왔을 때 파일 목록 갱신
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('메모 목록'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: _openNewNote,
//           ),
//         ],
//       ),
//       body: GridView.builder(
//         padding: EdgeInsets.all(10),
//         itemCount: files.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               _openNote(files[index]);
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center, // 수직 정렬 조정
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.brown[300],
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     files[index].split('Download/').last.toString(),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//         gridDelegate:
//             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//       ),
//     );
//   }
// }
