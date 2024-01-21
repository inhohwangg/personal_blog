import 'dart:developer';

import 'package:get/get.dart';
import 'package:personal_blog/global/g_dio.dart';
import 'package:personal_blog/global/g_print.dart';
import 'package:personal_blog/global/g_value.dart';

class WordListPageController extends GetxController {
  RxList postList = [].obs;

  getData() async {
    try {
      postList.clear();
      var res = await dio.get('$baseUrl/api/collections/blog/records');
      postList.addAll(res.data['items']);
      printYellow(postList.length);
      inspect(postList[0]);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
