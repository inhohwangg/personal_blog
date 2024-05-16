import 'package:flutter/material.dart';
import 'package:personal_blog/global/g_print.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewDownPage extends StatefulWidget {
  const WebViewDownPage({super.key});

  @override
  State<WebViewDownPage> createState() => _WebViewDownPageState();
}

class _WebViewDownPageState extends State<WebViewDownPage> {
  InAppWebViewController? webViewController;
  String? videoUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri('https://www.youtube.com/'),
              ),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;

                controller.addJavaScriptHandler(
                  handlerName: 'getShareLink',
                  callback: (args) {
                    setState(() {
                      videoUrl = args[0];
                    });
                    printRed(videoUrl);
                  },
                );
              },
            ),
            Positioned(
              right: 25,
              bottom: 75,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.blue[500],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: GestureDetector(
                  onTap: () async {
                    // 다운로드 버튼 클릭 시 JavaScript 실행
                    await webViewController?.evaluateJavascript(source: """
                      (function() {
                        const videoUrl = window.location.href;
                        console.log('비디오 URL 찾음: ' + videoUrl);
                        window.flutter_inappwebview.callHandler('getShareLink', videoUrl);
                      })();
                    """);
                  },
                  child: Center(
                    child: Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
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
