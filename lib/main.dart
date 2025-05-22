
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saaolapp/common/app_colors.dart';
import 'package:upgrader/upgrader.dart';
import 'SplashScreen.dart';
import 'Utils/NotificationScreen.dart';
import 'data/network/ChangeNotifier.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DataClass()),
  ], child: const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(builder:(context){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setupFCM(context);
        initializeNotifications();
      });
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Saaol App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor:AppColors.primaryColor),
            useMaterial3: true,
          ),
          home: SplashScreen(),
      );
    });
  }
}
