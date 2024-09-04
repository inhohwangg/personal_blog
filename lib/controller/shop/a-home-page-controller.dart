import 'package:get/get.dart';

class AhomePageController extends GetxController {
  RxList farmInfoList = ['farm_info3.png','farm_info4.png'].obs;
  RxList farmInfoTextList1 = ['정직한 사과','싱싱한 사과'].obs;
  RxList farmInfoTextList2 = ['나의 가족이 먹는다는 마음으로','애플 하이랜드는 GAP 인증을 받았으며'].obs;
  RxList farmInfoTextList3 = ['언제나 정직하게 좋은 사과만을 골라 드립니다.','건강하고 싱싱한 사과만을 고집합니다.'].obs;
  RxInt carouselIndex = 0.obs;
  RxInt bottomIndex = 0.obs;
}