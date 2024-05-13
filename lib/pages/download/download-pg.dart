import 'dart:io';
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_blog/global/g_print.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path/path.dart' as path;

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isDownloading = false;
  String _downloadProgress = '';
  String _saveProgress = '';
  String _audioSaveProgress = '';
  String conversionProgress = '';
  File? _tempFile;
  RxString videoTitle = ''.obs;

  Future<void> convertVideoToAudio(File videoFile) async {
    String outputPath = videoFile.path.replaceAll('.mp4', '.aac');
    String command = '-y -i "${videoFile.path}" -vn -acodec copy "$outputPath"';
    await FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      if (returnCode != null && ReturnCode.isSuccess(returnCode)) {
        setState(() {
          conversionProgress = '변환 완료: $outputPath';
          _tempFile = File(outputPath);
        });
      } else {
        setState(() {
          conversionProgress = '변환 실패';
        });
      }
    });
  }

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
      printRed(videoTitle);
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
    } catch (e) {
      setState(() {
        _downloadProgress = "오류: $e";
        _isDownloading = false;
      });
    } finally {
      yt.close();
    }
  }

  // void saveFile() {
  //   if (_tempFile != null) {
  //     setState(() {
  //       _saveProgress = '파일이 저장되었습니다: ${_tempFile!.path}';
  //     });
  //   }
  // }

  promptFileName(File file) async {
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
            // decoration: OutlinedBorder(
            //   hintText: '파일 이름을 입력하세요'),
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
              child: Text(
                '확인',
              ),
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
        _saveProgress = '파일이 저장되었습니다';
      });
    }
  }

  void oudioSaveFile() async {
    if (_tempFile != null) {
      // 외부 저장소의 다운로드 디렉토리 경로를 가져옵니다.
      final directory = Directory("/storage/emulated/0/Download"); // 예시 경로
      if (!await directory.exists()) {
        await directory.create(recursive: true); // 디렉토리가 없다면 생성합니다.
      }
      // 파일을 새 위치로 이동합니다.
      final String newPath =
          path.join(directory.path, path.basename(_tempFile!.path));
      await _tempFile!.copy(newPath);

      setState(() {
        _audioSaveProgress = '오디오 파일이 저장되었습니다: $newPath';
      });
    }
  }

  void reset() {
    setState(() {
      _controller.text = '';
      _downloadProgress = '';
      _saveProgress = '';
      _audioSaveProgress = '';
      _isDownloading = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YouTube 비디오 다운로더',
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'YouTube 링크 입력',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _isDownloading ? null : downloadVideo(_controller.text);
            },
            child: Text('조회하기'),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(_downloadProgress),
          ),
          if (!_isDownloading && _tempFile != null) // 다운로드가 완료되었을 때만 저장 버튼 활성화
            ElevatedButton(
              onPressed: () {
                promptFileName(_tempFile!);
              },
              child: Text('저장하기'),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(_saveProgress),
          ), // 저장 상태 메시지 표시
          ElevatedButton(
            onPressed: () {
              reset();
            },
            child: Text(
              '초기화',
            ),
          ),
          if (!_isDownloading && _tempFile != null) // 변환 버튼
            GestureDetector(
              onTap: () => convertVideoToAudio(_tempFile!),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('오디오로 변환하기', style: TextStyle(color: Colors.white)),
              ),
            ),
          Text(conversionProgress),

          if (!_isDownloading && _tempFile != null) // 변환 버튼
            GestureDetector(
              onTap: () => oudioSaveFile(),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('오디오 저장하기', style: TextStyle(color: Colors.white)),
              ),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(_audioSaveProgress),
          )
        ],
      ),
    );
  }
}
