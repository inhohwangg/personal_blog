import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/controller/home-page-controller.dart';
import 'package:personal_blog/controller/word-list-page-controller.dart';
import 'package:personal_blog/pages/word-list.dart';
import 'package:personal_blog/pages/word-write-page.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WordListPageController wordListPageController =
        Get.put(WordListPageController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100]!.withOpacity(0.25),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('HOME'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: wordListPageController.postList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 15),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.5),
                        color: Colors.amber[400]!.withOpacity(
                          0.25,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          wordListPageController.postList[index]['title'],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
