import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/bin/post-list-ctl.dart';

class PostListPage extends GetView<PostListPageController> {
  PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard Page'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('게시글 작성하기'),
                    ),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('게시글 조회하기'),
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
