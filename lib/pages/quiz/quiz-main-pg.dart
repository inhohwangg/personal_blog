import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/controller/quiz/quiz-main-pg-ctl.dart';

class QuizMainPage extends GetView {
  QuizMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuizMainPageController controller = Get.put(QuizMainPageController());
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Expanded(
                flex: 15,
                child: Center(
                  child: Text(
                    'Quiz',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 85,
                child: GridView.builder(
                  itemCount: controller.quizCatg.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        quizPage(context, index, controller);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(controller.catgColor[index])
                              .withOpacity(0.75),
                        ),
                        width: 100,
                        height: 100,
                        child: Center(
                          child: Text(
                            controller.quizCatg[index].toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  quizPage(context, index, controller) {
    return Column(
      children: [
        Text(controller.quizCatg[index]),
      ],
    );
  }
}
