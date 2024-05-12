// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart' as form;
// import 'package:http_parser/http_parser.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:personal_blog/bin/controllers/picture-detail-pg-ctl.dart';
// import 'package:personal_blog/global/g_dio.dart';

// import '../../global/g_print.dart';
// import '../../global/g_value.dart';
// import 'picture-pg.dart';

// class PicTestDetailPage extends StatefulWidget {
//   const PicTestDetailPage({super.key});

//   @override
//   State<PicTestDetailPage> createState() => _PicTestDetailPageState();
// }

// class _PicTestDetailPageState extends State<PicTestDetailPage> {
//   final ImagePicker picker = ImagePicker();
//   final PicTextDetailPageController controller =
//       Get.put(PicTextDetailPageController());
//   List<XFile> newImages = [];
//   List<dynamic> currentImages = [];
//   Set<String> toBeDeleted = {};
//   RxList deleteImage = [].obs;
//   List imageList = [];

//   @override
//   void initState() {
//     super.initState();
//     currentImages = List.from(controller.infoData['subImage']);
//   }

//   //* 사진 촬영하고 촬영한 사진을 newImage 변수에 할당
//   void pickImage() async {
//     try {
//       final XFile? image =
//           await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
//       if (image != null) {
//         setState(() {
//           newImages.add(image);
//         });
//       }
//     } catch (e) {
//       printRed('pickImage Error Message : $e');
//     }
//   }

//   void markForDeletion(String imageUrl) {
//     setState(() {
//       deleteImage.add(imageUrl);
//       toBeDeleted.add(imageUrl);
//     });
//   }

//   Future<void> saveChanges() async {
//     try {
//       var response = await uploadImages();
//       if (response.data != null) {
//         print('Server response: ${response.data}');
//       } else {
//         print('No response or null data received from the server');
//       }
//     } catch (e) {
//       print('An error occurred during the save changes operation: $e');
//       // 여기서 예외를 적절히 처리하고 사용자에게 피드백을 줄 수 있습니다.
//     }
//   }

//   // Future<form.Response> uploadImages() async {
//   //   Map<String, dynamic> formDataMap = {
//   //     'title': controller.infoData['title'],
//   //     'content': controller.infoData['content'],
//   //     'subImage': currentImages.where((image) => !toBeDeleted.contains(image)).toList()
//   //   };

//   //   // 삭제할 이미지에 대한 처리
//   //   toBeDeleted.forEach((deletedImage) {
//   //     formDataMap['deletedImages'] = [deletedImage]; // 서버에 삭제할 이미지 목록을 전달
//   //   });

//   //   var formData = form.FormData.fromMap(formDataMap);

//   //   try {
//   //     var response = await dio.patch('$baseUrl/api/collections/blog/records/${controller.infoData['id']}',
//   //         data: formData, options: form.Options(headers: {'Content-Type': 'multipart/form-data'}));
//   //     return response;
//   //   } catch (e) {
//   //     print('Error during image update: $e');
//   //     throw Exception('Failed to update images');
//   //   }
//   // }
//   Future<form.Response> uploadImages() async {
//     for (var image in currentImages) {
//       imageList.add(image);
//     }

//     //* 새롭게 추가된 이미지 파일들을 MultipartFile로 변환
//     for (var newImage in newImages) {
//       if (await File(newImage.path).exists()) {
//         var newMultipartFile = form.MultipartFile.fromFileSync(
//           newImage.path,
//           filename: newImage.name,
//           contentType: MediaType('image', 'jpeg'),
//         );
//         imageList.add(newMultipartFile);
//       } else {
//         printYellow('New image file does not exist: ${newImage.path}');
//       }
//     }

//     for (int i = 0; i < imageList.length; i++) {
//       if (deleteImage.contains(imageList[i])) {
//         printRed(imageList[i]);
//         imageList[i] = null;
//       }
//     }
//     inspect(imageList);
//     //* FormData 구성
//     var formData = form.FormData.fromMap({
//       'title': controller.infoData['title'],
//       'content': controller.infoData['content'],
//       'subImage': imageList,
//     });

