import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/MyHomePageScreen.dart';
import 'Utils/SliderScreen.dart';
import 'constant/ApiConstants.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget? nextScreen;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }


  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(ApiConstants.IS_LOGIN) ?? false;
    print("IS_LOGIN value: $isLoggedIn");
    setState(() {
      nextScreen = isLoggedIn
          ?  const HomePage(initialIndex: 0)
          :  const OnBoardingScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (nextScreen == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              'assets/images/saool_logo.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      );
    }
    return AnimatedSplashScreen(
      splash: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Image.asset(
            'assets/images/saool_logo.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      nextScreen: nextScreen!,
      splashIconSize: 200,
      duration:3500,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}
