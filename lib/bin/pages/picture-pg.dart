// import 'dart:developer';
// import 'dart:io';

// import 'package:dio/dio.dart' as form;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:personal_blog/bin/pages/picture-detail-pg.dart';
// import 'package:personal_blog/global/g_value.dart';

// import '../../global/g_dio.dart';
// import '../../global/g_print.dart';

// class PicTestPage extends StatefulWidget {
//   const PicTestPage({super.key});

//   @override
//   State<PicTestPage> createState() => _PicTestPageState();
// }

// class _PicTestPageState extends State<PicTestPage> {
//   final ImagePicker picker = ImagePicker();

//   XFile? cameraImage;
//   List<XFile>? gelImage = [];
//   List<XFile>? images = [];
//   RxList dataList = [].obs;

//   @override
//   void initState() {
//     super.initState();
//     getImage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       bottom: true,
//       child: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     picImage();
//                   },
//                   child: Text(
//                     '사진촬영',
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     picGallery();
//                   },
//                   child: Text(
//                     '갤러리',
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     gelImage!.clear();
//                     images!.clear();
//                     setState(() {});
//                   },
//                   child: Text(
//                     '사진 초기화',
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               flex: 5,
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3, // 한 줄에 3개의 이미지를 표시
//                 ),
//                 itemCount: images!.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       images!.removeAt(index);
//                       setState(() {});
//                     },
//                     child: Image.file(
//                       File(
//                         images![index].path,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Obx(
//               () => Expanded(
//                 flex: 5,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   child: ListView.builder(
//                     itemCount: dataList.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Get.to(PicTestDetailPage(),arguments: dataList[index]);
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(bottom: 10),
//                           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                           decoration: BoxDecoration(
//                             color: Colors.blue[100]!.withOpacity(0.4),
//                             borderRadius: BorderRadius.circular(10)
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('${dataList[index]['title']} ${index+1}번'),
//                               SizedBox(height: 10,),
//                               Row(
//                                 children: List.generate(
//                                   dataList[index]['subImage'].length,
//                                   (subIndex) {
//                                     return SizedBox(
//                                       width: 80,
//                                       height: 80,
//                                       child: Image.network(
//                                         '$baseUrl/api/files/${dataList[index]['collectionId']}/${dataList[index]['id']}/${dataList[index]['subImage'][subIndex]}',
//                                         fit: BoxFit.contain,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 uploadImage();
//               },
//               child: Text(
//                 '이미지 업로드하기',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> picImage() async {
//     try {
//       cameraImage = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
//       setState(() {
//         images?.add(cameraImage!);
//       });
//       inspect(images);
//     } catch (e) {
//       printRed('picImage Error Message : $e');
//     }
//   }

//   Future<void> picGallery() async {
//     try {
//       gelImage = await picker.pickMultiImage(
//         imageQuality: 60,
//       );
//       setState(() {
//         images?.addAll(gelImage!);
//       });
//     } catch (e) {
//       printRed('picGallery Error Message : $e');
//     }
//   }

//   Future<void> getImage() async {
//     dataList.clear();
//     try {
//       var res = await dio.get('$baseUrl/api/collections/blog/records');
//       for (var data in res.data['items']) {
//         if (data['subImage'].isNotEmpty) {
//           dataList.add(data);
//         }
//       }
//       inspect(dataList);
//     } catch (e) {
//       printRed('getImage Error Message : $e');
//     }
//   }

//   Future<void> uploadImage() async {
//     try {
//       List<form.MultipartFile> fileList = [];
//       for (var image in images!) {
//         var multipartFile = form.MultipartFile.fromFileSync(
//           image.path,
//           filename: image.name,
//         );
//         fileList.add(multipartFile);
//       }

//       // FormData 객체 생성
//       form.FormData formData = form.FormData.fromMap({
//         'title': 'image',
//         'content': 'image multi upload test',
//         'subImage': fileList,
//       });

//       var res = await dio.post(
//         '$baseUrl/api/collections/blog/records',
//         options: form.Options(headers: {'Content-type': 'multipart/form-data'}),
//         data: formData,
//       );

//       if (res.statusCode! < 399) {
//         Get.showSnackbar(GetSnackBar(
//           duration: Duration(seconds: 2),
//           title: '저장',
//           message: '저장에 성공했습니다.',
//           backgroundColor: Colors.blue[100]!,
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         ));
//       } else {
//         Get.showSnackbar(GetSnackBar(
//           duration: Duration(seconds: 2),
//           title: '실패',
//           message: '실패했습니다. 관리자에게 문의하세요',
//           backgroundColor: Colors.red[100]!,
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         ));
//       }
//       inspect(res.data);
//       images!.clear();
//       setState(() {});
//     } catch (e) {
//       printRed('uploadImage Error Message : $e');
//     }
//   }
// }
