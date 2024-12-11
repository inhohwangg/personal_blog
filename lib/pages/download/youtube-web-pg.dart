import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:just_audio/just_audio.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal_blog/global/g_print.dart';
import 'package:personal_blog/utils/audio_wave.dart';
import 'dart:io';

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
  // 오디오 편집 관련 변수들
  double audioVolume = 1.0;
  double audioSpeed = 1.0;
  double startTime = 0.0;
  double endTime = 0.0;
  bool isEditing = false;
  late AudioPlayer audioPlayer;

  // void setupWebView(InAppWebViewController controller) {
  //   webViewController = controller;
  //   controller.addJavaScriptHandler(
  //     handlerName: 'getShareLinkForAudio', // JavaScript에서 호출할 핸들러 이름
  //     callback: (args) {
  //       if (args.isNotEmpty) {
  //         videoUrl =
  //             args[0].toString().replaceAll('m.youtube.com', 'www.youtube.com');
  //         print('Received URL: $videoUrl');
  //         if (videoUrl != null) {
  //           downloadAudio(videoUrl!); // URL 받으면 바로 다운로드 시작
  //         }
  //       }
  //     },
  //   );
  // }
  void setupWebView(InAppWebViewController controller) {
    webViewController = controller;
    controller.addJavaScriptHandler(
      handlerName: 'getShareLinkForAudio',
      callback: (args) {
        inspect(args);
        if (args.isNotEmpty) {
          videoUrl =
              args[0].toString().replaceAll('m.youtube.com', 'www.youtube.com');
          print('Received URL: $videoUrl');
          if (videoUrl != null) {
            downloadAudio(videoUrl!);
          }
        }
      },
    );

    // 비디오 다운로드 핸들러 추가
    controller.addJavaScriptHandler(
      handlerName: 'getShareLinkForVideo',
      callback: (args) {
        if (args.isNotEmpty) {
          videoUrl =
              args[0].toString().replaceAll('m.youtube.com', 'www.youtube.com');
          print('Received URL for video: $videoUrl');
          if (videoUrl != null) {
            inspect(controller);

            downloadVideo(videoUrl!);
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
      videoTitle.value = titleInfo;
      return titleInfo;
    } catch (e) {
      print('Error getting title: $e');
      return null;
    }
  }

  Future<void> downloadVideo(String youtubeUrl) async {
    try {
      // 다운로드 진행 상태 표시
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('동영상 다운로드 중...'),
              ],
            ),
          );
        },
      );

      // API 요청
      final response = await dio.post(
        'https://side.inhodev.shop/youtube/video',
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
        final directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        // 파일명 생성
        String fileName = 'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
        if (response.headers.map.containsKey('content-disposition')) {
          String contentDisposition =
              response.headers.value('content-disposition')!;
          fileName =
              contentDisposition.split('filename=').last.replaceAll('"', '');
        }

        // 파일 저장
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(response.data);

        // 다운로드 완료 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('동영상이 다운로드되었습니다: ${file.path}')),
        );
        await MediaScanner.loadMedia(path: file.path);
      } else {
        throw Exception('동영상 다운로드에 실패했습니다');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('동영상 다운로드 중 오류가 발생했습니다: $e')),
      );
    }
  }

  Future<void> downloadAudio(String youtubeUrl) async {
    try {
      bool hasPermission = await checkAndRequestPermissions();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      // 제목 가져오기
      final title = await getYouTubeTitle();

      // 다운로드 진행 상태 표시
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('다운로드 중...'),
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
        final directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        // 임시 파일 저장
        final tempFile = File('${directory.path}/${videoTitle.value}.mp3');
        await tempFile.writeAsBytes(response.data);

        // 오디오 편집 다이얼로그 표시
        final result =
            await showAudioEditorDialog(tempFile.path, title ?? 'audio');

        // 다운로드 완료 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오디오 파일이 다운로드되었습니다: ${tempFile.path}')),
        );
        await MediaScanner.loadMedia(path: tempFile.path);
        // if (result != null) {
        //   String safeFileName =
        //       result['fileName'].replaceAll(RegExp(r'[\\/:*?"<>|]'), '');
        //   final String outputPath = '${directory.path}/$safeFileName.mp3';

        //   if (result['isEdited']) {
        //     try {
        //       // FFmpeg로 오디오 편집
        //       final success = await editAudio(
        //         tempFile.path,
        //         outputPath,
        //         result['startTime'],
        //         result['endTime'],
        //         result['volume'],
        //       );

        //       if (success) {
        //         // 미디어 스캔 실행

        //         // 성공 메시지 표시
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           SnackBar(content: Text('편집된 오디오 저장 완료: $outputPath')),
        //         );
        //       } else {
        //         throw Exception('오디오 편집 실패');
        //       }
        //     } catch (e) {
        //       print('Error during audio editing: $e');
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(content: Text('오디오 편집 실패: $e')),
        //       );

        //       // 편집 실패 시 원본 파일 복사
        //       await tempFile.copy(outputPath);
        //       await MediaScanner.loadMedia(path: outputPath);
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(content: Text('원본 파일로 저장됨: $outputPath')),
        //       );
        //     }
        //   } else {
        //     // 편집하지 않고 저장
        //     await tempFile.copy(outputPath);
        //     await MediaScanner.loadMedia(path: outputPath);
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(content: Text('오디오 저장 완료: $outputPath')),
        //     );
        //   }

        //   // 임시 파일 삭제
        //   if (await tempFile.exists()) {
        //     await tempFile.delete();
        //   }
        // }
      } else {
        throw Exception('Failed to download audio: ${response.statusCode}');
      }
    } catch (e) {
      printRed('Error downloading audio: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('다운로드 실패: $e')),
      );
    }
  }

  Future<Map<String, dynamic>?> showAudioEditorDialog(
      String audioPath, String defaultFileName) async {
    final player = AudioPlayer();
    await player.setFilePath(audioPath);
    final duration = player.duration ?? Duration.zero;

    double startTime = 0;
    double endTime = duration.inSeconds.toDouble();
    double volume = 1.0;

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('오디오 편집'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: TextEditingController(text: defaultFileName),
                      decoration: InputDecoration(
                        labelText: '파일 이름',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => defaultFileName = value,
                    ),
                    // SizedBox(height: 20),
                    // AudioWaveformWidget(
                    //   audioPath: audioPath,
                    //   duration: duration,
                    //   onSeek: (position) {
                    //     player.seek(Duration(seconds: position.toInt()));
                    //   },
                    // ),
                    SizedBox(height: 20),
                    Text(
                        '구간 선택 (${startTime.toStringAsFixed(1)}초 ~ ${endTime.toStringAsFixed(1)}초)'),
                    RangeSlider(
                      values: RangeValues(startTime, endTime),
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      onChanged: (RangeValues values) {
                        setState(() {
                          startTime = values.start;
                          endTime = values.end;
                        });
                      },
                    ),
                    Text('볼륨 조절 (${(volume * 100).toStringAsFixed(0)}%)'),
                    Slider(
                      value: volume,
                      min: 0.0,
                      max: 2.0,
                      onChanged: (value) {
                        setState(() {
                          volume = value;
                        });
                        player.setVolume(value);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () async {
                            await player
                                .seek(Duration(seconds: startTime.toInt()));
                            await player.play();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.stop),
                          onPressed: () async {
                            await player.stop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    await player.stop();
                    await player.dispose();
                    Navigator.of(context).pop();
                  },
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () async {
                    await player.stop();
                    await player.dispose();
                    Navigator.of(context).pop({
                      'fileName': defaultFileName,
                      'startTime': startTime,
                      'endTime': endTime,
                      'volume': volume,
                      'isEdited': true,
                    });
                  },
                  child: Text('저장'),
                ),
              ],
            );
          },
        );
      },
    ).whenComplete(() => player.dispose());
  }

  Future<bool> editAudio(
    String inputPath,
    String outputPath,
    double startTime,
    double endTime,
    double volume,
  ) async {
    try {
      // 진행 상태 표시 다이얼로그
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('오디오 편집 중...'),
              ],
            ),
          );
        },
      );

      // FFmpeg 명령어 구성
      final command =
          '-i "$inputPath" -ss $startTime -t ${endTime - startTime} -filter:a "volume=$volume" -c:a libmp3lame -q:a 2 "$outputPath"';
      print('FFmpeg command: $command');

      // FFmpeg 실행
      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();
      final logs = await session.getLogs();

      // 로그 출력
      print('FFmpeg logs: $logs');
      print('FFmpeg return code: $returnCode');

      // 다이얼로그 닫기
      Navigator.pop(context);

      // 결과 파일 확인
      final outputFile = File(outputPath);
      if (await outputFile.exists()) {
        final fileSize = await outputFile.length();
        print('Output file size: $fileSize bytes');

        if (fileSize > 0) {
          return true;
        }
      }

      return false;
    } catch (e, stackTrace) {
      print('Error in editAudio: $e');
      print('Stack trace: $stackTrace');

      // 에러 발생 시 다이얼로그 닫기
      Navigator.pop(context);
      return false;
    }
  }

  DateTime? currentBackPressTime;

  void _handlePopInvokedWithResult(bool didPop, dynamic result) async {
    if (await webViewController?.canGoBack() ?? false) {
      webViewController?.goBack();
      return;
    }

    if (currentBackPressTime == null ||
        DateTime.now().difference(currentBackPressTime!) >
            Duration(seconds: 2)) {
      currentBackPressTime = DateTime.now();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('뒤로가기 버튼을 한번 더 누르면 종료됩니다')),
      );
    } else {
      SystemNavigator.pop(); // 앱 종료
    }
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: _handlePopInvokedWithResult,
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
                onLoadStart: (controller, url) async {
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
              // 오디오
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
              // 비디오
              Positioned(
                right: 20,
                bottom: 120,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await webViewController?.evaluateJavascript(source: """
          (function() {
            const videoUrl = window.location.href;
            console.log('Video URL found: ' + videoUrl);
            window.flutter_inappwebview.callHandler('getShareLinkForVideo', videoUrl);
          })();
        """);
                    },
                    child: Center(
                      child: Icon(
                        Icons.videocam,
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
