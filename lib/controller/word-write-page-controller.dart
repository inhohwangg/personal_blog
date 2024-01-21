import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/global/g_dio.dart';
import 'package:personal_blog/global/g_value.dart';

class WordWritePageController extends GetxController {
  late TextEditingController title = TextEditingController();
  late TextEditingController content = TextEditingController();

  RxBool writeDone = false.obs;

  writeCreate() async {
    try {
      print(title.text);
      var res = await dio.post(
        '$baseUrl/api/collections/blog/records',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          'title': title.text,
          'content': content.text,
          'selectDate': "2024-01-20 10:00:00.123Z"
        },
      );
      if (res.statusCode == 400) {
        throw Error();
      }
      Get.back();
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }
}
