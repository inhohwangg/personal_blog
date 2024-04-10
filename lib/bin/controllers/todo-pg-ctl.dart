import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../global/g_dio.dart';
import '../../global/g_print.dart';
import '../../global/g_value.dart';

class TodoPageController extends GetxController {
  RxBool isLoading = true.obs;
  RxList todayDataList = [].obs;
  DateTime now = DateTime.now();
  RxBool checkStatus = false.obs;
  RxList todoList = [].obs;
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  todoCreate() async {
    try {
      isLoading.value = false;
      if (title.text.isEmpty) {
        Get.showSnackbar(GetSnackBar(
          title: '생성 실패',
          messageText: Text('제목란이 비어있습니다.'),
          backgroundColor: Color(0xFF297525).withOpacity(0.75),
        ));
      } else if (desc.text.isEmpty) {
        Get.showSnackbar(GetSnackBar(
          title: '생성 실패',
          messageText: Text('설명란이 비어있습니다.'),
          backgroundColor: Color(0xFF297525).withOpacity(0.75),
        ));
      } else {
        var res = await dio.post('$baseUrl/api/todo', data: {
          'title': title.text,
          'description': desc.text,
        });
        if (res.statusCode! < 300) {
          Get.showSnackbar(GetSnackBar(
            title: 'Todo 생성',
            messageText: Text('Todo 데이터 생성 완료'),
            backgroundColor: Color(0xFF297525).withOpacity(0.75),
          ));
        } else {
          Get.showSnackbar(GetSnackBar(
            title: 'Todo 생성 실패',
            messageText: Text('Todo 데이터 생성 실패'),
            backgroundColor: Color(0xFF297525).withOpacity(0.75),
          ));
        }
      }
      await todoDataGet();
      isLoading.value = true;
      update();
    } catch (e) {
      printRed('todo-pg-ctl.dart todoCreate Error Message $e');
    }
  }

  todoDataGet() async {
    todoList.clear();
    todayDataList.clear();
    try {
      var res = await dio.get('$baseUrl/api/todo');
      var todayFormat = DateFormat('yyyy-MM-dd');
      var todayString = todayFormat.format(DateTime.now());

      for (var i = 0; i < res.data.length; i++) {
        if (res.data[i]['created_at'].split('T')[0] == todayString) {
          todayDataList.add(res.data[i]);
        }
      }
      todoList.addAll(res.data);
      inspect(todoList);
      inspect(todayDataList);
    } catch (e) {
      printRed('todo-pg-ctl.dart todoDataGet Error Message $e');
    }
  }

  checkDone(item) async {
    try {
      isLoading.value = false;
      var res = await dio.patch('$baseUrl/api/todo/${item['id']}', data: {
        'is_completed': checkStatus.value,
      });
      if (res.statusCode! < 300) {
        todoDataGet();
        Get.snackbar('${item['title']} 완료', '',
            backgroundColor: Colors.green[300]);
      } else {
        Get.snackbar('${item['title']} 실패', '',
            backgroundColor: Colors.red[300]);
      }
      isLoading.value = true;
    } catch (e) {
      Get.snackbar('${item['title']} 실패', '', backgroundColor: Colors.red[300]);
      printRed('todo-pg-ctl.dart checkDone Error Message :$e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    todoDataGet();
  }
}
