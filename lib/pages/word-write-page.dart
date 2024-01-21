import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:personal_blog/controller/word-write-page-controller.dart';

class WordWritePage extends GetView<WordWritePageController> {
  WordWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    WordWritePageController controller = Get.put(WordWritePageController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        centerTitle: true,
        title: Text('게시글 작성하기'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '제목',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey[700]!.withOpacity(
                      0.25,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: controller.title,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '내용',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey[700]!.withOpacity(
                    0.25,
                  ),
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: TextField(
                controller: controller.content,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                MotionToast(
                  icon: Icons.check_circle_outline,
                  primaryColor: Colors.green,
                  description: Text("게시글 작성 완료"),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 75,
                ).show(context);
                controller.writeCreate();
              },
              child: Text(
                '글 작성',
              ),
            )
          ],
        ),
      ),
    );
  }
}
