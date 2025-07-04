import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../data/network/ApiService.dart';
import 'OTPVerifyScreen.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  bool value = false;
  bool checkedValue = true;
  String mobileNumber = '';
  String storeKey = '';
  String googleID = '';

  TextEditingController userMobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final ApiService _apiService = ApiService();



  Future<void> _sendOTP() async {
    final phoneNumber = userMobileController.text;
    _showLoadingDialog();

    try {
      final otpResponse = await _apiService.sendOTP(phoneNumber, storeKey);
      Navigator.pop(context);
      if (otpResponse != null && otpResponse.status == "success") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool(ApiConstants.IS_LOGIN, true);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OTPPage(phoneNumber: phoneNumber)),
        );
        Fluttertoast.showToast(msg: "OTP sent successfully!");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send OTP. Try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "An error occurred. Please try again.");
    }
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
      googleID = (prefs.getString(ApiConstants.IDENTIFIER_TOKEN) ?? '');
    });
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
                    'Verify User*',
                    style: TextStyle(
                        fontSize:16,
                        fontFamily: 'FontPoppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height:5),
                  Text(
                    'Enter your mobile number to get started!',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize:14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:170.0),
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
                    children: [
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize:14,
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
                                    fontSize:15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                                filled: true,
                                fillColor: Colors.lightBlue[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                              ),
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
                      const SizedBox(height:10,),
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
                                    color: Colors.white,
                                    width: 0.1) // <-- Radius
                                ),
                          ),
                          child: const Text(
                            'Get verification code',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize:16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
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
