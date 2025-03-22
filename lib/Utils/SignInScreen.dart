import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:saaoldemo/Utils/LocationScreen.dart';
import 'package:saaoldemo/constant/ApiConstants.dart';
import '../common/app_colors.dart';
import '../constant/GoogleSignInService.dart';
import '../data/network/ApiService.dart';
import 'ForgetPasswordScreen.dart';
import 'OTPVerifyScreen.dart';
import 'RegScreen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool value = false;
  bool checkedValue = true;
  String mobileNumber = '';
  String storeKey = '';
  String googleID = '';


  TextEditingController userMobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  final ApiService _apiService = ApiService();


  Future<void> _sendOTP() async {
    final phoneNumber = userMobileController.text;
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //String? registeredPhone = prefs.getString('registered_phone');
    //print('registeredPhone:$registeredPhone');

   /* if (registeredPhone != null && phoneNumber != registeredPhone) {
      _showSnackBar('The phone number does not match the registered number.', Colors.red);
      return;
    }*/
    if (phoneNumber.isNotEmpty) {
        _showLoadingDialog();

      try {

        final otpResponse = await _apiService.sendOTP(phoneNumber, storeKey);
        Navigator.pop(context);
        if (otpResponse != null && otpResponse.status == "success") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('login_method', 'otp'); // Save login method
          await prefs.setString(ApiConstants.SINGIN_MOBILENUMBER,userMobileController.text); // Save login method

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPPage(phoneNumber: phoneNumber)),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP sent successfully.'),
              backgroundColor: Colors.green,
            ),
          );

          print('OTP SUCCESS:${otpResponse.status}');

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to send OTP. Try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } on SocketException {
        Navigator.pop(context); // Dismiss the loading dialog
        Fluttertoast.showToast(
          msg: "No internet connection. Please check your network.",
        );
      } on TimeoutException {
        Navigator.pop(context); // Dismiss the loading dialog
        Fluttertoast.showToast(
          msg: "Request timed out. Please try again.",
        );
      } catch (error) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "An error occurred. Please try again.");
      }
      } else {
      _showSnackBar('Please enter valid details.', Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16.0),
      ),
    );
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: CupertinoActivityIndicator(
              color: Colors.white,
              radius: 20,
            ),
          ),
        ),
      ),
    );
  }

  /* Future<void> _sendOTP() async {
    final phoneNumber = userMobileController.text;
    final otpResponse = await _apiService.sendOTP(phoneNumber);
    if (otpResponse != null && otpResponse.status == "success") {
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => OtpScreen(phoneNumber: phoneNumber)));
      Fluttertoast.showToast(msg: "OTP sent successfully!");
    } else {
      Fluttertoast.showToast(msg: "Failed to send OTP. Try again.");
    }
  }*/
  @override
  void initState() {
    super.initState();
    _printAppSignature();
    _loadCounter();
  }

  Future<void> _printAppSignature() async {
    String? appSignature = await SmsAutoFill().getAppSignature;
    storeKey = appSignature.toString();
    print('AppKey: $storeKey');
    print("App Signature: $appSignature");
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mobileNumber = (prefs.getString(ApiConstants.USER_MOBILE_NUMBER) ?? '');
      googleID = (prefs.getString('GoogleUserID') ?? '');
    });
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  GoogleSignInAccount? _user;

  Future<void> _handleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      setState(() {
        _user = account;
      });
      if (_user != null) {
        _incrementCounter();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool(ApiConstants.IS_LOGIN, true); // Save login state
        await prefs.setString('login_method', 'google'); // Save login method

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>const ShareLocationScreen(),
          ),
        );
        print('GoogleID:${_user!.id.toString()}');

      }
    } catch (error) {
      print('Sign-In Error: $error');
    }
  }

  Future<void> _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('GoogleUserName',_user!.displayName.toString());
    await prefs.setString('GoogleUserEmail',_user!.email.toString());
    await prefs.setString('GoogleUserID',_user!.id.toString());
    await prefs.setString('GoogleUserProfile',_user!.photoUrl.toString());
  }



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
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Sign In*',
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'FontPoppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Enter your mobile number to get started!',
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
          padding: const EdgeInsets.only(top: 200.0),
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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    const Text(
                      'Phone Number',
                      style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey,
                      autovalidateMode: autovalidateMode,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IntlPhoneField(
                            controller: userMobileController,
                            keyboardType: TextInputType.phone,
                            flagsButtonPadding: const EdgeInsets.all(8),
                            dropdownIconPosition: IconPosition.trailing,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: const TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87),
                              filled: true,
                              fillColor: Colors.lightBlue[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),

                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                            ),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'FontPoppins',
                                fontSize: 16,
                                color: Colors.black),
                            validator: (phone) {
                              if (phone == null ||
                                  phone.completeNumber.isEmpty) {
                                return 'Phone number is required';
                              }
                              if (!RegExp(r'^\+?[1-9]\d{1,14}$')
                                  .hasMatch(phone.completeNumber)) {
                                return 'Invalid phone number format';
                              }
                              return null; // Return null if the phone number is valid
                            },
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                          ),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const ForgetPasswordScreen()),
                        );
                      },
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forget Password',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ),

                    const Text(
                      'you will receive an SMS to verify your identity, but we will never spam you.',
                      style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _sendOTP();
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(
                                  color: Colors.white, width: 0.1) // <-- Radius
                              ),
                        ),
                        child: const Text(
                          'Get verification code',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Don’t have an account? ',
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                             const RegScreen(isFromOTP: false)),
                                  );
                                  Fluttertoast.showToast(msg:'Hi');
                                },
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Or Sign In with',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Divider(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            _handleSignIn();
                            /*final googleUser =
                                await _googleSignInService.signInWithGoogle();
                            if (googleUser != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Signed in as ${googleUser.displayName}'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Failed to sign in with Google'),
                                ),
                              );
                            }*/
                          },
                          child: Container(
                            height: 50,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.4),
                                  width: 0.6,
                                )),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                image: AssetImage('assets/images/google.png'),
                                width: 40,
                                height: 30,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                       /* Container(
                          height: 50,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.4),
                                width: 0.6,
                              )),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Image(
                              image: AssetImage('assets/images/facebook.png'),
                              width: 40,
                              height: 30,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.4),
                                width: 0.6,
                              )),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Image(
                              image: AssetImage('assets/images/linkedin.png'),
                              width: 40,
                              height: 30,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),*/
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(height: 20),

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
