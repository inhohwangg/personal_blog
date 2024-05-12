// import 'dart:developer';

// import 'package:dio/dio.dart' as form;
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../global/g_dio.dart';
// import '../../global/g_print.dart';
// import '../../global/g_value.dart';

// class PicTestPageController extends GetxController {
//   final ImagePicker picker = ImagePicker();
//   //* 카메라에서 촬영한 이미지 저장할 변수
//   XFile? cameraImage;
//   //* 갤러리에서 가져온 이미지 저장할 변수 
//   RxList gelImage = [].obs;
//   //* api 로 가져온 사진을 보여주기 위한 변수
//   RxList images = [].obs;

//   Future<void> picImage() async {
//     cameraImage = await picker.pickImage(source: ImageSource.camera);
//     images.add(cameraImage);
//     inspect(images);
//     print(images[0].file.path);
//   }

//   getImage() {}

//   imageUpload() async {
//     try {
//       form.FormData formData = form.FormData.fromMap({
//         'title': 'image',
//         'content': 'image multi upload test',
//         'subImage': '',
//       });

//       var res = await dio.post(
//         '$baseUrl/api/collections/blog/records',
//         options: form.Options(
//           headers: {
//             'Content-Type': 'multipart/form-data',
//           },
//         ),
//         data: formData,
//       );
//     } catch (e) {
//       printRed('Error Message : $e');
//     }
//   }
// }
