import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scribble/scribble.dart';

class PaintPageController extends GetxController {
  late ScribbleNotifier notifier;
  var isEraseMode = false.obs; // 지우기 모드 상태 변수

  @override
  void onInit() {
    notifier = ScribbleNotifier();
    super.onInit();
  }

  void toggleEraseMode() {
    isEraseMode.value = !isEraseMode.value;
  }

  void handleTap(Offset position) {
    if (isEraseMode.value) {
      _eraseAt(position);
    }
  }

  void _eraseAt(Offset position) {
    final updatedLines = notifier.value.sketch.lines.map((line) {
      final updatedPoints = line.points.where((point) {
        return (point.x - position.dx).abs() > 10 ||
            (point.y - position.dy).abs() > 10;
      }).toList();

      return line.copyWith(points: updatedPoints);
    }).toList();

    final updatedSketch = notifier.value.sketch.copyWith(lines: updatedLines);

    notifier.setSketch(sketch: updatedSketch);
  }
}
