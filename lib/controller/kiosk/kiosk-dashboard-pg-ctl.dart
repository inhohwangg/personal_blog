import 'package:get/get.dart';

class KioskDashboardPageController extends GetxController {
  RxList textList = [
    '맛있는 먹거리가 가득한 재미있는 전통 시장',
    '마음을 담은 AI 의료 지식!',
    '이만한 효자없다 스쿼트!',
    // '기분까지 편안한 타다 시그니처 향',
  ].obs;

  RxList imageList = [
    'assets/store.png',
    'assets/medi.jpg',
    'assets/squat.png',
  ].obs;
}