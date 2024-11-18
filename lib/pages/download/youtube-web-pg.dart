import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_blog/global/g_print.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';

import '../../global/g_dio.dart';

class WebViewDownPage extends StatefulWidget {
  const WebViewDownPage({super.key});

  @override
  State<WebViewDownPage> createState() => _WebViewDownPageState();
}

class _WebViewDownPageState extends State<WebViewDownPage> {
  InAppWebViewController? webViewController;
  String? videoUrl;
  String conversionProgress = "";
  ValueNotifier<String> videoTitle = ValueNotifier<String>('');
  File? _tempFile;
  bool isLoading = true;
  bool isDownloading = false;
  double downloadProgress = 0.0;

  Future<void> promptFileName(
      File file, Function(File, String) saveFunction) async {
    TextEditingController nameController =
        TextEditingController(text: videoTitle.value);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('파일 이름 입력'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: '파일 이름을 입력해주세요.'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                saveFunction(file, nameController.text);
                Get.back();
              },
              child: Text('확인'),
            )
          ],
        );
      },
    );
  }

  void setupWebView(InAppWebViewController controller) {
    webViewController = controller;
    controller.addJavaScriptHandler(
      handlerName: 'getShareLinkForAudio', // JavaScript에서 호출할 핸들러 이름
      callback: (args) {
        if (args.isNotEmpty) {
          videoUrl =
              args[0].toString().replaceAll('m.youtube.com', 'www.youtube.com');
          print('Received URL: $videoUrl');
          if (videoUrl != null) {
            downloadAudio(videoUrl!); // URL 받으면 바로 다운로드 시작
          }
        }
      },
    );
  }

  Future<bool> checkAndRequestPermissions() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.isGranted) {
        return true;
      }

      // Android 13 이상
      if (await Permission.audio.isGranted) {
        return true;
      }

      // 권한 요청
      var storageStatus = await Permission.storage.request();
      var audioStatus = await Permission.audio.request();

      return storageStatus.isGranted || audioStatus.isGranted;
    }
    return true;
  }

  Future<String?> getYouTubeTitle() async {
  try {
    final titleInfo = await webViewController?.evaluateJavascript(source: """
      (function() {
        const title = document.title.replace(' - YouTube', '');
        return title;
      })()
    """);
    
    print('Found title: $titleInfo');
    return titleInfo;
  } catch (e) {
    print('Error getting title: $e');
    return null;
  }
}

  // 오디오 다운로드 함수
  Future<void> downloadAudio(String youtubeUrl) async {
    try {
      // 권한 체크
      bool hasPermission = await checkAndRequestPermissions();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // 다운로드 진행 상태 표시
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('다운로드 중...'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('잠시만 기다려주세요...'),
              ],
            ),
          );
        },
      );

      // API 요청
      final response = await dio.post(
        'https://side.inhodev.shop/youtube/audio',
        data: {'url': youtubeUrl},
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      // 다운로드 다이얼로그 닫기
      Navigator.pop(context);

      if (response.statusCode == 200) {
        // 제목 가져오기
    String? videoTitle = await getYouTubeTitle();
        

        // 파일 이름 입력 다이얼로그
        final fileName = await showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            final controller = TextEditingController(
                text: videoTitle ?? 'audio_${DateTime.now().millisecondsSinceEpoch}');
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text('파일 이름 입력'),
              content: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '파일 이름을 입력하세요',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, controller.text),
                  child: Text('저장'),
                ),
              ],
            );
          },
        );

        if (fileName != null) {
          final directory = Directory('/storage/emulated/0/Download');
          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }

          // 안전한 파일명 생성
          String safeFileName =
              fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '');
          final String filePath =
              path.join(directory.path, '$safeFileName.mp3');
          final file = File(filePath);
          await file.writeAsBytes(response.data);

          // 미디어 스캔
          await MediaScanner.loadMedia(path: filePath);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('다운로드 완료: $filePath')),
          );
        }
      }
    } catch (e) {
      Navigator.pop(context); // 에러 발생 시 다이얼로그 닫기
      print('Error downloading audio: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('다운로드 실패: $e')),
      );
    }
  }

  void audioSaveFile(File tempFile, String fileName) async {
    if (_tempFile != null) {
      final directory = Directory("/storage/emulated/0/Download");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      String safeFileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '');
      final String newPath = path.join(directory.path, '$safeFileName.mp3');
      await _tempFile!.copy(newPath);

      setState(() {
        conversionProgress = '오디오 파일이 저장되었습니다: $newPath';
      });

      await MediaScanner.loadMedia(path: newPath);
    }
  }

  // WillPopScope 처리 개선
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() async {
    if (await webViewController?.canGoBack() ?? false) {
      webViewController?.goBack();
      return false;
    }

    if (currentBackPressTime == null ||
        DateTime.now().difference(currentBackPressTime!) >
            Duration(seconds: 2)) {
      currentBackPressTime = DateTime.now();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('뒤로가기 버튼을 한번 더 누르면 종료됩니다.')),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
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
                onWebViewCreated: setupWebView,

                // onWebViewCreated: (controller) {
                //   webViewController = controller;

                //   controller.addJavaScriptHandler(
                //     handlerName: 'getShareLink',
                //     callback: (args) {
                //       setState(() {
                //         videoUrl = args[0].replaceAll(
                //             'm.youtube.com', 'www.youtube.com'); // URL 표준화
                //       });
                //       printRed(videoUrl);
                //     },
                //   );
                // },
                onLoadStart: (controller, url) {
                  setState(() {
                    isLoading = true;
                  });
                },
                onLoadStop: (controller, url) async {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              Positioned(
                right: 20,
                bottom: 55,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await webViewController?.evaluateJavascript(source: """
                        (function() {
                          const videoUrl = window.location.href;
                          console.log('Video URL found: ' + videoUrl);
                          window.flutter_inappwebview.callHandler('getShareLinkForAudio', videoUrl);
                        })();
                      """);
                    },
                    child: Center(
                      child: Icon(
                        Icons.music_note,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading) Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
