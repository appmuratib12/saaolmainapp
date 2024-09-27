import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';

import '../common/app_colors.dart';
import 'LocationScreen.dart';

class OtpPhoneWidget extends StatefulWidget {
  const OtpPhoneWidget({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpPhoneWidget> {
  TextEditingController otpController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void verifyOtp(String otp) {
    if (otp == '123456') {
      scaffoldKey.currentState!.showSnackBar(
        const SnackBar(content: Text('OTP Verified')),
      );
    } else {
      scaffoldKey.currentState!.showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    }
  }

  // Timer for OTP resend simulation
  int start = 30;
  late Timer _timer;
  bool isTimerRunning = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            isTimerRunning = false;
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  void resetTimer() {
    setState(() {
      start = 30;
      isTimerRunning = true;
    });
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    errorController!.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
  }

  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "OTP Verification",
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/otp_image3.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Verify OTP',
                style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'A 6 digit code has been sent to:',
                style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              const Text(
                '9068544483',
                style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height:20,
              ),
              const Text(
                'Enter the verification code here',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: formKey,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.grey[200],
                    selectedFillColor: Colors.grey[300],
                    activeColor: AppColors.primaryColor,
                    inactiveColor: AppColors.secondaryColor,
                    selectedColor: AppColors.primaryColor,
                    borderWidth: 1,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  onChanged: (value) {
                    setState(() {
                      currentText = value;
                    });
                  },
                  validator: (v) {
                    if (v!.length < 3) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
                  },
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: const TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 12,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  isTimerRunning
                      ? Text(
                          'Resend OTP in $start seconds',
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        )
                      : TextButton(
                          onPressed: () {
                            // Implement resend OTP logic here
                            resetTimer(); // Start the timer again
                          },
                          child: const Text(
                            'Resend OTP',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 55,
                width: screenWidth * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              ShareLocationScreen()),
                    );
                    formKey.currentState!.validate();
                    if (currentText.length != 6 || currentText != "123456") {
                      errorController!.add(ErrorAnimationType
                          .shake); // Triggering error shake animation
                      setState(() => hasError = true);
                    } else {
                      setState(
                        () {
                          hasError = false;
                        },
                      );
                    }
                    verifyOtp(currentText);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

