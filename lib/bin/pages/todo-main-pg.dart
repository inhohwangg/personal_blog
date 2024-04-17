import 'dart:developer';

import 'package:flutter/cupertino.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Todo 현황',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        body: Obx(() => controller.isLoading.value == true
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
                    Expanded(
                      flex: 8,
                      child: RefreshIndicator(
                        color: Colors.blue[900]!.withOpacity(0.8),
                        onRefresh: () {
                          return controller.todoDataGet();
                        },
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                          itemCount: controller.todayDataList.length,
                          itemBuilder: (context, index) {
                            Map item = controller.todayDataList[index];
                            return GestureDetector(
                              onTap: () {
                                confirmModal(context, item);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100]!.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['title'],
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                                        ),
                                        Text(
                                          item['description'],
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
                                        ),
                                        Text(
                                          item['created_at'].split('T')[0],
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller.checkStatus.value = true;
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              actionsPadding: EdgeInsets.only(bottom: 10, right: 10),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                              titlePadding: EdgeInsets.zero,
                                              // title: Text(''),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '저장',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text('${item['title']} 를 완료 하시겠습니까?'),
                                                ],
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      borderRadius: BorderRadius.circular(5),
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey[700]!.withOpacity(0.15),
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                                        child: Center(
                                                          child: Text(
                                                            '닫기',
                                                            style: TextStyle(color: Colors.grey[700]!.withOpacity(0.55)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    InkWell(
                                                      borderRadius: BorderRadius.circular(5),
                                                      onTap: () {
                                                        controller.checkDone(item);
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue[200]!.withOpacity(0.5)),
                                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                                        child: Center(
                                                          child: Text(
                                                            '확인',
                                                            style: TextStyle(color: Colors.blue[900]!.withOpacity(0.5), fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: item['is_completed'] == true ? Colors.green[700]!.withOpacity(0.75) : Colors.grey[400]!.withOpacity(0.75),
                                        size: 25,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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
            : SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '해야할 일이 없습니다.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500]!.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        postTodo(context, controller);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue[300]!.withOpacity(0.45)),
                        child: Text('Todo 등록하기'),
                      ),
                    )
                  ],
                ),
              )),
      ),
    );
  }

  postTodo(context, controller) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Todo 만들기'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '제목',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: '제목 입력하기',
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: '설명 입력하기',
                  hintStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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

  confirmModal(context, item) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          actionsPadding: EdgeInsets.only(bottom: 10, right: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // title: Text(item['title']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item['description'],
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '날짜 : ${item['created_at'].split('T')[0]}',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[700]!.withOpacity(0.15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Center(
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.grey[700]!.withOpacity(0.55)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.amber[600]),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Center(
                      child: Text(
                        '수정',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
