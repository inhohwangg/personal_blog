import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:personal_blog/controller/post-info-pg-ctl.dart';

class PostInfoPage extends GetView<PostInfoPageController> {
  PostInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    PostInfoPageController controller = Get.put(PostInfoPageController());
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
          vertical: MediaQuery.of(context).size.height * 0.1,
        ),
        child: Column(
          children: [
            Container(
              child: Center(
                child: Text(
                  controller.testData['title'],
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Center(
                child: Text(
                  controller.testData['content'],
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
