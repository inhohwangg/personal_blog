import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:personal_blog/controller/shop/a-home-page-controller.dart';

AhomePageController controller = Get.put(AhomePageController());

comunity() {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 75,
          child: Center(
            child: Text(
              '커뮤니티',
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4D2E1C),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(controller.comunityCategory.length,
                (int index) {
              return RawChip(
                label: SizedBox(
                  width: 60,
                  child: Text(
                    controller.comunityCategory[index],
                    textAlign: TextAlign.center,
                  ),
                ),
                selected: controller.selectedCategoryIndex.value == index,
                onSelected: (bool selected) {
                  controller.selectedCategoryIndex.value = selected ? index : 0;
                },
                selectedColor: Color(0xFF8B5E3C), // 선택된 상태의 색상
                backgroundColor: Colors.white, // 기본 배경색
                labelStyle: TextStyle(
                    color: controller.selectedCategoryIndex.value == index
                        ? Colors.white
                        : Color(0xFF8B5E3C)), // 선택 여부에 따른 텍스트 색상
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: controller.selectedCategoryIndex.value == index
                        ? Color(0xFF8B5E3C)
                        : Color(0xFFD9D9D9),
                  ),
                ),
                showCheckmark: false,
              );
            }),
          ),
        ),
        if (controller.selectedCategoryIndex.value == 0) notices(),
        if (controller.selectedCategoryIndex.value == 1) helpCenter(),
        Gap(20),
      ],
    ),
  );
}

notices() {
  // getPageItems 함수 정의
  List getPageItems() {
    int startIndex =
        (controller.currentPage.value - 1) * controller.itemsPerPage.value;
    int endIndex = startIndex + controller.itemsPerPage.value;
    endIndex = endIndex > controller.eventList.length
        ? controller.eventList.length
        : endIndex;
    return controller.eventList.sublist(startIndex, endIndex);
  }

  return Container(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFF5F5F5)),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 16,
                      color: Color(0xFF646464),
                    ),
                    Gap(10),
                    Text(
                      '검색하세요',
                      style: TextStyle(fontSize: 12, color: Color(0xFF646464)),
                    ),
                    Gap(30),
                  ],
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xFFD9D9D9)),
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton(
                  items: controller.dropDownMenuList
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.dropDownValue.value = value.toString();
                  },
                  icon: Padding(
                    padding: EdgeInsets.only(left: 10), // 아이콘과 텍스트 사이 간격 조정
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                  value: controller.dropDownValue.value,
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  isDense: true,
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              border: Border.symmetric(
                  horizontal: BorderSide(width: 1, color: Color(0xFFD9D9D9))),
              // border: Border(
              //     top: BorderSide(width: 1, color: Color(0xFFF5F5F5),),
              //     bottom: BorderSide(width: 1, color: Color(0xFFF5F5F5))),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Center(
                      child: Text(
                    '제목',
                    style: TextStyle(fontSize: 12, color: Color(0xFF343434)),
                  )),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                      child: Text('등록일',
                          style: TextStyle(
                              fontSize: 12, color: Color(0xFF343434)))),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height * 0.5,
          child: ListView.builder(
            itemCount: getPageItems().length,
            itemBuilder: (context, index) {
              var item = getPageItems()[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9))),
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Text(item['title']
                            // controller.eventList[index]['title'],
                            ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                            // controller.eventList[index]['date'],
                            item['date']),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Gap(10),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 왼쪽 화살표
                GestureDetector(
                  onTap: () {
                    controller.previousPageGroup();
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
                Gap(15),
                // 페이지 번호들
                ...List<Widget>.generate(controller.pageGroupSize.value,
                    (index) {
                  int pageNumber = controller.pageGroupStart.value + index;
                  if (pageNumber <= controller.totalPages.value) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          controller.changePage(pageNumber);
                        },
                        child: Text(
                          '$pageNumber',
                          style: TextStyle(
                            fontWeight:
                                controller.currentPage.value == pageNumber
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color: controller.currentPage.value == pageNumber
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(); // 페이지 번호가 전체 페이지 수를 초과하면 빈 컨테이너 반환
                  }
                }),
                Gap(15),
                // 오른쪽 화살표
                GestureDetector(
                  onTap: () {
                    controller.nextPageGroup();
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            )),
        Gap(50)
      ],
    ),
  );
}

