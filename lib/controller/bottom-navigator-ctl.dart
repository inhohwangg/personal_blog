import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/pages/home-page.dart';
import 'package:personal_blog/pages/setting-pg.dart';
import 'package:personal_blog/pages/word-write-page.dart';

import '../global/g_print.dart';

class BottomNavigatorController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxList pageList = [
    HomePage(),
    WordWritePage(),
    SettingPage(),
  ].obs;

  onItemTapped(index) {
    printYellow(index);
    selectedIndex.value = index;
  }

  Widget get currentPage => pageList[selectedIndex.value];
}
