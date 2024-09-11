import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:personal_blog/global/g_print.dart';
import 'package:personal_blog/pages/shop/a-directions.dart';
import 'package:personal_blog/pages/shop/a-info.dart';
import 'package:personal_blog/pages/shop/a-price.dart';

import '../../controller/shop/a-home-page-controller.dart';
import 'a-comunity.dart';

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
      controller.tabIndex.value = index + 4;
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
                              horizontal: 10, vertical: 15),
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
                          applePrice()
                        else if (controller.tabIndex.value == 2)
                          applePrice()
                        else if (controller.tabIndex.value == 3)
                          appleDirections()
                        else if (controller.tabIndex.value == 6)
                          comunity()
                      ],
                    )),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() => NavigationBarTheme(
            data: NavigationBarThemeData(backgroundColor: Color(0xFFFCFCFC)),
            child: NavigationBar(
              selectedIndex: controller.bottomIndex.value,
              onDestinationSelected: (value) {
                onItemTapped(value);
                controller.bottomIndex.value = value;
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
}
