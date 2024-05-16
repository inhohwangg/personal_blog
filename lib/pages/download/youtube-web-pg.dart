// import 'package:flutter/material.dart';
// import 'package:personal_blog/global/g_print.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class WebViewDownPage extends StatefulWidget {
//   const WebViewDownPage({super.key});

//   @override
//   State<WebViewDownPage> createState() => _WebViewDownPageState();
// }

// class _WebViewDownPageState extends State<WebViewDownPage> {
//   InAppWebViewController? webViewController;
//   String? videoUrl;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             InAppWebView(
//               initialUrlRequest: URLRequest(
//                 url: WebUri('https://www.youtube.com/'),
//               ),
//               initialSettings: InAppWebViewSettings(
//                 javaScriptEnabled: true,
//               ),
//               onWebViewCreated: (controller) {
//                 webViewController = controller;

//                 controller.addJavaScriptHandler(
//                   handlerName: 'getShareLink',
//                   callback: (args) {
//                     setState(() {
//                       videoUrl = args[0];
//                     });
//                     printRed(videoUrl);
//                   },
//                 );
//               },
//             ),
//             Positioned(
//               right: 25,
//               bottom: 75,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                 decoration: BoxDecoration(
//                   color: Colors.blue[500],
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: GestureDetector(
//                   onTap: () async {
//                     // 다운로드 버튼 클릭 시 JavaScript 실행
//                     await webViewController?.evaluateJavascript(source: """
//                       (function() {
//                         const videoUrl = window.location.href;
//                         console.log('비디오 URL 찾음: ' + videoUrl);
//                         window.flutter_inappwebview.callHandler('getShareLink', videoUrl);
//                       })();
//                     """);
//                   },
//                   child: Center(
//                     child: Icon(
//                       Icons.download,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:personal_blog/global/g_print.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';

class WebViewDownPage extends StatefulWidget {
  const WebViewDownPage({super.key});

  @override
  State<WebViewDownPage> createState() => _WebViewDownPageState();
}

class _WebViewDownPageState extends State<WebViewDownPage> {
  InAppWebViewController? webViewController;
  String? videoUrl;
  bool _isDownloading = false;
  String _downloadProgress = "";
  ValueNotifier<String> videoTitle = ValueNotifier<String>('');
  File? _tempFile;

  Future<void> downloadVideo(String url) async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = "조회 시작...";
      videoTitle.value = '';
    });

    var yt = YoutubeExplode();
    try {
      var videoId = VideoId(url);
      var video = await yt.videos.get(videoId);
      videoTitle.value = video.title;
      printRed(videoTitle.value);
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var streamInfo = manifest.muxed.withHighestBitrate();
      var stream = yt.videos.streamsClient.get(streamInfo);

      Directory appDocDir = await getApplicationDocumentsDirectory();
      var file = File('${appDocDir.path}/${videoId.value}.mp4');
      var fileStream = file.openWrite();

      await stream.pipe(fileStream);
      await fileStream.flush();
      await fileStream.close();

      setState(() {
        _downloadProgress = "조회 완료";
        _tempFile = file; // 파일 객체 저장
        _isDownloading = false; // 다운로드 상태 업데이트
      });

      await promptFileName(file);
    } catch (e) {
      setState(() {
        _downloadProgress = "오류: $e";
        _isDownloading = false;
      });
    } finally {
      yt.close();
    }
  }

  Future<void> promptFileName(File file) async {
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
                saveFile(file, nameController.text);
                Get.back();
              },
              child: Text('확인'),
            )
          ],
        );
      },
    );
  }

  void saveFile(File tempFile, String fileName) async {
    if (_tempFile != null) {
      // 외부 저장소의 다운로드 디렉토리 경로를 가져옵니다.
      final directory = Directory("/storage/emulated/0/Download"); // 예시 경로
      if (!await directory.exists()) {
        await directory.create(recursive: true); // 디렉토리가 없다면 생성합니다.
      }
      // 파일을 새 위치로 이동합니다.
      String safeFileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '');
      final String newPath = path.join(directory.path, '$safeFileName.mp4');
      await _tempFile!.copy(newPath);

      setState(() {
        _downloadProgress = '파일이 저장되었습니다';
      });
    }
  }

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
                    if (videoUrl != null) {
                      downloadVideo(videoUrl!);
                    }
                  },
                );
              },
            ),
            if (_isDownloading)
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black54,
                  child: Text(
                    _downloadProgress,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
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
