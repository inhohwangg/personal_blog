// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:personal_blog/global/g_print.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:path/path.dart' as path;
// import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
// import 'package:get/get.dart';

// class WebViewDownPage extends StatefulWidget {
//   const WebViewDownPage({super.key});

//   @override
//   State<WebViewDownPage> createState() => _WebViewDownPageState();
// }

// class _WebViewDownPageState extends State<WebViewDownPage> {
//   InAppWebViewController? webViewController;
//   String? videoUrl;
//   bool _isDownloading = false;
//   String _downloadProgress = "";
//   String conversionProgress = "";
//   ValueNotifier<String> videoTitle = ValueNotifier<String>('');
//   File? _tempFile;
//   bool isLoading = true;

//   Future<void> downloadVideo(String url) async {
//     setState(() {
//       _isDownloading = true;
//       _downloadProgress = "조회 시작...";
//       videoTitle.value = '';
//     });

//     var yt = YoutubeExplode();
//     try {
//       var videoId = VideoId(url);
//       var video = await yt.videos.get(videoId);
//       videoTitle.value = video.title;
//       printRed(videoTitle.value);
//       var manifest = await yt.videos.streamsClient.getManifest(videoId);
//       var streamInfo = manifest.muxed.withHighestBitrate();
//       var stream = yt.videos.streamsClient.get(streamInfo);

//       Directory appDocDir = await getApplicationDocumentsDirectory();
//       var file = File('${appDocDir.path}/${videoId.value}.mp4');
//       var fileStream = file.openWrite();

//       await stream.pipe(fileStream);
//       await fileStream.flush();
//       await fileStream.close();

//       setState(() {
//         _downloadProgress = "조회 완료";
//         _tempFile = file; // 파일 객체 저장
//         _isDownloading = false; // 다운로드 상태 업데이트
//       });

//       await promptFileName(file, saveFile);
//     } catch (e) {
//       setState(() {
//         _downloadProgress = "오류: $e";
//         _isDownloading = false;
//       });
//     } finally {
//       yt.close();
//     }
//   }

//   Future<void> downloadAndConvertVideo(String url) async {
//     setState(() {
//       _isDownloading = true;
//       _downloadProgress = "조회 및 변환 시작...";
//       videoTitle.value = '';
//     });

//     var yt = YoutubeExplode();
//     try {
//       var videoId = VideoId(url);
//       var video = await yt.videos.get(videoId);
//       videoTitle.value = video.title;
//       printRed(videoTitle.value);
//       var manifest = await yt.videos.streamsClient.getManifest(videoId);
//       var streamInfo = manifest.muxed.withHighestBitrate();
//       var stream = yt.videos.streamsClient.get(streamInfo);

//       Directory appDocDir = await getApplicationDocumentsDirectory();
//       var file = File('${appDocDir.path}/${videoId.value}.mp4');
//       var fileStream = file.openWrite();

//       await stream.pipe(fileStream);
//       await fileStream.flush();
//       await fileStream.close();

//       setState(() {
//         _downloadProgress = "조회 완료, 변환 중...";
//         _tempFile = file; // 파일 객체 저장
//       });

//       // 비디오를 오디오로 변환
//       String outputPath = file.path.replaceAll('.mp4', '.aac');
//       String command = '-y -i "${file.path}" -vn -acodec copy "$outputPath"';
//       await FFmpegKit.execute(command).then((session) async {
//         final returnCode = await session.getReturnCode();
//         if (returnCode != null && ReturnCode.isSuccess(returnCode)) {
//           setState(() {
//             conversionProgress = '변환 완료: $outputPath';
//             _tempFile = File(outputPath);
//             _isDownloading = false; // 다운로드 및 변환 완료 상태 업데이트
//           });
//           // 비디오 파일 삭제
//           await file.delete();

//           // 오디오 파일 이름을 묻는 팝업 표시
//           await promptFileName(_tempFile!, audioSaveFile);
//         } else {
//           setState(() {
//             conversionProgress = '변환 실패';
//             _isDownloading = false;
//           });
//         }
//       });
//     } catch (e) {
//       setState(() {
//         _downloadProgress = "오류: $e";
//         _isDownloading = false;
//       });
//     } finally {
//       yt.close();
//     }
//   }

//   Future<void> promptFileName(
//       File file, Function(File, String) saveFunction) async {
//     TextEditingController nameController =
//         TextEditingController(text: videoTitle.value);

