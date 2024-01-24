import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/controller/bottom-navigator-ctl.dart';

class BottomNavigator extends GetView<BottomNavigatorController> {
  BottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavigatorController controller = Get.put(BottomNavigatorController());
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.25,
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey.withOpacity(
                0.25,
              ),
            ),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Scaffold(
              body: Obx(
                () => controller.currentPage,
              ),
              bottomNavigationBar: Obx(
                () => BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: true,
                  selectedItemColor: Get.theme.primaryColor,
                  unselectedItemColor: Get.theme.primaryColor.withOpacity(0.5),
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: '대시보드',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.post_add,
                      ),
                      label: '글쓰기',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.maps_home_work_outlined,
                      ),
                      label: '게시글 목록',
                    ),
                  ],
                  currentIndex: controller.selectedIndex.value,
                  onTap: (index) => controller.onItemTapped(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
