import 'dart:async';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:saaolapp/data/model/requestmodel/RegisterRequestData.dart';
import 'package:saaolapp/data/network/ChangeNotifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../DialogHelper.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../constant/ValidationCons.dart';
import '../data/network/ApiService.dart';
import 'LocationScreen.dart';
import 'MyHomePageScreen.dart';

class LoginOtpScreen extends StatefulWidget {
  final String phone;
  const LoginOtpScreen({super.key, required this.phone});

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  bool value = false;
  bool checkedValue = true;
  String mobileNumber = '';
  String storeKey = '';
  String googleID = '';
  bool isOTPSent = false;
  String? _otpCode;
  String? _errorText;


  TextEditingController userNameController = TextEditingController();
  TextEditingController userMobileNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final ApiService _apiService = ApiService();
  String selectedCountryCode = '+91'; // Default country code (e.g., USA)
  String? getMobileNumber;
  late SharedPreferences sharedPreferences;
  String? locality;
  String? subLocality;

  Future<void> _sendOTP() async {
    final phoneNumber = userMobileNumber.text.trim();
    final phone = widget.phone;

    if (phoneNumber.isNotEmpty && phoneNumber == phone){
       DialogHelper.showLoadingDialog(context);

      try {
        final otpResponse = await _apiService.sendOTP(phoneNumber, storeKey);
        Navigator.pop(context);
        if (otpResponse != null && otpResponse.status == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP sent successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          setState(() {
            isOTPSent = true; // Update state to show the OTP screen
          });

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
        // Handle request timeout
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
  Future<void> _verifyOTP1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_otpCode != null && _otpCode!.length == 6) {
      DialogHelper.showLoadingDialog(context); // Show
      ApiService apiService = ApiService();
      String platform = Platform.isAndroid ? 'android' : Platform.isIOS ? 'ios' : 'unknown';
      String deviceId = await getDeviceId();
      var otpVerificationResult = await apiService.verifyOTP(widget.phone, _otpCode!,platform,deviceId,context);
      Navigator.pop(context);
      print('OTPCODE:$_otpCode');

      if (otpVerificationResult != null && otpVerificationResult.status == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(otpVerificationResult.message ?? 'OTP verified successfully.'),
              backgroundColor: Colors.green),);
        var patientDetails = await apiService.verifyPatient(widget.phone);
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
        } else {
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



  @override
  void initState() {
    super.initState();
    getDeviceId();
    _printAppSignature();
    userMobileNumber.text = widget.phone;
  }

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

  Future<void> _printAppSignature() async {
    String? appSignature = await SmsAutoFill().getAppSignature;
    storeKey = appSignature.toString();
    print('AppKey: $storeKey');
    print("App Signature: $appSignature");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green.shade600, AppColors.primaryColor]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Sign In With Safety Circle*',
                    style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'FontPoppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Enter your details to get started!',
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
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
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
                    children: [isOTPSent
                        ? Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300, width: 0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Verification Code',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 20,
                                letterSpacing:0.3,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
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
                          Text(widget.phone.toString(),
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
                            height: 5,
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
                                    const FixedColorBuilder(AppColors.primaryColor),
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
                            height:40,
                          ),
                          SizedBox(
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                //_verifyOTP();
                                _verifyOTP1();
                                //getUserLocation();
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
                      ),
                    )
                        : Column(
                      children: [
                        Form(
                          key: _formKey,
                          autovalidateMode: autovalidateMode,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                'Mobile',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      child: CountryCodePicker(
                                        onChanged: (country) {
                                          setState(() {
                                            selectedCountryCode = country.dialCode!;
                                          });
                                        },
                                        initialSelection: 'IN',
                                        favorite: const ['+91', 'IN'],
                                        showCountryOnly: false,
                                        showFlag: true,
                                        showFlagDialog: true,
                                        alignLeft: true,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 7,
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        controller: userMobileNumber,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter your Mobile Number',
                                          hintMaxLines: 1,
                                          hintStyle: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding:
                                          EdgeInsets.symmetric(vertical: 0.0),
                                        ),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'FontPoppins',
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        validator: (value) {
                                          return ValidationCons().validateMobile(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
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
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                      color: Colors.white, width: 0.1)),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
