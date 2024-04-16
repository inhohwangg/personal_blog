import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:personal_blog/bin/controllers/todo-bottom-ctl.dart';

class TodoBottom extends GetView<TodoBottomController> {
  TodoBottom({super.key});

  @override
  Widget build(BuildContext context) {
    TodoBottomController controller = Get.put(TodoBottomController());
    return Scaffold(
      body: Obx(() => controller.currentPage),
      bottomNavigationBar: Obx(
        () => Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            // highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedItemColor: Get.theme.primaryColor,
            unselectedItemColor: Get.theme.primaryColor.withOpacity(0.4),
            items: [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.listCheck),
                label: '현황',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.clockRotateLeft),
                label: '완료',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.maps_home_work_outlined,
                ),
                label: '설정',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            onTap: (index) => controller.onItemTapped(index),
          ),
        ),
      ),
    );
  }
}
