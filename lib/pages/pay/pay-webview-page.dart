import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PayWebviewPage extends GetView {
  PayWebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri('https://brand.naver.com/dongwon/products/5751809151?n_media=466188&n_rank=5&n_ad_group=grp-a001-02-000000023799531&n_ad=nad-a001-02-000000156208193&n_campaign_type=2&n_mall_id=dongwonfnb&n_mall_pid=5751809151&n_ad_group_type=2&n_match=3&NaPm=ct%3Dm0c52ue0%7Cci%3D0AW00007waPA75xTnKYq%7Ctr%3Dpla%7Chk%3D7777a3cd6c1ca39cbd43f681b9c54ce1101fbcd7%7Cnacn%3DRLhTBMAJ4dwT')
          ),
        ),
      ),
    );
  }

}