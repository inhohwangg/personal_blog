import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';

class AudioWaveformWidget extends StatefulWidget {
  final String audioPath;
  final Duration duration;
  final Function(double) onSeek;

  const AudioWaveformWidget({
    Key? key,
    required this.audioPath,
    required this.duration,
    required this.onSeek,
  }) : super(key: key);

  @override
  State<AudioWaveformWidget> createState() => _AudioWaveformWidgetState();
}

class _AudioWaveformWidgetState extends State<AudioWaveformWidget> {
  List<double> samples = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWaveformData();
  }

  Future<void> _loadWaveformData() async {
    try {
      final file = File(widget.audioPath);
      final bytes = await file.readAsBytes();
      samples = await _extractWaveformData(bytes);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading waveform data: $e');
    }
  }

  Future<List<double>> _extractWaveformData(List<int> bytes) async {
    List<double> samples = [];
    const samplesCount = 100;
    final samplesPerPixel = bytes.length ~/ samplesCount;

    for (var i = 0; i < samplesCount; i++) {
      final start = i * samplesPerPixel;
      final end = start + samplesPerPixel;
      double maxAmplitude = 0.0;

      for (var j = start; j < end && j + 1 < bytes.length; j += 2) {
        int sample = bytes[j] | (bytes[j + 1] << 8);
        if (sample > 32767) sample -= 65536;
        double amplitude = sample / 32768.0;
        maxAmplitude = math.max(maxAmplitude, amplitude.abs());
      }

      samples.add(maxAmplitude);
    }

    // 스무딩 처리
    List<double> smoothedSamples = [];
    const smoothingFactor = 3;

    for (var i = 0; i < samples.length; i++) {
      double sum = 0;
      int count = 0;
      for (var j = math.max(0, i - smoothingFactor);
          j < math.min(samples.length, i + smoothingFactor + 1);
          j++) {
        sum += samples[j];
        count++;
      }
      smoothedSamples.add(sum / count);
    }

    return smoothedSamples;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: 100,
      child: PolygonWaveform(
        samples: samples,
        height: 100,
        width: MediaQuery.of(context).size.width - 100,
        maxDuration: widget.duration,
        elapsedDuration: Duration.zero,
        activeColor: Colors.blue.shade300,
        inactiveColor: Colors.blue,
        activeGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade300,
            Colors.blue.shade700,
          ],
        ),
        style: PaintingStyle.fill,
        showActiveWaveform: true,
        absolute: true,
      ),
    );
  }
}
