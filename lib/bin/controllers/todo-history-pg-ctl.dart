import 'package:get/get.dart';
import 'package:personal_blog/global/g_dio.dart';
import 'package:personal_blog/global/g_print.dart';
import 'package:personal_blog/global/g_value.dart';

class TodoHistoryPageController extends GetxController {
  RxList todoDoneList = [].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    todoDataGet();
  }

  todoDataGet() async {
    todoDoneList.clear();
    isLoading.value = false;
    try {
      var res = await dio.get('$baseUrl/api/todo');
      todoDoneList.addAll(res.data);
      // for (var i = 0; i < res.data.length; i++) {
      //   if (res.data[i]['is_completed'] == true) {
      //     todoDoneList.add(res.data[i]);
      //   }
      // }
      // print('this');
      isLoading.value = true;
    } catch (e) {
      printRed('todo-history-pg-ctl.dart todoDataGet Error Message : $e');
    }
  }
}
