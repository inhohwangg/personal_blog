import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../global/g_dio.dart';
import '../../global/g_print.dart';
import '../../global/g_value.dart';

class TodoPageController extends GetxController {
  RxBool isLoading = true.obs;
  RxList todayDataList = [].obs;
  Rx<DateTime> now = DateTime.now().obs;
  RxBool checkStatus = false.obs;
  RxList todoList = [].obs;
  RxList todoSortData = [].obs;
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  DateTime convertUtcToKst(String utcDateString) {
    DateTime utcDate = DateTime.parse(utcDateString);
    // UTC+9 시간대로 변환
    DateTime kstDate = utcDate.add(Duration(hours: 9));
    return kstDate;
  }

  String formDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss', 'ko_KR').format(dateTime);
  }

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
          title.clear();
          desc.clear();
          Get.showSnackbar(GetSnackBar(
            title: 'Todo 생성',
            messageText: Text(
              'Todo 데이터 생성 완료',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFF297525).withOpacity(0.75),
            duration: Duration(seconds: 2),
            margin: EdgeInsets.only(top: 10),
          ));
        } else {
          Get.showSnackbar(GetSnackBar(
            title: 'Todo 생성 실패',
            messageText: Text('Todo 데이터 생성 실패'),
            backgroundColor: Colors.red[300]!.withOpacity(0.5),
            duration: Duration(seconds: 2),
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
      var todayString =
          todayFormat.format(DateTime.now().add(Duration(hours: 9)));

      for (var i = 0; i < res.data.length; i++) {
        var item = res.data[i];
        DateTime utcTime = DateTime.parse(item['created_at']);
        DateTime kstTime = utcTime.add(Duration(hours: 9));
        item['created_at'] = kstTime.toIso8601String();

        if (res.data[i]['created_at'].split('T')[0] ==
            now.toString().split(' ')[0]) {
          todayDataList.add(res.data[i]);
        }
      }
      todoList.addAll(res.data);
    } catch (e) {
      printRed('todo-pg-ctl.dart todoDataGet Error Message $e');
    }
  }

  dayTodoList() async {
    todayDataList.clear();
    try {
      for (var i = 0; i < todoList.length; i++) {
        if (now.toString().split(' ')[0] ==
            todoList[i]['created_at'].split('T')[0]) {
          todayDataList.add(todoList[i]);
        }
      }
    } catch (e) {
      printRed('todo-pg-ctl.dart dayTodoList Error Message : $e');
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

  dayPlus() {
    now.value = now.value.add(Duration(days: 1));
    dayTodoList();
    update();
  }

  dayMinus() {
    now.value = now.value.subtract(Duration(days: 1));
    dayTodoList();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    todoDataGet();
  }
}