//     //* 서버 요청
//     try {
//       var res = await dio.patch(
//           '$baseUrl/api/collections/blog/records/${controller.infoData['id']}',
//           data: formData,
//           options:
//               form.Options(headers: {'Content-Type': 'multipart/form-data'}));
//       if (res.statusCode! < 399) {
//         Get.snackbar('성공', '사진이 성공적으로 업데이트 되었습니다.',
//             backgroundColor: Colors.green[200],
//             snackPosition: SnackPosition.BOTTOM);
//         Get.back();
//       } else {
//         Get.snackbar('실패', '사진 업로드에 실패했습니다. ${res.statusCode}',
//             backgroundColor: Colors.red[200],
//             snackPosition: SnackPosition.BOTTOM);
//       }
//       return res;
//     } catch (e) {
//       printRed('Error during image update : $e');
//       throw Exception('Failed to update images');
//     }
//   }

//   void handleResponse(form.Response response) {
//     if (response.statusCode! < 399) {
//       Get.snackbar('성공', '사진이 성공적으로 업데이트 되었습니다.',
//           backgroundColor: Colors.green[200],
//           snackPosition: SnackPosition.BOTTOM);
//     } else {
//       Get.snackbar('실패', '사진 업로드에 실패했습니다.',
//           backgroundColor: Colors.red[200],
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }

//   Future<void> uploadImage() async {
//     try {
//       List<form.MultipartFile> fileList = [];
//       for (var image in newImages) {
//         var multipartFile = form.MultipartFile.fromFileSync(
//           image.path,
//           filename: image.name,
//           contentType: MediaType('image', 'jpeg'),
//         );
//         fileList.add(multipartFile);
//       }

//       var formData = form.FormData.fromMap({
//         'title': 'image',
//         'content': 'image multi upload test',
//         'subImage': fileList,
//       });
//       inspect(formData);
//       var res = await dio.patch(
//         '$baseUrl/api/collections/blog/records/${controller.infoData['id']}',
//         data: formData,
//         options: form.Options(
//           headers: {'Content-Type': 'multipart/form-data'},
//         ),
//       );
//       inspect(res.data);

//       // 응답 처리
//       if (res.statusCode! < 399) {
//         Get.snackbar(
//           '저장',
//           '저장에 성공했습니다.',
//           backgroundColor: Colors.blue[100]!,
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       } else {
//         Get.snackbar(
//           '실패',
//           '실패했습니다. 관리자에게 문의하세요',
//           backgroundColor: Colors.red[100]!,
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//       Get.off(PicTestPage());
//       fileList.clear(); // 업로드 후 리스트 초기화
//       setState(() {});
//     } catch (e) {
//       printRed('uploadImage Error Message : $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     PicTextDetailPageController controller =
//         Get.put(PicTextDetailPageController());
//     Map info = controller.infoData;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Page'),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           onPressed: () {
//             Get.offAll(PicTestPage());
//           },
//           icon: Icon(
//             Icons.arrow_back_ios_new,
//           ),
//         ),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               info['title'] ?? '',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(info['content'] ?? ''),
//             SizedBox(
//               height: 10,
//             ),
//             Wrap(
//               children: [
//                 ...currentImages
//                     .where((image) => !toBeDeleted.contains(image))
//                     .map((imageUrl) => Stack(
//                           alignment: Alignment.topRight,
//                           children: [
//                             Image.network(
//                                 '$baseUrl/api/files/${controller.infoData['collectionId']}/${controller.infoData['id']}/$imageUrl',
//                                 width: 80,
//                                 height: 80),
//                             IconButton(
//                                 icon: Icon(Icons.remove_circle,
//                                     color: Colors.red),
//                                 onPressed: () => markForDeletion(imageUrl)),
//                           ],
//                         )),
//                 ...newImages.map((imageFile) =>
//                     Image.file(File(imageFile.path), width: 80, height: 80)),
//                 IconButton(icon: Icon(Icons.add_a_photo), onPressed: pickImage),
//               ],
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   saveChanges();
//                 },
//                 child: Text('수정'))
//           ],
//         ),
//       ),
//     );
//   }
// }
