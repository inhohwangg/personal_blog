import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_blog/pages/pay/pay-webview-page.dart';

class PayTestPage extends GetView {
  PayTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 한 행에 3개의 아이템 표시
                      mainAxisSpacing: 10.0, // 세로 간격
                      crossAxisSpacing: 10.0, // 가로 간격
                      childAspectRatio: 1.0 // 아이템의 가로:세로 비율을 1:1
                      ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(PayWebviewPage());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Image.asset('assets/apple.png'),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//https://brand.naver.com/dongwon/products/5751809151?n_media=466188&n_rank=5&n_ad_group=grp-a001-02-000000023799531&n_ad=nad-a001-02-000000156208193&n_campaign_type=2&n_mall_id=dongwonfnb&n_mall_pid=5751809151&n_ad_group_type=2&n_match=3&NaPm=ct%3Dm0c52ue0%7Cci%3D0AW00007waPA75xTnKYq%7Ctr%3Dpla%7Chk%3D7777a3cd6c1ca39cbd43f681b9c54ce1101fbcd7%7Cnacn%3DRLhTBMAJ4dwT