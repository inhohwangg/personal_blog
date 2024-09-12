import 'package:flutter/material.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List<Widget>.generate(controller.comunityCategory.length,
              (int index) {
            return RawChip(
              label: SizedBox(
                width: 50,
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
        Gap(20),
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
            itemCount: controller.itemsPerPage.value,
            itemBuilder: (context, index) {
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
                        child: Text(
                          controller.eventList[index]['title'],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          controller.eventList[index]['date'],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back_ios),
            Gap(15),
            Text('1'),
            Gap(15),
            Text('2'),
            Gap(15),
            Text('3'),
            Gap(15),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
        Gap(50)
      ],
    ),
  );
}
