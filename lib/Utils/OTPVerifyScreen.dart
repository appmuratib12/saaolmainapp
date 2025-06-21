import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saaolapp/Utils/MyHomePageScreen.dart';
import 'package:saaolapp/data/model/requestmodel/RegisterRequestData.dart';
import 'package:saaolapp/data/network/ChangeNotifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../DialogHelper.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../data/network/ApiService.dart';
import 'LocationScreen.dart';
import 'RegScreen.dart';

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

  /* @override
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
  }*/

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      if (!mounted) return;
      setState(() {
        appSignature = signature;
      });
    });
    print("Listening for OTP code...");
  }

  @override
  void codeUpdated() {
    if (!mounted) return;
    setState(() {
      _otpCode = code!;
    });
    print("Code received: $_otpCode");
  }

  void onCodeChanged(
    String? code,
    BuildContext context,
  ) {
    setState(() {
      _otpCode = code ?? '';
    });
    if (_otpCode != null && _otpCode!.length == 6) {
      _verifyOTP1(); // Automatically verify OTP
    }
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  /* @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }*/


  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id ?? 'android-unknown';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'ios-unknown';
      } else {
        return 'unsupported-platform';
      }
    } catch (e) {
      print('Error getting device ID: $e');
      return 'error';
    }
  }

  Future<void> _verifyOTP1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isRegistered = prefs.getBool('isRegistered') ?? false;

    print('isRegistered:$isRegistered');
    if (_otpCode != null && _otpCode!.length == 6) {
      if (widget.phoneNumber == '9999999999' && _otpCode == '123456') {
        await prefs.setBool(ApiConstants.IS_LOGIN, true);
        await prefs.setBool('isDemoUser', true); // Optional: mark demo
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage(initialIndex: 0)),
        );
        return;
      }

      DialogHelper.showLoadingDialog(context); // Show
      ApiService apiService = ApiService();
      String platform = Platform.isAndroid ? 'android' : Platform.isIOS ? 'ios' : 'unknown';
      String deviceId = await getDeviceId();
      print('Platform: $platform, Device ID: $deviceId');
      var otpVerificationResult = await apiService.verifyOTP(widget.phoneNumber,_otpCode!,deviceId,platform,context);
      Navigator.pop(context);
      print('OPCODE:$_otpCode');


      if (otpVerificationResult != null && otpVerificationResult.status == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(otpVerificationResult.message ?? 'OTP verified successfully.'),
            backgroundColor: Colors.green),);
        var patientDetails = await apiService.verifyPatient(widget.phoneNumber);
        await prefs.setBool(ApiConstants.IS_LOGIN, true);

        if (patientDetails != null) {
          print("Patient verified successfully.Details: ${patientDetails.status}");
          final patient = patientDetails.data!.first;
          String patientName = patient.pmFirstName ?? '';
          String patientEmail = patient.pmEmail ?? '';
          String patientMobile = patient.pmContactNo ?? '';
          RegisterRequestData requestData = RegisterRequestData(
              name: patientName,
              email: patientEmail,
              mobile: patientMobile,
              country_code:'+91',
              password:'123456789'
          );
          var provider = Provider.of<DataClass>(context, listen: false);
          await provider.postUserRegisterRequest(requestData);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ShareLocationScreen()));
        } else if (!isRegistered) {
          // No patient found & not registered yet
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegScreen(isFromOTP: true)));
        } else {
          // Already registered user (logged out and logging in again)
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(initialIndex: 0)));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP not found for this mobile number.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      print("Please enter a valid OTP.");
    }
  }

 /* Future<void> _verifyOTP1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isRegistered = prefs.getBool('isRegistered') ?? false;

    print('isRegistered:$isRegistered');
    if (_otpCode != null && _otpCode!.length == 6) {
      DialogHelper.showLoadingDialog(context); // Show
      ApiService apiService = ApiService();
      var otpVerificationResult =
          await apiService.verifyOTP(widget.phoneNumber, _otpCode!, context);
      Navigator.pop(context);
      print('OTPCODE:$_otpCode');

      if (otpVerificationResult != null &&
          otpVerificationResult.status == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(otpVerificationResult.message ??
                  'OTP verified successfully.'),
              backgroundColor: Colors.green),
        );
        var patientDetails = await apiService.verifyPatient(widget.phoneNumber);
        await prefs.setBool(ApiConstants.IS_LOGIN, true);

        if (patientDetails != null) {
          print(
              "Patient verified successfully.Details: ${patientDetails.status}");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShareLocationScreen()));
        } else if (!isRegistered) {
          // No patient found & not registered yet
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegScreen(isFromOTP: true)));
        } else {
          // Already registered user (logged out and logging in again)
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomePage(initialIndex: 0)));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP not found for this mobile number.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      print("Please enter a valid OTP.");
    }
  }*/

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
      backgroundColor: Colors.grey[200],
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
                  image:
                      const AssetImage('assets/images/update_otp_Image.jpeg'),
                  fit: BoxFit.cover,
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.white,
                elevation: 5,
                shadowColor: Colors.grey.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 0.5)),
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
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'We have sent an OTP to your mobile number:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 14,
                          color: Colors.black87,
                        ),
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
                             /* onCodeChanged: (code) {
                                if (code != null && code.length == 6) {
                                  setState(() {
                                    _otpCode = code ?? '';
                                    _errorText = null;
                                  });
                                 FocusScope.of(context).requestFocus(FocusNode());
                                  _verifyOTP1();
                                }
                              },*/
                              onCodeChanged: (code) {
                                if (code != null && code.length == 6) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    if (!mounted) return;
                                    setState(() {
                                      _otpCode = code;
                                      _errorText = null;
                                    });
                                    FocusScope.of(context).unfocus();
                                    _verifyOTP1();
                                  });
                                }
                              },


                              // onCodeChanged: (code) {
                              //   if (code != null && code.length == 6) {
                              //     setState(() {
                              //       _otpCode = code ?? '';
                              //       _errorText = null;
                              //     });
                              //     FocusScope.of(context).requestFocus(FocusNode());
                              //   }
                              // },
                              onCodeSubmitted: (code) {
                                print("Code submitted: $code");
                              },
                              currentCode: _otpCode,
                              decoration: BoxLooseDecoration(
                                strokeColorBuilder: const FixedColorBuilder(
                                    AppColors.primaryDark),
                                bgColorBuilder: FixedColorBuilder(
                                    Colors.grey.withOpacity(0.1)),
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
              const SizedBox(
                height: 10,
              ),
              /*Row(
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
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
