import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/bin/controllers/todo-setting-pg-ctl.dart';

class TodoSettingPage extends GetView<TodoSettingPageController> {
  TodoSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
    );
  }
}
