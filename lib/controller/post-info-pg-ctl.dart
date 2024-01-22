import 'dart:developer';

import 'package:get/get.dart';

class PostInfoPageController extends GetxController {
  var testData = Get.arguments;

  test() {
    inspect(testData);
  }
}
