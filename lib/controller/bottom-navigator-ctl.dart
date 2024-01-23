import 'package:get/get.dart';
import 'package:personal_blog/pages/home-page.dart';
import 'package:personal_blog/pages/word-list.dart';

class BottomNavigatorController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxList pageList = [
    HomePage(),
    WordListPage(),
  ].obs;
}
