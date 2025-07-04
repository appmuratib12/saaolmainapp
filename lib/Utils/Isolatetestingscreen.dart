import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

Future<void> runInIsolate() async {
  final receivePort = ReceivePort();

  // Spawning isolate and passing sendPort
  await Isolate.spawn(heavyTask, receivePort.sendPort);

  // Listening for result
  final result = await receivePort.first;
  print('Result from Isolate: $result');
}

void heavyTask(SendPort sendPort) {
  int result = 0;
  for (int i = 0; i < 100000000; i++) {
    result += i;
  }
  sendPort.send(result);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Isolate Example")),
        body: Center(
          child: ElevatedButton(
            onPressed: runInIsolate,
            child: const Text("Run Heavy Task"),
          ),
        ),
      ),
    );
  }
}
