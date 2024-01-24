import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/controller/bottom-navigator-ctl.dart';
import 'package:personal_blog/global/g_dio.dart';
import 'package:personal_blog/global/g_value.dart';

import 'word-list-page-controller.dart';

class WordWritePageController extends GetxController {
  late TextEditingController title = TextEditingController();
  late TextEditingController content = TextEditingController();
  BottomNavigatorController bottomNavigatorController =
      Get.put(BottomNavigatorController());
  WordListPageController wordListPageController =
      Get.put(WordListPageController());
  DateTime formattedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

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
          'selectDate': formattedDate.toString(),
        },
      );
      if (res.statusCode == 400) {
        throw Error();
      } else {
        title.text = '';
        content.text = '';
        bottomNavigatorController.selectedIndex.value = 0;
        wordListPageController.getData();
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
  }
}
