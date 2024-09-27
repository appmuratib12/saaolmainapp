import 'package:flutter/material.dart';
import 'package:heart_bpm/heart_bpm.dart';


class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({super.key});

  @override
  _HeartRateScreenState createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  int? _bpm;

  void _startHeartRateDetection() {
    showDialog(
      context: context,
      builder: (context) => HeartBPMDialog(
        context: context,
        onRawData: (value) {
          // You can process raw data here, but it’s optional.
        },
        onBPM: (bpm) {
          // Called when the heart rate (BPM) is calculated.
          setState(() {
            _bpm = bpm;
          });
        },
        sampleDelay: 1000 ~/ 30, // Set the sampling rate (30 FPS).
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate Measurement'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _bpm != null
                ? Text(
              'BPM: $_bpm',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
                : Text(
              'Press Start to Measure',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startHeartRateDetection,
              child: Text('Start Measuring'),
            ),
          ],
        ),
      ),
    );
  }
}