helpCenter() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 첫 번째 Chip
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF9F9F9),
                ),
                child: Chip(
                  avatar: Icon(Icons.local_shipping_outlined,
                      color: Color(0xFF646464)),
                  label: Text(
                    '배송문의',
                    style: TextStyle(color: Color(0xFF343434), fontSize: 12),
                  ),
                  backgroundColor: Color(0xFFF9F9F9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // borderRadius 설정
                      side: BorderSide.none),
                  side: BorderSide.none,
                ),
              ),
            ),
            SizedBox(width: 20), // 두 Chip 사이 공간
            // 두 번째 Chip
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF9F9F9),
                ),
                child: Chip(
                  avatar: SvgPicture.asset('assets/logo/nutrition.svg'),
                  label: Text(
                    '상품문의',
                    style: TextStyle(color: Color(0xFF343434), fontSize: 12),
                  ),
                  backgroundColor: Color(0xFFF9F9F9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10), // Row 간 간격
        // 두 번째 Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 첫 번째 Chip
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF9F9F9),
                ),
                child: Chip(
                  avatar: Icon(Icons.contact_support_outlined,
                      color: Color(0xFF646464)),
                  label: Text(
                    '자주 묻는 질문',
                    style: TextStyle(color: Color(0xFF343434), fontSize: 12),
                  ),
                  backgroundColor: Color(0xFFF9F9F9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // borderRadius 설정
                      side: BorderSide.none),
                  side: BorderSide.none,
                ),
              ),
            ),
            SizedBox(width: 20), // 두 Chip 사이 공간
            // 두 번째 Chip
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF9F9F9),
                ),
                child: Chip(
                  avatar: Icon(Icons.autorenew_outlined, color: Color(0xFF646464)),
                  label: Text(
                    '반품 / 교환 문의',
                    style: TextStyle(color: Color(0xFF343434), fontSize: 12),
                  ),
                  backgroundColor: Color(0xFFF9F9F9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        // 세 번째 Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 첫 번째 Chip
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF9F9F9),
                ),
                child: Chip(
                  avatar: Icon(Icons.sell_outlined, color: Color(0xFF646464)),
                  label: Text(
                    '기타 문의',
                    style: TextStyle(color: Color(0xFF343434), fontSize: 12),
                  ),
                  backgroundColor: Color(0xFFF9F9F9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // borderRadius 설정
                      side: BorderSide.none),
                  side: BorderSide.none,
                ),
              ),
            ),
            SizedBox(width: 20), // 두 Chip 사이 공간
            // 두 번째 Chip
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Chip(
                  avatar: Icon(
                    Icons.autorenew_outlined,
                    color: Colors.transparent,
                  ),
                  label: Text(
                    '반품 / 교환 문의',
                    style: TextStyle(color: Colors.transparent, fontSize: 12),
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        Gap(30),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFAA9E9E).withOpacity(0.7),width: 1.5,)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'BEST 자주 묻는 질문',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height * 0.5,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Color(0xFFD9D9D9).withOpacity(0.5)))
                ),
                child: Row(
                  children: [
                    Text('Q', style: TextStyle(fontSize: 18,color: Color(0xFF343434),fontWeight: FontWeight.w500),),
                    Gap(10),
                    Text('[배송문의] 오늘 주문하면 얼마나 걸리나요?', style: TextStyle(fontSize: 12,color: Color(0xFF343434)))
                  ],
                ),
              );
          },),
        )
      ],
    ),
  );
}
