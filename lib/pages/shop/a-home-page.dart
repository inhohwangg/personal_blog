import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:personal_blog/pages/shop/a-directions.dart';
import 'package:personal_blog/pages/shop/a-info.dart';
import 'package:personal_blog/pages/shop/a-price.dart';

import '../../controller/shop/a-home-page-controller.dart';
import 'a-comunity.dart';
import 'a-mypage.dart';

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
      print(controller.tabIndex.value);
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
                                  controller.bottomIndex.value = 0;
                                },
                                child: Text(
                                  '브랜드 스토리',
                                  style: TextStyle(
                                      color: Color(0xFF30180B), fontSize: 15),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.tabIndex.value = 1;
                                  controller.bottomIndex.value = 0;
                                },
                                child: Text(
                                  '과일 소개',
                                  style: TextStyle(
                                      color: Color(0xFF30180B), fontSize: 15),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.tabIndex.value = 2;
                                  controller.bottomIndex.value = 0;
                                },
                                child: Text(
                                  '오시는 길',
                                  style: TextStyle(
                                      color: Color(0xFF30180B), fontSize: 15),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.tabIndex.value = 3;
                                  controller.bottomIndex.value = 0;
                                },
                                child: Text(
                                  '과일 판매',
                                  style: TextStyle(
                                      color: Color(0xFF30180B), fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 나머지 Body 내용 추가
                        if (controller.tabIndex.value == 0 || controller.tabIndex.value == 4)
                          appleInfo()
                        else if (controller.tabIndex.value == 1)
                          applePrice()
                        else if (controller.tabIndex.value == 2)
                          applePrice()
                        else if (controller.tabIndex.value == 3)
                          appleDirections()
                        else if (controller.tabIndex.value == 6)
                          comunity()
                        else if (controller.tabIndex.value == 7)
                          mypage()
                        else if (controller.tabIndex.value == 8)
                          privateData()
                      ],
                    )),
              ),
            ],
          ),
        ),
        drawer: 
        Drawer(
          backgroundColor: Color(0xFFFCFCFC),
          width: 200,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('마이페이지',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFF4D2E1C)),),
                ),
              ),
              // Gap(10),
              Divider(
                height: 1,
                color: Color(0xFFC8C8C8),
              ),
              Gap(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('개인정보 수정',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xFF343434)),),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  children: [
                    Text('주문내역 관리',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xFF343434)),),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.5,vertical: 2.5),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF9090),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(child: Text('7',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,color: Colors.white),)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('쇼핑몰 관리',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xFF343434)),),
                ),
              ),
              Obx(() => GestureDetector(
                onTap: () {
                  print(controller.isExpanded.value);
                  controller.isExpanded.value == false
                      ? controller.isExpanded.value = true
                      : controller.isExpanded.value = false;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                 
                  child: Row(
                    children: [
                      Text('상품 관리'),
                      Spacer(),
                      Icon(controller.isExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),) ,
              Obx(
                () => AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  child: controller.isExpanded.value
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFFAFAFA),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("- 사과", style: TextStyle(fontSize: 14)),
                              SizedBox(height: 20),
                              Text("- 사과즙", style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        )
                      : SizedBox.shrink(), // 닫혔을 때는 빈 공간으로 처리
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('문의',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xFF343434)),),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('자주 묻는 질문',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xFF343434)),),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('공지사항',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xFF343434)),),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text('상품후기',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xFF343434)),),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() => NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: Color(0xFFFCFCFC),
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return TextStyle(
                    color: Color(0xFF56311C),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  );
                }
                return TextStyle(
                  color: Color(0xFF343434).withOpacity(0.45),
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                );
              }),
              iconTheme: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return IconThemeData(
                    color: Color(0xFF56311C),
                    size: 24,
                  );
                }
                return IconThemeData(
                  color: Color(0xFF343434).withOpacity(0.45),
                  size: 24,
                );
              }),
              indicatorColor: Colors.transparent,
            ),
            child: NavigationBar(
              selectedIndex: controller.bottomIndex.value,
              backgroundColor: Color(0xFFFCFCFC),
              indicatorColor: Colors.transparent, // 선택된 항목의 배경색을 투명하게
              onDestinationSelected: (value) {
                onItemTapped(value);
                controller.bottomIndex.value = value;
              },
              destinations: [
                NavigationDestination(
                  icon: ScaleTransition(
                    scale: _animations[0],
                    child: Icon(
                      Icons.home_outlined,
                    ),
                  ),
                  label: "홈",
                  selectedIcon: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.home_outlined,
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


class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          heightFactor: 0.75, // 화면 높이의 50%로 설정
          widthFactor: 0.5,  // 화면 너비의 80%로 설정
          child: Material(
            elevation: 0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    '헤더',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('홈'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                // 추가적인 ListTile 또는 위젯들
              ],
            ),
          ),
        ),
      ),
    );
  }
}
