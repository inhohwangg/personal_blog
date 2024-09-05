import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:personal_blog/global/g_print.dart';

import '../../controller/shop/a-home-page-controller.dart';

class AhomePage extends StatefulWidget {
  const AhomePage({super.key});

  @override
  State<AhomePage> createState() => _AhomePageState();
}

class _AhomePageState extends State<AhomePage> with TickerProviderStateMixin {
  final List<AnimationController> _animationControllers = [];
  final List<Animation<double>> _animations = [];

  AhomePageController controller = Get.put(AhomePageController());

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      _animationControllers.add(AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      ));
      _animations.add(Tween<double>(begin: 1.0, end: 0.7).animate(
        CurvedAnimation(
            parent: _animationControllers[i], curve: Curves.easeInOut),
      ));
    }
  }

  void onItemTapped(int index) {
    print("Tapped on index: $index");
    setState(() {
      for (int i = 0; i < 4; i++) {
        if (i == index) {
          print("Animating icon at index $i");
          _animationControllers[i]
              .forward()
              .then((_) => _animationControllers[i].reverse());
        } else {
          _animationControllers[i].reset();
        }
      }
      controller.bottomIndex.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF5E391F).withOpacity(0.3),
                  image: DecorationImage(
                    image: AssetImage('assets/images/paper.png'),
                    fit: BoxFit.cover,
                    opacity: 0.7,
                  ),
                ),
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Obx(() => Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 10),
                          // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/logo/apple_logo.png'),
                              Gap(10),
                              Text(
                                '애플 하이랜드',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(Icons.search, size: 25),
                                  SizedBox(width: 20),
                                  Icon(Icons.local_mall_outlined, size: 25),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.tabIndex.value = 0;
                                },
                                child: Text(
                                  '과수원 소개',
                                  style: TextStyle(
                                      color: Color(0xFF30180B), fontSize: 15),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.tabIndex.value = 1;
                                },
                                child: Text(
                                  '사과',
                                  style: TextStyle(
                                      color: Color(0xFF30180B), fontSize: 15),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.tabIndex.value = 2;
                                },
                                child: Text(
                                  '사과즙',
                                  style: TextStyle(
                                      color: Color(0xFF30180B), fontSize: 15),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.tabIndex.value = 3;
                                },
                                child: Text(
                                  '오시는 길',
                                  style: TextStyle(
                                      color: Color(0xFF30180B), fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 나머지 Body 내용 추가
                        if (controller.tabIndex.value == 0)
                          appleInfo()
                        else if (controller.tabIndex.value == 1)
                          apple()
                        else if (controller.tabIndex.value == 2)
                          apple()
                        else if (controller.tabIndex.value == 3)
                          appleDirections()
                      ],
                    )),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() => NavigationBarTheme(
            data: NavigationBarThemeData(),
            child: NavigationBar(
              selectedIndex: controller.bottomIndex.value,
              onDestinationSelected: (value) {
                onItemTapped(value);
              },
              destinations: [
                NavigationDestination(
                  icon: ScaleTransition(
                    scale: _animations[0],
                    child: Icon(
                      controller.bottomIndex.value == 0
                          ? Icons.home
                          : Icons.home_outlined,
                    ),
                  ),
                  label: "홈",
                  selectedIcon: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      controller.bottomIndex.value == 0
                          ? Icons.home
                          : Icons.home_outlined,
                    ),
                  ),
                ),
                NavigationDestination(
                  icon: ScaleTransition(
                    scale: _animations[1],
                    child: Icon(controller.bottomIndex.value == 1
                        ? Icons.menu_open
                        : Icons.menu_open_outlined),
                  ),
                  label: "메뉴",
                  selectedIcon: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      controller.bottomIndex.value == 1
                          ? Icons.menu_open
                          : Icons.menu_open_outlined,
                    ),
                  ),
                ),
                NavigationDestination(
                  icon: ScaleTransition(
                    scale: _animations[2],
                    child: Icon(controller.bottomIndex.value == 2
                        ? Icons.feed
                        : Icons.feed_outlined),
                  ),
                  label: "커뮤니티",
                  selectedIcon: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      controller.bottomIndex.value == 2
                          ? Icons.feed
                          : Icons.feed_outlined,
                    ),
                  ),
                ),
                NavigationDestination(
                  icon: ScaleTransition(
                    scale: _animations[3],
                    child: Icon(controller.bottomIndex.value == 3
                        ? Icons.account_circle
                        : Icons.account_circle_outlined),
                  ),
                  label: "마이",
                  selectedIcon: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      controller.bottomIndex.value == 3
                          ? Icons.account_circle
                          : Icons.account_circle_outlined,
                    ),
                  ),
                ),
              ],
            ))),
      ),
    );
  }

  appleInfo() {
    return Container(
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
            height: MediaQuery.of(context).size.height * 0.35,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/apple_image3.png'),
                  Gap(10),
                  Text(
                    '애플 하이랜드는',
                    style: TextStyle(fontSize: 14, color: Color(0xFF30180B)),
                  ),
                  Text(
                    '건강한 사과만을 제공합니다.',
                    style: TextStyle(fontSize: 14, color: Color(0xFF30180B)),
                  ),
                  Gap(10),
                  Text(
                    '남다른 재배 방법을 이용한 사과 생산으로',
                    style: TextStyle(fontSize: 12, color: Color(0xFF4D2E1C)),
                  ),
                  Text(
                    '최소한의 방제로 건강한 사과 생산을 하기 위해 노력합니다.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF4D2E1C)),
                  ),
                ],
              ),
            ),
          ),
          Gap(40),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF271300),
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF271300),
                        ),
                      ),
                      Text(
                        "언제나 소비자에게",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "정직함을 약속합니다.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF271300),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5), // 이미지 둥글게 만들기
                    child: Image.asset(
                      'assets/images/farm_info1.png',
                      // height: 150,
                      // width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '강원도 양구 펀치볼 650고지 청정지역에서 잔류농약',
                  style: TextStyle(color: Color(0xFF646464), fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '걱정 없이 껍질째 먹을 수 있는 건강한 안심 먹거리를',
                  style: TextStyle(color: Color(0xFF646464), fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '위해 노력하는 착한 농부가 있습니다.',
                  style: TextStyle(color: Color(0xFF646464), fontSize: 12),
                ),
              ],
            ),
          ),
          Gap(40),

          //* 두번째 사진
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5), // 이미지 둥글게 만들기
                    child: Image.asset(
                      'assets/images/farm_info2.png',
                      // height: 150,
                      // width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF271300),
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF271300),
                        ),
                      ),
                      Text(
                        "건강하고 안전한 사과",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "생산에 노력합니다.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF271300),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '건강한 사과만을 위해 강원도 양구 펀치볼로 이주했습니다.',
                  style: TextStyle(color: Color(0xFF646464), fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '병충해와 기후온난화에 보다 안전한 지역인 펀치볼은',
                  style: TextStyle(color: Color(0xFF646464), fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '안전한 사과 생산에 최적지입니다.',
                  style: TextStyle(color: Color(0xFF646464), fontSize: 12),
                ),
              ],
            ),
          ),
          Gap(50),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF271300),
            ),
          ),
          Gap(20),
          Center(
            child: Text(
              '애플 하이랜드의',
              style: TextStyle(fontSize: 14, color: Color(0xFF30180B)),
            ),
          ),
          Center(
            child: Text(
              '사과와 사과즙을 소개합니다.',
              style: TextStyle(fontSize: 14, color: Color(0xFF30180B)),
            ),
          ),
          Gap(20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF271300),
            ),
          ),
          Gap(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50), // 이미지 둥글게 만들기
                    child: Image.asset(
                      'assets/images/product_info1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Gap(10),
                  Text(
                    '감홍',
                    style: TextStyle(fontSize: 12, color: Color(0xFF30180B)),
                  ),
                ],
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50), // 이미지 둥글게 만들기
                    child: Image.asset(
                      'assets/images/product_info2.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Gap(10),
                  Text('시나골드',
                      style: TextStyle(fontSize: 12, color: Color(0xFF30180B))),
                ],
              ),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50), // 이미지 둥글게 만들기
                    child: Image.asset(
                      'assets/images/product_info3.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Gap(10),
                  Text('부사',
                      style: TextStyle(fontSize: 12, color: Color(0xFF30180B))),
                ],
              ),
            ],
          ),
          Gap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50), // 이미지 둥글게 만들기
                    child: Image.asset(
                      'assets/images/product_info4.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Gap(10),
                  Text('아리수 / 홍로',
                      style: TextStyle(fontSize: 12, color: Color(0xFF30180B))),
                ],
              ),
              Gap(50),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50), // 이미지 둥글게 만들기
                    child: Image.asset(
                      'assets/images/product_info5.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Gap(10),
                  Text('사과즙',
                      style: TextStyle(fontSize: 12, color: Color(0xFF30180B))),
                ],
              ),
            ],
          ),
          Gap(50),
          //! CarouselSlider 로 변경해야함
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
                        'assets/images/${controller.farmInfoList[index]}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '"${controller.farmInfoTextList1[index]}"',
                                style: TextStyle(
                                  color: Color(0xFFFFFDD7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Gap(10),
                              Text(
                                '${controller.farmInfoTextList2[index]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              // Gap(10),
                              Text(
                                '${controller.farmInfoTextList3[index]}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
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
                controller.carouselIndex.value = index;
              },
            ),
          ),
          Gap(10),
          Obx(
            () => DotsIndicator(
              position: controller.carouselIndex.value,
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
          Gap(75),
          Container(
            child: Center(
              child: Image.asset('assets/images/Frame 113.png'),
            ),
          ),
          Gap(30),
          Center(
              child: Text(
            '노력하는 부지런한 농부가 있는',
            style: TextStyle(fontSize: 14, color: Color(0xFF271300)),
          )),
          Center(
              child: Text(
            '애플 하이랜드의 사과를 맛보세요.',
            style: TextStyle(fontSize: 14, color: Color(0xFF271300)),
          )),
          Gap(75),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/paper.png',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  '고객센터 안내',
                  style: TextStyle(fontSize: 14, color: Color(0xFF30180B)),
                ),
                Gap(10),
                Text(
                  '010 - 3522 - 6848',
                  style: TextStyle(fontSize: 12, color: Color(0xFF646464)),
                ),
                Gap(10),
                Text(
                  '평일  오전 9시 ~ 오후 6시',
                  style: TextStyle(fontSize: 12, color: Color(0xFF646464)),
                ),
                Text(
                  '주말  오전 9시 ~ 오후 6시',
                  style: TextStyle(fontSize: 12, color: Color(0xFF646464)),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: Color(0xFFD9D9D9),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 125,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/paper.png',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  '계좌',
                  style: TextStyle(fontSize: 14, color: Color(0xFF30180B)),
                ),
                Gap(10),
                Text(
                  '농협 352-1748-0007-33 박현수',
                  style: TextStyle(fontSize: 12, color: Color(0xFF646464)),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: Color(0xFFD9D9D9),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 125,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/paper.png',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '주소',
                  style: TextStyle(fontSize: 14, color: Color(0xFF30180B)),
                ),
                Gap(10),
                Text(
                  '강원도 양구군 해안면 만대리 2397',
                  style: TextStyle(fontSize: 12, color: Color(0xFF646464)),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 250,
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
          Gap(30)
        ],
      ),
    );
  }

  apple() {
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
              height: MediaQuery.of(context).size.height * 0.2,
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
              // height: MediaQuery.of(context).size.height * 0.15,
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
                        setState(() {
                          controller.selectedCategoryIndex.value =
                              selected ? index : 0;
                        });
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
              height: MediaQuery.of(context).size.height * 0.05,
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
              height: MediaQuery.of(context).size.height * 0.5,
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

  appleDirections() {
    // return Container(
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //   ),
    //   width: double.infinity,
    //   height: MediaQuery.of(context).size.height * 0.45,
    //   child: Stack(
    //     children: [
    //       // 배경 이미지와 그라데이션을 위한 Stack 사용
    //       Container(
    //         width: double.infinity,
    //         height: MediaQuery.of(context).size.height * 0.45,
    //         decoration: BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage('assets/images/apple_direction_bg.jpg'),
    //             opacity: 0.35,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //       // 이미지 위에 그라데이션 효과 추가
    //       Container(
    //         width: double.infinity,
    //         height: MediaQuery.of(context).size.height * 0.45,
    //         decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //             begin: Alignment.center,
    //             end: Alignment.bottomCenter,
    //             colors: [
    //               Colors.white.withOpacity(0.2),
    //               Colors.white.withOpacity(0.9), // 하단으로 갈수록 흐릿하게
    //             ],
    //           ),
    //         ),
    //       ),
    //       // 텍스트와 이미지 내용들
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Text('부지런한 농부가 있는',
    //               style: TextStyle(fontSize: 12, color: Color(0xFF4D2E1C))),
    //           Text('「 애플 하이랜드 」 이야기',
    //               style: TextStyle(fontSize: 16, color: Color(0xFF30180B))),
    //           Gap(40),
    //           SizedBox(
    //             width: double.infinity,
    //             height: MediaQuery.of(context).size.height * 0.15,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 ClipRRect(
    //                   borderRadius: BorderRadius.circular(5),
    //                   child: Image.asset(
    //                     'assets/images/apple_direction1.jpg',
    //                     fit: BoxFit.cover,
    //                     width: MediaQuery.of(context).size.width * 0.5,
    //                     height: MediaQuery.of(context).size.height * 0.15,
    //                   ),
    //                 ),
    //                 Gap(20),
    //                 ClipRRect(
    //                   borderRadius: BorderRadius.circular(5),
    //                   child: Image.asset(
    //                     'assets/images/apple_direction2.jpg',
    //                     fit: BoxFit.cover,
    //                     width: MediaQuery.of(context).size.width * 0.25,
    //                     height: MediaQuery.of(context).size.height * 0.15,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Gap(20),
    //           Text('최고의 사과농원을 위해',
    //               style: TextStyle(fontSize: 14, color: Color(0xFF4D2E1C))),
    //           Gap(10),
    //           Text('품질 좋은 사과를 생산하기 위해 경북 영천에서',
    //               style: TextStyle(fontSize: 12, color: Color(0xFF4D2E1C))),
    //           Text('강원도 양구 펀치볼로 이주해 사과농원을 만들었습니다.',
    //               style: TextStyle(fontSize: 12, color: Color(0xFF4D2E1C))),
    //           Text('오직 사과만을 생각하며, 사과가 잘 자랄 수 있도록 늘 노력합니다.',
    //               style: TextStyle(fontSize: 12, color: Color(0xFF4D2E1C))),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    return Container(
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
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.9), // 하단으로 갈수록 흐릿하게
          ],
        ),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
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
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/apple_direction1.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                ),
                Gap(20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/apple_direction2.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.15,
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
    );
  }
}
