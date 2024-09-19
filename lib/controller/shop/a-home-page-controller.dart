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
  RxList comunityCategory = ["공지사항", "고객센터", "상품후기"].obs;
  RxList tabs = ["낮은가격", "높은가격", "판매순위", "상품평"].obs;
  RxList dropDownMenuList = ['전체보기', '일부보기', '하나보기'].obs;
  RxString dropDownValue = '전체보기'.obs;
  RxInt selectedCategoryIndex = 0.obs;
  RxInt selectedIndex = 0.obs;
  RxInt itemsPerPage = 6.obs; // 페이지당 항목 수
  RxInt currentPage = 1.obs; // 현재 페이지
  RxInt totalItems = 100.obs; // 전체 페이지 수
  RxInt totalPages = 1.obs; // 전체 페이지 수
  RxInt pageGroupSize = 3.obs; // 한번에 표시할 페이지 번호 수
  RxInt pageGroupStart = 1.obs; // 현재 페이지 그룹의 시작 페이지 번호
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
    {'title': '[이벤트] 당첨자 명단 확인2', 'date': '24.09.05'},
    {'title': '[이벤트] 당첨자 명단 확인2', 'date': '24.09.05'},
    {'title': '[이벤트] 당첨자 명단 확인2', 'date': '24.09.05'},
    {'title': '[이벤트] 당첨자 명단 확인2', 'date': '24.09.05'},
    {'title': '[이벤트] 당첨자 명단 확인2', 'date': '24.09.05'},
    {'title': '[이벤트] 당첨자 명단 확인2', 'date': '24.09.05'},
    {'title': '[이벤트] 당첨자 명단 확인3', 'date': '24.09.06'},
    {'title': '[이벤트] 당첨자 명단 확인3', 'date': '24.09.06'},
    {'title': '[이벤트] 당첨자 명단 확인3', 'date': '24.09.06'},
    {'title': '[이벤트] 당첨자 명단 확인3', 'date': '24.09.06'},
    {'title': '[이벤트] 당첨자 명단 확인3', 'date': '24.09.06'},
    {'title': '[이벤트] 당첨자 명단 확인3', 'date': '24.09.06'},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    tabIndex.value = 0;
    totalItems.value = eventList.length;
    totalPages.value = (totalItems.value / itemsPerPage.value).ceil();
  }

  // 페이지 변경 함수
  void changePage(int page) {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
    }
  }

  // 페이지 그룹 변경 함수
  void nextPageGroup() {
    int newStart = pageGroupStart.value + pageGroupSize.value;
    if (newStart <= totalPages.value) {
      pageGroupStart.value = newStart;
      currentPage.value = pageGroupStart.value;
    } else {
      pageGroupStart.value = ((totalPages.value = 1) ~/ pageGroupSize.value) * pageGroupSize.value + 1;
      currentPage.value = pageGroupStart.value;
    }
  }

   void previousPageGroup() {
    int newStart = pageGroupStart.value - pageGroupSize.value;
    if (newStart >= 1) {
      pageGroupStart.value = newStart;
      currentPage.value = pageGroupSize.value; // 페이지 그룹의 첫 번쨰 페이지로 이동
    } else {
      pageGroupStart.value = 1;
      currentPage.value = 1; // 첫 번째 페이지로 이동
    }
  }
}
