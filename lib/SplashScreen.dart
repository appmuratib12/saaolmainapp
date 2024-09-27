import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testingproject/Utils/SliderScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
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
      nextScreen:OnBoardingScreen(),
      splashIconSize: 250,
      duration: 5000,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}
