import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  File? _tempFile;

  Future<void> downloadVideo(String url) async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = "다운로드 시작...";
    });

    var yt = YoutubeExplode();
    try {
      var videoId = VideoId(url);
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
        _downloadProgress = "다운로드 완료: ${file.path}";
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

  void saveFile() async {
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
        _saveProgress = '파일이 저장되었습니다: $newPath';
      });
    }
  }

  void reset() {
    setState(() {
      _controller.text = '';
      _downloadProgress = '';
      _saveProgress = '';
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
            // onPressed:
            //     _isDownloading ? null : () => downloadVideo(_controller.text),
            onPressed: () {
              _isDownloading ? null : downloadVideo(_controller.text);
            },
            child: Text('다운로드'),
          ),
          SizedBox(height: 20),
          Text(_downloadProgress),
          if (!_isDownloading && _tempFile != null) // 다운로드가 완료되었을 때만 저장 버튼 활성화
            ElevatedButton(
              onPressed: saveFile,
              child: Text('저장소에 저장'),
            ),
          Text(_saveProgress), // 저장 상태 메시지 표시
          ElevatedButton(
            onPressed: () {
              reset();
            },
            child: Text(
              '초기화',
            ),
          )
        ],
      ),
    );
  }
}
