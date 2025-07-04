import 'dart:io';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaolapp/Utils/MyHomePageScreen.dart';
import 'package:saaolapp/constant/ApiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';
import 'SignInScreen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController1 = PageController(initialPage: 0);
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kOnBoardingColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 5,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: onBoardinglist.length,
              physics: const BouncingScrollPhysics(),
              controller: _pageController1,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnBoardingCard(
                  onBoardingModel: onBoardinglist[index],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: DotsIndicator(
              dotsCount: onBoardinglist.length,
              position: _currentIndex,
              decorator: DotsDecorator(
                color: AppColors.primaryColor.withOpacity(0.4),
                size: const Size.square(8.0),
                activeSize: const Size(20.0, 8.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height:30),
          /*Padding(
            padding: const EdgeInsets.only(left: 25, right: 23, bottom:70),
            child: PrimaryButton(
              elevation: 0,
              onTap: () {

                if (_currentIndex == onBoardinglist.length - 1) {
                  FirebaseAnalytics.instance.logEvent(name: 'onboarding_completed');
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const SignInScreen()),
                  );
                } else {
                  FirebaseAnalytics.instance.logEvent(
                    name: 'onboarding_next_tapped',
                    parameters: {'page_index': _currentIndex},
                  );
                  _pageController1.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              text: _currentIndex == onBoardinglist.length - 1
                  ? 'Get Started'
                  : 'Next',
              bgColor: AppColors.primaryColor,
              borderRadius: 30,
              height: 46,
              width: double.infinity,
              textColor: Colors.white,
              fontSize: 18,
            ),

          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 23, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PrimaryButton(
                  elevation: 0,
                  onTap: () {
                    if (_currentIndex == onBoardinglist.length - 1) {
                      FirebaseAnalytics.instance.logEvent(name: 'onboarding_completed');
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SignInScreen()),
                      );
                    } else {
                      FirebaseAnalytics.instance.logEvent(
                        name: 'onboarding_next_tapped',
                        parameters: {'page_index': _currentIndex},
                      );
                      _pageController1.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  },
                  text: _currentIndex == onBoardinglist.length - 1
                      ? 'Get Started'
                      : 'Next',
                  bgColor: AppColors.primaryColor,
                  borderRadius: 30,
                  height: 46,
                  width: double.infinity,
                  textColor: Colors.white,
                  fontSize: 18,
                ),
                const SizedBox(height: 16),
                if (Platform.isIOS && _currentIndex == onBoardinglist.length - 1)
                  TextButton(
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool(ApiConstants.IS_GUEST, true);
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(builder: (_) => const HomePage(initialIndex: 0)),
                      );
                    },
                    child: const Text(
                      "Continue as Guest",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FontPoppins',
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius, elevation;
  final double? fontSize;
  final IconData? iconData;
  final Color? textColor, bgColor;

  const PrimaryButton(
      {super.key,
        required this.onTap,
        required this.text,
        this.width,
        this.height,
        this.elevation = 5,
        this.borderRadius,
        this.fontSize,
        required this.textColor,
        required this.bgColor,
        this.iconData});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);


  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: widget.elevation ?? 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
          ),
          child: Container(
            height: widget.height ?? 55,
            alignment: Alignment.center,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)
                  .copyWith(
                  color: widget.textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: widget.fontSize),
            ),
          ),
        ),
      ),
    );
  }
}

class OnBoardingCard extends StatefulWidget {
  OnBoarding onBoardingModel;

  OnBoardingCard({
    super.key,
    required this.onBoardingModel,
  });

  @override
  State<OnBoardingCard> createState() => _OnBoardingCardState();
}

class _OnBoardingCardState extends State<OnBoardingCard> {
  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'OnBoardingScreen');
    FirebaseAnalytics.instance.logEvent(name: 'onboarding_started');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        children: [
          Image.asset(
            widget.onBoardingModel.image,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          const SizedBox(height:30,),
          Text(
            widget.onBoardingModel.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.kGrayscaleDark100,
            ).copyWith(
                fontSize:19,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          const SizedBox(
            height: 16,
          ),
          Flexible(
            child: Text(widget.onBoardingModel.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoarding {
  String title;
  String description;
  String image;

  OnBoarding({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnBoarding> onBoardinglist = [
  OnBoarding(
    title: onBoardingTitle1,
    image: ApiConstants.kOnboarding1,
    description: onBoardingDescription1,
  ),

  /*OnBoarding(
      title: onBoardingTitle2,
      image: ApiConstants.kOnboarding2,
      description: onBoardingDescription2),
  OnBoarding(
      title: onBoardingTitle3,
      image: ApiConstants.kOnboarding3,
      description:
      onBoardingDescription3),*/
];

