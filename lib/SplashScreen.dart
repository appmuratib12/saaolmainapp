import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/Utils/MyHomePageScreen.dart';
import 'package:saaoldemo/Utils/SliderScreen.dart';
import 'package:saaoldemo/constant/ApiConstants.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget nextScreen = const OnBoardingScreen(); // Default screen


  @override
  void initState() {
    super.initState();
    _checkLoginStatus1();
  }



  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(ApiConstants.IS_LOGIN) ?? false;
    // Set the next screen based on login status
    setState(() {
      nextScreen = isLoggedIn
          ? const HomePage(initialIndex: 0)
          : const OnBoardingScreen();
    });
  }


  Future<void> _checkLoginStatus1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(ApiConstants.IS_LOGIN) ?? false;

    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
    GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();

    setState(() {
      nextScreen = (isLoggedIn || googleUser != null)
          ? const HomePage(initialIndex: 0)
          : const OnBoardingScreen();
    });
  }



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
      nextScreen: nextScreen,
      splashIconSize:200,
      duration: 5000,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}
