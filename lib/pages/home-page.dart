import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
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
          Center(
            child: ElevatedButton(
              onPressed: () {
                // MotionToast.success(
                //   title: Text('title'),
                //   description: Text('test success'),
                // ).show(context);
                // MotionToast(
                //   icon: Icons.check_circle_outline,
                //   primaryColor: Colors.green,
                //   description: Text("게시글 작성 완료"),
                //   width: MediaQuery.of(context).size.width * 0.5,
                //   height: 75,
                // ).show(context);
              },
              child: Text(
                'toast test',
              ),
            ),
          )
        ],
      ),
    );
  }
}
