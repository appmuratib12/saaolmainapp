import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:saaoldemo/Utils/LocationScreen.dart';
import 'package:saaoldemo/Utils/RegScreen.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../data/network/ApiService.dart';

class OTPPage extends StatefulWidget {
  final String phoneNumber;

  const OTPPage({super.key, required this.phoneNumber});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> with CodeAutoFill {
  String? _otpCode;
  String? appSignature;
  final _formKey = GlobalKey<FormState>();
  String? _errorText;
  int start = 30;
  bool isTimerRunning = false;



  @override
  void initState() {
    super.initState();
    listenForCode();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
    print("Listening for OTP code...");
  }

  @override
  void codeUpdated() {
    setState(() {
      _otpCode = code!;
    });
    print("Code received: $_otpCode"); // Debug statement

  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  Future<void> _verifyOTP1() async {
    if (_otpCode != null && _otpCode!.length == 6) {
      _showLoadingDialog();
      ApiService apiService = ApiService();
      var otpVerificationResult = await apiService.verifyOTP(widget.phoneNumber, _otpCode!,context);
      Navigator.pop(context); // Close loading dialog
      print('OTPCODE:$_otpCode');

      if (otpVerificationResult != null && otpVerificationResult.success == true) {
        print("OTP verified successfully.Status: ${otpVerificationResult.success}");
        print("OTP verified successfully. ${otpVerificationResult.message}");
        var patientDetails = await apiService.verifyPatient('8800695632');
        if (patientDetails != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool(ApiConstants.IS_LOGIN, true);
          print("Patient verified successfully.Details: ${patientDetails.status}");
          Navigator.push(context,MaterialPageRoute(builder: (context) => const ShareLocationScreen()));

        } else {
          //showThankYouDialog(context);
          Navigator.push(context,MaterialPageRoute(builder: (context) => RegScreen(isFromOTP:true)));
          print("Patient not found or phone number is incorrect.");
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP not found for this mobile number.'),
            backgroundColor: Colors.red,
          ),
        );
        print("OTP not found for this mobile number.");
      }
    } else {
      print("Please enter a valid OTP.");
    }
  }

  void showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: -10,
                top: -10,
                child: IconButton(
                  icon:  const Icon(Icons.close, color:AppColors.primaryColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_rounded,
                      color: Colors.red,
                      size: MediaQuery.of(context).size.width * 0.2,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Verification Failed!',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'you are not registered.pls contact us on ____',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Call us',
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 16,
                            letterSpacing:0.1,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Center(
                child: Image(
                  image: const AssetImage('assets/images/update_otp_Image.jpeg'),
                  fit: BoxFit.cover,height:180,width:MediaQuery.of(context).size.width,),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(color:Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side:BorderSide(color:Colors.grey.withOpacity(0.5),width:0.5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Verification Code',
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
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
                      Text(
                        widget.phoneNumber.toString(),
                        style: const TextStyle(
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
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            PinFieldAutoFill(
                              codeLength: 6,
                              onCodeChanged: (code) {
                                if (code != null && code.length == 6) {
                                  setState(() {
                                    _otpCode = code ?? '';
                                    _errorText = null;
                                  });
                                  FocusScope.of(context).requestFocus(FocusNode());
                                }
                              },
                              onCodeSubmitted: (code) {
                                print("Code submitted: $code");
                              },
                              currentCode: _otpCode,
                              decoration: BoxLooseDecoration(
                                strokeColorBuilder:
                                const FixedColorBuilder(AppColors.primaryDark),
                                bgColorBuilder:
                                FixedColorBuilder(Colors.grey.withOpacity(0.1)),
                                radius: const Radius.circular(8.0),
                                strokeWidth: 2.0,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(height:40),
              SizedBox(
                height: 55,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    _verifyOTP1();
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
              const SizedBox(
                height:10,
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
    );
  }
}
