import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/bin/controllers/todo-history-pg-ctl.dart';

class TodoHistoryPage extends GetView<TodoHistoryPageController> {
  TodoHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo History Page'),
      ),
    );
  }
}
