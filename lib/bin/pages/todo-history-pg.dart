import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/bin/controllers/todo-pg-ctl.dart';

class TodoHistoryPage extends GetView {
  TodoHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    TodoPageController controller = Get.put(TodoPageController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Todo 이력',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.dayMinus();
                              },
                              icon: Icon(Icons.arrow_back_ios_new)),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                controller.now.toString().split(' ')[0],
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                controller.dayPlus();
                              },
                              icon: Icon(Icons.arrow_forward_ios)),
                        ],
                      ),
                      Expanded(  // 추가된 Expanded
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TabBar(
                                dividerColor: Colors.transparent,
                                tabs: [
                                Tab(text: '미완료 이력'),
                                Tab(text: '완료 이력'),
                              ]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(  // TabBarView를 감싸는 Expanded
                              child: TabBarView(children: [
                                todoDone(controller),
                                todoYet(controller)
                              ])
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }

  todoDone(controller) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          return controller.todoDataGet();
        },
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: controller.todayDataList.length,
          itemBuilder: (context, index) {
            Map item = controller.todayDataList[index];
            return item['is_completed'] ? Container(
              decoration: BoxDecoration(color: Colors.blue[900]!.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    item['description'],
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    item['created_at'].split('T')[0].toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ) : SizedBox();
          },
        ),
      ),
    );
  }

  todoYet(controller) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          return controller.todoDataGet();
        },
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: controller.todayDataList.length,
          itemBuilder: (context, index) {
            Map item = controller.todayDataList[index];
            return item['is_completed'] == false ? Container(
              decoration: BoxDecoration(color: Colors.blue[900]!.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    item['description'],
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    item['created_at'].split('T')[0].toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ) : SizedBox();
          },
        ),
      ),
    );
  }
}
