import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:personal_blog/controller/shop/a-home-page-controller.dart';

AhomePageController controller = Get.put(AhomePageController());

appleDirections() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/apple_direction_bg.jpg'),
              opacity: 0.35,
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.9),
                Colors.white.withOpacity(1), // 하단으로 갈수록 흐릿하게
              ],
            ),
          ),
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('부지런한 농부가 있는',
                  style: TextStyle(fontSize: 12, color: Color(0xFF4D2E1C))),
              Text('「 애플 하이랜드 」 이야기',
                  style: TextStyle(fontSize: 16, color: Color(0xFF30180B))),
              Gap(40),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(Get.context!).size.height * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/images/apple_direction1.jpg',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(Get.context!).size.width * 0.5,
                        height: MediaQuery.of(Get.context!).size.height * 0.15,
                      ),
                    ),
                    Gap(20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/images/apple_direction2.jpg',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(Get.context!).size.width * 0.25,
                        height: MediaQuery.of(Get.context!).size.height * 0.15,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(20),
              Text('최고의 사과농원을 위해',
                  style: TextStyle(fontSize: 14, color: Color(0xFF4D2E1C))),
              Gap(10),
              Text('품질 좋은 사과를 생산하기 위해 경북 영천에서',
                  style: TextStyle(fontSize: 12, color: Color(0xFF4D2E1C))),
              Text('강원도 양구 펀치볼로 이주해 사과농원을 만들었습니다.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF4D2E1C))),
              Text('오직 사과만을 생각하며, 사과가 잘 자랄 수 있도록 늘 노력합니다.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF4D2E1C))),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height * 0.15,
          color: Colors.white,
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height * 0.15,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/paper.png',
                ),
                fit: BoxFit.cover,
                opacity: 0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '언제나 발전하는 애플 하이랜드가 되겠습니다.',
                style: TextStyle(fontSize: 14, color: Color(0xFF4D2E1C)),
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/marks.png'),
                  Gap(15),
                  Text('GAP 인증을 받는 "애플 하이랜드"입니다.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF4D2E1C)))
                ],
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height * 0.4,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
            children: [
              Gap(40),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: ClipOval(
                        child: Image.asset('assets/images/award1.jpg',
                            fit: BoxFit.cover),
                      ),
                    ),
                    Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2.5),
                          decoration: BoxDecoration(
                              color: Color(0xFF856655),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '2022',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                        Gap(10),
                        Text(
                          '양구군 우수사과 품평회',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF3D1D00)),
                        ),
                        Gap(10),
                        Row(
                          children: [
                            Text(
                              '부사 품종 부문',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF3D1D00)),
                            ),
                            Gap(25),
                            Text(
                              '장려상',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFF3D1D00)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(40),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end, // 왼쪽 정렬
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2.5),
                          decoration: BoxDecoration(
                              color: Color(0xFF856655),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '2022',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                        Gap(10),
                        Text(
                          '양구군 우수사과 품평회',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF3D1D00)),
                        ),
                        Gap(10),
                        Row(
                          children: [
                            Text(
                              '부사 품종 부문',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF3D1D00)),
                            ),
                            Gap(25),
                            Text(
                              '대상',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFF3D1D00)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(20),
                    Container(
                      width: 100,
                      height: 100,
                      child: ClipOval(
                        child: Image.asset('assets/images/award2.jpg',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          height: MediaQuery.of(Get.context!).size.height * 0.125,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height * 0.45,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '" 언제나 고객님의 행복을 위해',
                style: TextStyle(fontSize: 14, color: Color(0xFF30180B)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('노력하는 ',
                      style: TextStyle(fontSize: 14, color: Color(0xFF30180B))),
                  Text('애플 하이랜드',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF30180B),
                          fontWeight: FontWeight.bold)),
                  Text('가 되겠습니다. "',
                      style: TextStyle(fontSize: 14, color: Color(0xFF30180B))),
                ],
              ),
              Gap(10),
              Text('믿어주시는 고객님께 늘 좋은 품질로 보닫 드리겠습니다.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF30180B))),
              Gap(20),
              CarouselSlider.builder(
                itemCount: controller.farmInfoList.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5), // 이미지 둥글게 만들기
                          child: Image.asset(
                            width: MediaQuery.of(Get.context!).size.width * 0.8,
                            height: MediaQuery.of(Get.context!).size.height * 0.3,
                            'assets/images/${controller.farmInfoList2[index]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '"좋은 품질을 위해"',
                                    style: TextStyle(
                                      color: Color(0xFFFFFDD7),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    controller.carouselIndex2.value = index;
                  },
                ),
              ),
              Gap(10),
              Obx(
                () => DotsIndicator(
                  position: controller.carouselIndex2.value,
                  dotsCount: controller.farmInfoList.length,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    color: Color(0xFFE7E7E7),
                    activeSize: const Size(20.0, 9.0),
                    activeColor: Color(0xFFB59888),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/apple_image3.png',
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
    );
  }