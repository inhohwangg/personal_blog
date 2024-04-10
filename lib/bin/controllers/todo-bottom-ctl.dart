import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/bin/pages/todo-history-pg.dart';
import 'package:personal_blog/bin/pages/todo-main-pg.dart';
import 'package:personal_blog/bin/pages/todo-setting-pg.dart';

class TodoBottomController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxList pageList = [
    TodoPageMainPage(),
    TodoHistoryPage(),
    TodoSettingPage(),
  ].obs;

  onItemTapped(index) {
    selectedIndex.value = index;
  }

  Widget get currentPage => pageList[selectedIndex.value];
}
