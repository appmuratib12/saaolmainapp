import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../DialogHelper.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../constant/ValidationCons.dart';
import '../data/model/requestmodel/RegisterRequestData.dart';
import '../data/network/ApiService.dart';
import '../data/network/ChangeNotifier.dart';
import 'LocationScreen.dart';
import 'LoginOtpScreen.dart';
import 'NotificationScreen.dart';
import 'SignInScreen.dart';


class RegScreen extends StatefulWidget {
  final bool isFromOTP;
  const RegScreen({super.key,required this.isFromOTP});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  bool _obscureText = true;
  bool value = false;
  bool checkedValue = true;

  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userConfirmPasswordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final ApiService apiService = ApiService();


  @override
  void dispose() {
    userPasswordController.dispose();
    userConfirmPasswordController.dispose();
    super.dispose();
  }


  Future<void> _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ApiConstants.USER_NAME, userNameController.text.trim());
    await prefs.setString(ApiConstants.USER_EMAIL, userEmailController.text.trim());
    await prefs.setString(ApiConstants.USER_PASSWORD, userPasswordController.text.trim());
    await prefs.setString(ApiConstants.USER_MOBILE, mobileNumberController.text.trim());
    await prefs.setString(ApiConstants.USER_MOBILE_NUMBER, mobileNumberController.text.trim());
  }

  Future<void> userRegistration() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
      return;
    }

    String enteredPhoneNumber = mobileNumberController.text.trim();
    DialogHelper.showLoadingDialog(context);
    try {
      var patient = await apiService.verifyPatient(enteredPhoneNumber);
      if (patient != null) {
        if (mounted) {
          Navigator.pop(context); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Mobile number is already in use. Please log in.',
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to verify the mobile number. Please try again.',
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    } finally {
      if (mounted) Navigator.pop(context); // Ensure dialog is closed
    }

    String name = userNameController.text.trim();
    String email = userEmailController.text.trim();
    String phone = mobileNumberController.text.trim();
    String password = userPasswordController.text.trim();

    RegisterRequestData registerRequestData = RegisterRequestData(
      name: name,
      mobile: phone,
      email: email,
      password: password,
    );

    var provider = Provider.of<DataClass>(context,listen: false);
    DialogHelper.showLoadingDialog(context);
    try {
      await provider.postUserRegisterRequest(registerRequestData);
      print("Registration response: ${provider.isBack}");
    } catch (e) {
      print("Error during registration: $e");
    } finally {
      if (mounted) Navigator.pop(context); // Close loading dialog always
    }

    if (provider.isBack) {
      await _incrementCounter();
      if (mounted) {
        if (widget.isFromOTP) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ShareLocationScreen()),
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool(ApiConstants.IS_LOGIN, true);
          FirebaseMessage('Welcome to SAAOL','You have registered successfully.Let’s begin your journey to better heart health!');

        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginOtpScreen(phone: phone)),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              provider.errorMessage ?? 'Registration failed.',
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      if (widget.isFromOTP) {
        bool exitApp = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
            title: const Row(
              children: [
                Icon(Icons.exit_to_app, color:AppColors.primaryColor),
                SizedBox(width: 10),
                Text(
                  'Exit App',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize:14,
                    fontFamily:'FontPoppins',
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            content: const Text(
              'Are you sure you want to exit the app?',
              style: TextStyle(
                fontSize:12,
                color: Colors.black54,
                fontWeight:FontWeight.w500,
                fontFamily:'FontPoppins'
              ),
            ),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  backgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Cancel',style:TextStyle(fontWeight:FontWeight.w500,
                    fontSize:13,fontFamily:'FontPoppins',
                    color:Colors.black),),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Exit',style:TextStyle(fontWeight:FontWeight.w500,
                    fontSize:13,fontFamily:'FontPoppins',
                    color:Colors.white),),
              ),
            ],
          ),
        );
        if (exitApp) {
          if (Platform.isAndroid) {
            SystemNavigator.pop(); // recommended for Android
          } else {
            exit(0); // fallback
          }
        }
        return false; // prevent navigation back
      } else {
        return true; // allow default back behavior
      }
    },child:Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.primaryColor],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'FontPoppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height:5,),
                  Text(
                    'Enter Your Personal Information',
                    style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:150.0),
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
                  padding: const EdgeInsets.only(left:20, right: 20, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        autovalidateMode: autovalidateMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Your Name',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: userNameController,
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                                hintStyle: const TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize:14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                                prefixIcon: const Icon(Icons.contact_page,
                                    color: AppColors.primaryColor),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                filled: true,
                                fillColor: Colors.lightBlue[50],
                              ),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  color: Colors.black),
                              validator: ValidationCons().validateName,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Your Email',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: userEmailController,
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: const TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                                prefixIcon: const Icon(Icons.mail,
                                    color: AppColors.primaryColor),
                                filled: true,
                                fillColor: Colors.lightBlue[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
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
                              validator: ValidationCons().validateEmail,
                            ),

                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Your Mobile Number',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: mobileNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Enter your mobile number',
                                hintStyle: const TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                                prefixIcon: const Icon(Icons.phone,
                                    color: AppColors.primaryColor),
                                filled: true,
                                fillColor: Colors.lightBlue[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                              ),
                              validator: ValidationCons().validateMobile,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Enter Your Password',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: userPasswordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Create your password',
                                hintStyle: const TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                                prefixIcon: const Icon(Icons.lock,
                                    color: AppColors.primaryColor),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.primaryDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                filled: true,
                                fillColor: Colors.lightBlue[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
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
                              validator: ValidationCons().validatePassword,
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                               userRegistration();
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
                            'Sign Up Now',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height:15,
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: this.value,
                            onChanged: (bool? value) {
                              setState(() {
                                this.value = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                                children: [
                                  const TextSpan(text: "By clicking 'Register' you agree to our "),
                                  TextSpan(
                                    text: "Terms & Conditions",
                                    style:  const TextStyle(
                                      color:AppColors.primaryColor,
                                      fontSize:12,
                                      fontFamily:'FontPoppins',
                                      fontWeight:FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final url = Uri.parse("https://saaol.com/terms-conditions");
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url, mode: LaunchMode.externalApplication);
                                        }
                                      },
                                  ),
                                  const TextSpan(text: " as well as our "),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style:  const TextStyle(
                                      color:AppColors.primaryColor,
                                      fontSize:12,
                                      fontFamily:'FontPoppins',
                                      fontWeight:FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final url = Uri.parse("https://saaol.com/privacy-policy");
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url, mode: LaunchMode.externalApplication);
                                        }
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const SignInScreen()),
                              );
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height:30,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
