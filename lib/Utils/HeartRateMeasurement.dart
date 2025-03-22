import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';

class HeartRateMonitor extends StatefulWidget {
  const HeartRateMonitor({super.key});

  @override
  _HeartRateMonitorState createState() => _HeartRateMonitorState();
}

class _HeartRateMonitorState extends State<HeartRateMonitor> {
  List<SensorValue> rawData = [];
  List<SensorValue> bpmValues = [];
  bool isBPMEnabled = false;
  double? currentBPM; // Store the current BPM value
  Widget? dialog;
  double bpmThreshold = 100; // Limit BPM to under 100

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Heart BPM Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isBPMEnabled
                ? dialog = HeartBPMDialog(
                    context: context,
                    showTextValues: true,
                    borderRadius: 10,
                    onRawData: (value) {
                      setState(() {
                        // Filter the raw data for more accuracy
                        if (rawData.length >= 200) rawData.removeAt(0);
                        rawData.add(value);
                      });
                    },
                    onBPM: (value) => setState(() {
                      double bpm = value.toDouble();

                      if (bpm > 0 && bpm <= bpmThreshold) {
                        if (bpmValues.length >= 200) bpmValues.removeAt(0);
                        bpmValues
                            .add(SensorValue(value: bpm, time: DateTime.now()));
                        currentBPM = bpm; // Update current BPM if valid
                      }
                    }),
                    sampleDelay: 1000 ~/
                        30, // Capture at a rate of 30 samples per second
                  )
                : const SizedBox(),
            isBPMEnabled && rawData.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(border: Border.all()),
                    height: 180,
                    child: BPMChart(rawData),
                  )
                : const SizedBox(),
            isBPMEnabled && bpmValues.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(border: Border.all()),
                    constraints: const BoxConstraints.expand(height: 180),
                    child: BPMChart(bpmValues),
                  )
                : const SizedBox(),
            isBPMEnabled && currentBPM != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Current BPM: ${currentBPM!.toStringAsFixed(1)}',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isBPMEnabled = !isBPMEnabled;
                  });
                },
                child: Container(
                  height: 160,
                  width: 160,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isBPMEnabled ? "Stop Measurement" : "Measure BPM",
                        style: const TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 35,
                      ),
                    ],
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
