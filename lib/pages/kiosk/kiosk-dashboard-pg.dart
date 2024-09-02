import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/controller/kiosk/kiosk-dashboard-pg-ctl.dart';

class KioskDashboardPage extends GetView {
  KioskDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    KioskDashboardPageController controller =
        Get.put(KioskDashboardPageController());
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.blue[900]!.withOpacity(0.45),
                Colors.blue[800]!.withOpacity(0.3),
                Colors.blue[700]!.withOpacity(0.15),
                Colors.blue[100]!.withOpacity(0.2),
              ])
              // gradient: RadialGradient(
              //   colors: [

              //   ],
              // ),
              ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20, left: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '반응형 미디어보드',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '내 삶을 바꾸는 도시 의정부',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.symmetric(horizontal: 15,),
                      child: Center(
                        child: Image.asset('assets/symbol_img01.png'),
                      ),
                    ),
                  )
                ],
              ),
              Obx(
                () => Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.textList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[100]!.withOpacity(0.8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      controller.textList[index],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Image.asset(controller.imageList[index]),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
