import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:personal_blog/bin/controllers/todo-pg-ctl.dart';

class TodoPageMainPage extends GetView {
  TodoPageMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    TodoPageController controller = Get.put(TodoPageController());
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoList'),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       postTodo(context, controller);
        //     },
        //     icon: FaIcon(
        //       FontAwesomeIcons.penToSquare,
        //       color: Colors.blue[800]!.withOpacity(0.7),
        //     ),
        //   ),
        // ],
      ),
      body: Obx(
        () => controller.isLoading.value == true
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ListView.builder(
                        itemCount: controller.todoList.length,
                        itemBuilder: (context, index) {
                          Map item = controller.todoList[index];
                          return item['is_completed'] == false
                              ? GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          titlePadding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          actionsPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          title: Text(item['title']),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                item['description'],
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                              Text(
                                                '날짜 : ${item['created_at'].split('T')[0]}',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text('확인')),
                                            TextButton(
                                                onPressed: () {},
                                                child: Text('수정')),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100]!.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['title'],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                            Text(
                                              item['description'],
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                            Text(
                                              item['created_at'].split('T')[0],
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.checkStatus.value = true;
                                            controller.checkDone(item);
                                          },
                                          icon: Icon(
                                            Icons.check_circle_outline_outlined,
                                            color: Colors.blue[400]!
                                                .withOpacity(0.75),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox();
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                postTodo(context, controller);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue[300]!.withOpacity(0.5),
                                ),
                                width: 60,
                                height: 60,
                                child: Center(
                                  child: FaIcon(FontAwesomeIcons.pen),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  postTodo(context, controller) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Todo 만들기'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '제목',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: '제목 입력하기',
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1, color: Color(0xFFAAAAAA)),
                  ),
                ),
                controller: controller.title,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '설명',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: '설명 입력하기',
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                ),
                controller: controller.desc,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('취소')),
            TextButton(
                onPressed: () {
                  controller.todoCreate();
                  Get.back();
                },
                child: Text('확인')),
          ],
        );
      },
    );
  }
}