//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('파일 이름 입력'),
//           content: TextField(
//             controller: nameController,
//             decoration: InputDecoration(
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 hintText: '파일 이름을 입력해주세요.'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: Text('취소'),
//             ),
//             TextButton(
//               onPressed: () {
//                 saveFunction(file, nameController.text);
//                 Get.back();
//               },
//               child: Text('확인'),
//             )
//           ],
//         );
//       },
//     );
//   }

//   void saveFile(File tempFile, String fileName) async {
//     if (_tempFile != null) {
//       final directory = Directory("/storage/emulated/0/Download");
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       String safeFileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '');
//       final String newPath = path.join(directory.path, '$safeFileName.mp4');
//       await _tempFile!.copy(newPath);

//       setState(() {
//         _downloadProgress = '파일이 저장되었습니다';
//       });
//     }
//   }

//   void audioSaveFile(File tempFile, String fileName) async {
//     if (_tempFile != null) {
//       final directory = Directory("/storage/emulated/0/Download");
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       String safeFileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '');
//       final String newPath = path.join(directory.path, '$safeFileName.aac');
//       await _tempFile!.copy(newPath);

//       setState(() {
//         conversionProgress = '오디오 파일이 저장되었습니다: $newPath';
//       });
//     }
//   }

//   Future<bool> onWillPop() async {
//     if (await webViewController!.canGoBack()) {
//       webViewController!.goBack();
//       return false;
//     }
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: WillPopScope(
//         onWillPop: onWillPop,
//         child: Scaffold(
//           body: Stack(
//             children: [
//               InAppWebView(
//                 initialUrlRequest: URLRequest(
//                   url: WebUri('https://www.youtube.com/'),
//                 ),
//                 initialSettings: InAppWebViewSettings(
//                   javaScriptEnabled: true,
//                 ),
//                 onWebViewCreated: (controller) {
//                   webViewController = controller;

//                   controller.addJavaScriptHandler(
//                     handlerName: 'getShareLink',
//                     callback: (args) {
//                       setState(() {
//                         videoUrl = args[0];
//                       });
//                       printRed(videoUrl);
//                       if (videoUrl != null) {
//                         downloadVideo(videoUrl!);
//                       }
//                     },
//                   );

//                   controller.addJavaScriptHandler(
//                     handlerName: 'getShareLinkForAudio',
//                     callback: (args) {
//                       setState(() {
//                         videoUrl = args[0];
//                       });
//                       printRed(videoUrl);
//                       if (videoUrl != null) {
//                         downloadAndConvertVideo(videoUrl!);
//                       }
//                     },
//                   );
//                 },
//                 onLoadStart: (controller, url) {
//                   setState(() {
//                     isLoading = true;
//                   });
//                 },
//                 onLoadStop: (controller, url) async {
//                   setState(() {
//                     isLoading = false;
//                   });
//                 },
//               ),
//               if (_isDownloading)
//                 Positioned(
//                   bottom: 10,
//                   left: 10,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     color: Colors.black54,
//                     child: Text(
//                       _downloadProgress,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               if (isLoading)
//                 Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               Positioned(
//                 right: 10,
//                 bottom: 25,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                   decoration: BoxDecoration(
//                     color: Colors.blue[900],
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: GestureDetector(
//                     onTap: () async {
//                       await webViewController?.evaluateJavascript(source: """
//                         (function() {
//                           const videoUrl = window.location.href;
//                           console.log('비디오 URL 찾음: ' + videoUrl);
//                           window.flutter_inappwebview.callHandler('getShareLink', videoUrl);
//                         })();
//                       """);
//                     },
//                     child: Center(
//                       child: Icon(
//                         Icons.download,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 80,
//                 bottom: 25,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                   decoration: BoxDecoration(
//                     color: Colors.green[600],
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: GestureDetector(
//                     onTap: () async {
//                       await webViewController?.evaluateJavascript(source: """
//                         (function() {
//                           const videoUrl = window.location.href;
//                           console.log('비디오 URL 찾음: ' + videoUrl);
//                           window.flutter_inappwebview.callHandler('getShareLinkForAudio', videoUrl);
//                         })();
//                       """);
//                     },
//                     child: Center(
//                       child: Icon(
//                         Icons.music_note,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
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
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
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
  String conversionProgress = "";
  ValueNotifier<String> videoTitle = ValueNotifier<String>('');
  File? _tempFile;
  bool isLoading = true;
  double _downloadPercentage = 0.0;

  Future<void> downloadVideo(String url) async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = "조회 시작...";
      _downloadPercentage = 0.0;
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

      var totalBytes = streamInfo.size.totalBytes;
      var downloadedBytes = 0;

      await for (var data in stream) {
        downloadedBytes += data.length;
        fileStream.add(data);

        setState(() {
          _downloadPercentage = downloadedBytes / totalBytes;
          _downloadProgress =
              "다운로드 중... ${(_downloadPercentage * 100).toStringAsFixed(2)}%";
        });
      }

      await fileStream.flush();
      await fileStream.close();

      setState(() {
        _downloadProgress = "조회 완료";
        _tempFile = file; // 파일 객체 저장
        _isDownloading = false; // 다운로드 상태 업데이트
      });

      await promptFileName(file, saveFile);
    } catch (e) {
      setState(() {
        _downloadProgress = "오류: $e";
        _isDownloading = false;
      });
    } finally {
      yt.close();
    }
  }

  Future<void> downloadAndConvertVideo(String url) async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = "조회 및 변환 시작...";
      _downloadPercentage = 0.0;
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

      var totalBytes = streamInfo.size.totalBytes;
      var downloadedBytes = 0;

      await for (var data in stream) {
        downloadedBytes += data.length;
        fileStream.add(data);

        setState(() {
          _downloadPercentage = downloadedBytes / totalBytes;
          _downloadProgress =
              "다운로드 중... ${(_downloadPercentage * 100).toStringAsFixed(2)}%";
        });
      }

      await fileStream.flush();
      await fileStream.close();

      setState(() {
        _downloadProgress = "조회 완료, 변환 중...";
        _tempFile = file; // 파일 객체 저장
      });

      // 비디오를 오디오로 변환
      String outputPath = file.path.replaceAll('.mp4', '.aac');
      String command = '-y -i "${file.path}" -vn -acodec copy "$outputPath"';
      await FFmpegKit.execute(command).then((session) async {
        final returnCode = await session.getReturnCode();
        if (returnCode != null && ReturnCode.isSuccess(returnCode)) {
          setState(() {
            conversionProgress = '변환 완료: $outputPath';
            _tempFile = File(outputPath);
            _isDownloading = false; // 다운로드 및 변환 완료 상태 업데이트
          });
          // 비디오 파일 삭제
          await file.delete();

          // 오디오 파일 이름을 묻는 팝업 표시
          await promptFileName(_tempFile!, audioSaveFile);
        } else {
          setState(() {
            conversionProgress = '변환 실패';
            _isDownloading = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        _downloadProgress = "오류: $e";
        _isDownloading = false;
      });
    } finally {
      yt.close();
    }
  }

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

  void saveFile(File tempFile, String fileName) async {
    if (_tempFile != null) {
      final directory = Directory("/storage/emulated/0/Download");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      String safeFileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '');
      final String newPath = path.join(directory.path, '$safeFileName.mp4');
      await _tempFile!.copy(newPath);

      setState(() {
        _downloadProgress = '파일이 저장되었습니다';
      });
    }
  }

  void audioSaveFile(File tempFile, String fileName) async {
    if (_tempFile != null) {
      final directory = Directory("/storage/emulated/0/Download");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      String safeFileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '');
      final String newPath = path.join(directory.path, '$safeFileName.aac');
      await _tempFile!.copy(newPath);

      setState(() {
        conversionProgress = '오디오 파일이 저장되었습니다: $newPath';
      });
    }
  }

  Future<bool> onWillPop() async {
    if (await webViewController!.canGoBack()) {
      webViewController!.goBack();
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

                  controller.addJavaScriptHandler(
                    handlerName: 'getShareLinkForAudio',
                    callback: (args) {
                      setState(() {
                        videoUrl = args[0];
                      });
                      printRed(videoUrl);
                      if (videoUrl != null) {
                        downloadAndConvertVideo(videoUrl!);
                      }
                    },
                  );
                },
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
              if (_isDownloading)
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.black54,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _downloadProgress,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: _downloadPercentage,
                          backgroundColor: Colors.white,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
              Positioned(
                right: 10,
                bottom: 55,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: GestureDetector(
                    onTap: () async {
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
              Positioned(
                right: 80,
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
                          console.log('비디오 URL 찾음: ' + videoUrl);
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
            ],
          ),
        ),
      ),
    );
  }
}
