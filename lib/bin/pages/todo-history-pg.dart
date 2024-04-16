import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/bin/controllers/todo-pg-ctl.dart';

class TodoHistoryPage extends GetView {
  TodoHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    TodoPageController controller = Get.put(TodoPageController());
    return Scaffold(
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
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal),
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
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () {
                          return controller.todoDataGet();
                        },
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemCount: controller.todayDataList.length,
                          itemBuilder: (context, index) {
                            Map item = controller.todayDataList[index];
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue[600]!.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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
                            );
                          },
                        ),
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
    );
  }
}
