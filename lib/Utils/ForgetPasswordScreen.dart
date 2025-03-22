import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../common/app_colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool value = false;
  bool checkedValue = true;
  bool _isCodeSent = false;
  String _otpCode = '';
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.primaryColor]),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Forget Password*',
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'FontPoppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const Text(
                  'Enter your registered mobile number to forget your password!',
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 220.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (!_isCodeSent) ...[
                      IntlPhoneField(
                        flagsButtonPadding: const EdgeInsets.all(8),
                        dropdownIconPosition: IconPosition.trailing,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: const TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                          filled: true,
                          fillColor: Colors.lightBlue[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isCodeSent = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(
                                    color: Colors.white,
                                    width: 0.1) // <-- Radius
                                ),
                          ),
                          child: const Text(
                            'Send Code',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ] else ...[
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
                        'A 6 digit code has been sent to your mobile number',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
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
                            _errorText = null;
                          });
                        },
                        currentCode: _otpCode,
                        decoration: BoxLooseDecoration(
                          strokeColorBuilder:
                              const FixedColorBuilder(AppColors.primaryColor),
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
                      if (_errorText !=
                          null) // Display error message if it exists
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _errorText!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontFamily: 'FontPoppins',
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_otpCode.length == 6) {
                                Fluttertoast.showToast(msg: 'OTP Verified');
                                _errorText = null; // Clear any error
                              } else {
                                _errorText = 'Please enter a 6-digit OTP'; // Set error message
                              }
                            });
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
