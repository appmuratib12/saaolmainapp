import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../common/app_colors.dart';
import 'LocationScreen.dart';


class OTPVerifyScreen extends StatefulWidget {
  const OTPVerifyScreen({super.key});

  @override
  _OTPVerifyScreenState createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> with CodeAutoFill {
  final _formKey = GlobalKey<FormState>();
  String _otpCode = '';
  int start = 30;
  bool isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _requestSmsPermission();
    listenForCode();
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  Future<void> _requestSmsPermission() async {
    await Permission.sms.request();
  }

  @override
  void codeUpdated() {
    setState(() {
      _otpCode = code!;
    });
    _submitOtp();
  }

  void _submitOtp() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
             const ShareLocationScreen()),
      );
      // Handle OTP submission logic here
      print("OTP Submitted: $_otpCode");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: Image(
                      image: AssetImage('assets/images/otp_image3.jpg'),
                      fit: BoxFit.fill,
                      height: 150),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Verification Code',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'We have sent the code verification to your mobile number:',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
                const SizedBox(
                  height: 10,
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
                  height: 25,
                ),
                const Text(
                  'Enter the verification code here',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
                PinFieldAutoFill(
                  codeLength: 6,
                  onCodeChanged: (code) {
                    setState(() {
                      _otpCode = code ?? '';
                    });
                  },
                  currentCode: _otpCode,
                  decoration: BoxLooseDecoration(
                    strokeColorBuilder: const FixedColorBuilder(Colors.black),
                    bgColorBuilder:
                        FixedColorBuilder(Colors.grey.withOpacity(0.1)),
                    radius: const Radius.circular(8.0),
                    strokeWidth: 2.0,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  height: 55,
                  width: screenWidth * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      _submitOtp();
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
                const SizedBox(
                  height: 10,
                ),
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
                            onPressed: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
