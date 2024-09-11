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
          height: 100,
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
        Gap(10),
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
        Gap(30),
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
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xFFD9D9D9)),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Text('전체보기'),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
