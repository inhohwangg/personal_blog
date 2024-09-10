import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:personal_blog/controller/shop/a-home-page-controller.dart';

AhomePageController controller = Get.put(AhomePageController());

applePrice() {
    return Obx(
      () => Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/paper.png',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.7),
              ),
              width: double.infinity,
              height: MediaQuery.of(Get.context!).size.height * 0.2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/Frame 113.png'),
                        Gap(20),
                        Text('사과')
                      ],
                    ),
                    Gap(20),
                    Text(
                      '"껍질에도 영양성분이 가득한 애플 하이랜드 사과"',
                      style: TextStyle(fontSize: 14, color: Color(0xFF30180B)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
              // height: MediaQuery.of(Get.context!).size.height * 0.15,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List<Widget>.generate(controller.category.length,
                      (int index) {
                    return RawChip(
                      label: SizedBox(
                        width: 50,
                        child: Text(
                          controller.category[index],
                          textAlign: TextAlign.center,
                        ),
                      ),
                      selected: controller.selectedCategoryIndex.value == index,
                      onSelected: (bool selected) {
                          controller.selectedCategoryIndex.value =
                              selected ? index : 0;
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
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: MediaQuery.of(Get.context!).size.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    List.generate(controller.tabs.length * 2 - 1, (index) {
                  if (index % 2 == 0) {
                    // 탭 텍스트
                    int tabIndex = index ~/ 2;
                    return GestureDetector(
                      onTap: () {
                        controller.selectedIndex.value = tabIndex;
                      },
                      child: Obx(() => Text(
                            controller.tabs[index ~/ 2],
                            style: TextStyle(
                              color: controller.selectedIndex.value == tabIndex
                                  ? Color(0xFF856655)
                                  : Color(0xFF856655).withOpacity(0.6),
                              fontWeight:
                                  controller.selectedIndex.value == tabIndex
                                      ? FontWeight.bold // 선택된 탭만 굵게 표시
                                      : FontWeight.normal,
                            ),
                          )),
                    );
                  } else {
                    // 구분자 |
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "|",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                }),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.white,
              width: double.infinity,
              height: MediaQuery.of(Get.context!).size.height * 0.5,
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                itemBuilder: (context, index) {
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.tabIndex.value == 1)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: AspectRatio(
                            aspectRatio: 1.5 / 1,
                            child: Image.asset(
                              'assets/images/farm_info2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else if (controller.tabIndex.value == 2)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: AspectRatio(
                            aspectRatio: 1.5 / 1,
                            child: Image.asset(
                              'assets/images/product_info6.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      Gap(10),
                      Text(
                        '[애플하이랜드] 사과 종류 01',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF271300)),
                      ),
                      Text(
                        '30,000원',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFFF5A5A)),
                      ),
                    ],
                  ));
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/apple_image.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Gap(10),
                  Text(
                    '회사명:애플 하이랜드 / 대표자: 박현수',
                    style: TextStyle(fontSize: 11, color: Color(0xFF646464)),
                  ),
                  Text(
                    '주소: 강원도 양구군 해안면 만대리 2397 / 대표전화: 010-3522-6848',
                    style: TextStyle(fontSize: 11, color: Color(0xFF646464)),
                  ),
                  Text(
                    '사업자등록번호: 369-95-01729',
                    style: TextStyle(fontSize: 11, color: Color(0xFF646464)),
                  ),
                  Text(
                    'Copyright 애플하이랜드. All Rights Reserved.',
                    style: TextStyle(fontSize: 11, color: Color(0xFF646464)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }