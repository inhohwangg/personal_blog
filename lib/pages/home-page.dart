import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/controller/home-page-controller.dart';
import 'package:personal_blog/pages/word-list.dart';
import 'package:personal_blog/pages/word-write-page.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100]!.withOpacity(0.25),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('HOME'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.to(WordWritePage());
              },
              child: Text(
                '글 작성',
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.to(WordListPage());
              },
              child: Text(
                '작성 목록',
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
