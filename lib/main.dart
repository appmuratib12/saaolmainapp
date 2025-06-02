import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:saaolapp/common/app_colors.dart';
import 'package:sqflite/sqflite.dart';
import 'package:upgrader/upgrader.dart';
import 'SplashScreen.dart';
import 'Utils/NotificationScreen.dart';
import 'data/network/ChangeNotifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await deleteDatabaseFile();
  await Firebase.initializeApp();
  initializeNotifications();
  clearCache();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DataClass()),
    ],
    child: const MyApp(),
  ));
}

Future<void> deleteDatabaseFile() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'notifications.db');
  await deleteDatabase(path);
}

Future<void> clearCache() async {
  try {
    final cacheDir = await getTemporaryDirectory();
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
      print("Cache cleared");
    }
  } catch (e) {
    print("Error clearing cache: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setupFCM(context);
        initializeNotifications();
      });

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Saaol App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home: UpgradeAlert(
          upgrader: Upgrader(),
          child: const SplashScreen(),
        ),
      );
    });
  }
}
