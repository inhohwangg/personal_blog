import 'package:get/get.dart';

class AhomePageController extends GetxController {
  RxList farmInfoList = ['farm_info3.png', 'farm_info4.png'].obs;
  RxList farmInfoList2 = ['carousel_image3.jpg', 'carousel_image4.jpg'].obs;
  RxList farmInfoTextList1 = ['정직한 사과', '싱싱한 사과'].obs;
  RxList farmInfoTextList2 = ['나의 가족이 먹는다는 마음으로', '애플 하이랜드는 GAP 인증을 받았으며'].obs;
  RxList farmInfoTextList3 =
      ['언제나 정직하게 좋은 사과만을 골라 드립니다.', '건강하고 싱싱한 사과만을 고집합니다.'].obs;
  RxInt carouselIndex1 = 0.obs;
  RxInt carouselIndex2 = 0.obs;
  RxInt bottomIndex = 0.obs;
  RxInt tabIndex = 0.obs;
  RxList category = ["전체", "가정용", "선물용"].obs;
  RxList comunityCategory = ["전체", "가정용", "선물용"].obs;
  RxList tabs = ["낮은가격", "높은가격", "판매순위", "상품평"].obs;
  RxList dropDownMenuList = ['전체보기', '일부보기', '하나보기'].obs;
  RxString dropDownValue = '전체보기'.obs;
  RxInt selectedCategoryIndex = 0.obs;
  RxInt selectedIndex = 0.obs;
  RxInt currentPage = 1.obs; // 현재 페이지
  RxInt itemsPerPage = 6.obs; // 페이지당 항목 수
  RxList eventList = [
    {'title': '[이벤트] 당첨자 명단 확인', 'date': '24.09.03'},
    {'title': '[이벤트] 당첨자 명단 확인', 'date': '24.09.03'},
    {'title': '[이벤트] 당첨자 명단 확인', 'date': '24.09.03'},
    {'title': '[이벤트] 당첨자 명단 확인', 'date': '24.09.03'},
    {'title': '[이벤트] 당첨자 명단 확인', 'date': '24.09.03'},
    {'title': '[이벤트] 당첨자 명단 확인', 'date': '24.09.03'},
    {'title': '[이벤트] 당첨자 명단 확인1', 'date': '24.09.04'},
    {'title': '[이벤트] 당첨자 명단 확인1', 'date': '24.09.04'},
    {'title': '[이벤트] 당첨자 명단 확인1', 'date': '24.09.04'},
    {'title': '[이벤트] 당첨자 명단 확인1', 'date': '24.09.04'},
    {'title': '[이벤트] 당첨자 명단 확인1', 'date': '24.09.04'},
    {'title': '[이벤트] 당첨자 명단 확인1', 'date': '24.09.04'},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    tabIndex.value = 0;
  }
}
