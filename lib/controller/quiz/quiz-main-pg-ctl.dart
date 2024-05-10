import 'package:get/get.dart';

class QuizMainPageController extends GetxController {
  RxList quizCatg = [
    '역사',
    '인물',
    '이야기',
    '기술',
  ].obs;

  RxList catgColor = [
    0xFFfad3cf,
    0xFFd7ffff,
    0xFFd0f3e1,
    0xFFd0cff6,
  ].obs;
}
