import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';


class HeartRateMonitor2 extends StatefulWidget {
  const HeartRateMonitor2({super.key});

  @override
  _HeartRateMonitor2State createState() => _HeartRateMonitor2State();
}

class _HeartRateMonitor2State extends State<HeartRateMonitor2> {
  CameraController? _cameraController;
  bool _isMeasuring = false;
  List<double> _brightnessValues = [];
  int _bpm = 0;
  Timer? _timer;
  double _lastBrightness = 0;
  int _heartbeatCount = 0;
  int _startTime = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back);

    _cameraController = CameraController(camera, ResolutionPreset.low,
        enableAudio: false, imageFormatGroup: ImageFormatGroup.yuv420);

    await _cameraController?.initialize();
    await _cameraController?.startImageStream(_processCameraImage);

    setState(() {});
  }

  void _processCameraImage(CameraImage image) {
    final averageBrightness = _calculateBrightness(image.planes[0].bytes);

    if (_isMeasuring) {
      _brightnessValues.add(averageBrightness);

      if (_brightnessValues.length > 100) {
        _brightnessValues.removeAt(0);  // Keep a sliding window of brightness values
      }

      if (_brightnessValues.length >= 2) {
        _detectHeartbeat();
      }
    }
  }

  double _calculateBrightness(Uint8List bytes) {
    // Convert the YUV image (Y channel) to brightness by averaging pixel values
    int totalBrightness = 0;

    for (int i = 0; i < bytes.length; i++) {
      totalBrightness += bytes[i];
    }

    return totalBrightness / bytes.length;
  }

  void _detectHeartbeat() {
    double brightnessDiff = _brightnessValues.last - _brightnessValues[_brightnessValues.length - 2];

    // Detect heartbeat when brightness increases by a certain threshold
    if (brightnessDiff > 0.005 && _lastBrightness <= _brightnessValues.last) {
      _heartbeatCount++;
      if (_heartbeatCount == 1) {
        _startTime = DateTime.now().millisecondsSinceEpoch;
      } else if (_heartbeatCount >= 10) {
        int elapsedTime = DateTime.now().millisecondsSinceEpoch - _startTime;
        int secondsElapsed = elapsedTime ~/ 1000;

        // Calculate beats per minute (BPM)
        setState(() {
          _bpm = (_heartbeatCount / secondsElapsed * 60).round();
        });

        // Reset after 10 heartbeats
        _heartbeatCount = 0;
        _brightnessValues.clear();
      }
    }

    _lastBrightness = _brightnessValues.last;
  }

  void _startMeasurement() {
    setState(() {
      _isMeasuring = true;
      _brightnessValues.clear();
      _heartbeatCount = 0;
    });
    _cameraController?.setFlashMode(FlashMode.torch);
  }

  void _stopMeasurement() {
    setState(() {
      _isMeasuring = false;
      _bpm = 0;
    });
    _cameraController?.setFlashMode(FlashMode.off);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Rate Monitor'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_cameraController?.value.isInitialized ?? false)
            AspectRatio(
              aspectRatio: _cameraController!.value.aspectRatio,
              child: CameraPreview(_cameraController!),
            )
          else
            const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            _isMeasuring ? 'BPM: $_bpm' : 'Press start to measure',
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _isMeasuring ? _stopMeasurement : _startMeasurement,
            child: Text(_isMeasuring ? 'Stop Measuring' : 'Start Measuring'),
          ),
        ],
      ),
    );
  }
}
