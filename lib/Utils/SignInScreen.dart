import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:saaolapp/data/network/ChangeNotifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../DialogHelper.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../data/network/ApiService.dart';
import 'LocationScreen.dart';
import 'NotificationScreen.dart';
import 'OTPVerifyScreen.dart';
import 'RegScreen.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends   State<SignInScreen> {
  bool value = false;
  bool checkedValue = true;
  String mobileNumber = '';
  String storeKey = '';
  String googleID = '';
  String? selectedCountryCode;
  final String dummyImageUrl = "https://via.placeholder.com/150";


  TextEditingController userMobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
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
      DialogHelper.showLoadingDialog(context);
      try {

        final otpResponse = await _apiService.sendOTP(phoneNumber, storeKey);
        Navigator.pop(context);
        if (otpResponse != null && otpResponse.status == "success") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('login_method', 'otp'); // Save login method
          await prefs.setString(ApiConstants.SINGIN_MOBILENUMBER,userMobileController.text); // Save login method
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => OTPPage(phoneNumber: phoneNumber)),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP sent successfully.'),
              backgroundColor: Colors.green,
            ),);
          print('OTP SUCCESS:${otpResponse.status}');

          if (selectedCountryCode != null) {
            await prefs.setString('SelectedCountryCode', selectedCountryCode!);
            print('StoreselectedCountryCode:$selectedCountryCode');
          }

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
  Future<void> checkForUpdates() async {
    try {
      final AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      }
    } catch (e) {
      print('Error checking for updates: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    checkForUpdates();
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Google Sign-In cancelled.");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        _user = googleUser;
        await _saveUserData(firebaseUser);
        final provider = Provider.of<DataClass>(context, listen: false);
        await provider.sendGoogleUserData(
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          googleId: firebaseUser.uid,
          token: googleAuth.accessToken.toString(),
          image: firebaseUser.photoURL ?? '',
        );

        final response = provider.googleUserResponse;
        final response1 = provider.googleExistingUserResponse;
        if (response != null && response.message != null && response.status == 'success') {
          ScaffoldMessenger.of(context).
          showSnackBar(
            SnackBar(
              content: Text(response.message.toString(),
                  style:const TextStyle(fontWeight:FontWeight.w500,fontSize:15,color:Colors.white)),
              backgroundColor: Colors.green,
            ),
          );
        }else if (response1 != null && response1.message != null && response1.status == 'success'){
          ScaffoldMessenger.of(context).
          showSnackBar(
            SnackBar(
              content: Text(response1.message.toString(),
                  style:const TextStyle(fontWeight:FontWeight.w500,fontSize:15,color:Colors.white)),
              backgroundColor: Colors.green,
            ),
          );
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool(ApiConstants.IS_LOGIN, true);
        FirebaseMessage("Welcome to SAAOL - Science and Art of Living!","Let's start your Health journey.");
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => const ShareLocationScreen(),
          ),
        );
      }
    } catch (error) {
      print('Sign-In Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Google Sign-In failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Future<void> _saveUserData(User firebaseUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('login_method', 'google');
    await prefs.setString('GoogleUserName', firebaseUser.displayName ?? '');
    await prefs.setString('GoogleUserEmail', firebaseUser.email ?? '');
    await prefs.setString('GoogleUserID', firebaseUser.uid);
    await prefs.setString('GoogleUserProfile', firebaseUser.photoURL ?? '');
  }

  Future<void> _signInWithApple() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      await prefs.setString(ApiConstants.APPLE_LOGIN_METHOD,'apple');
      await prefs.setString(ApiConstants.APPLE_NAME,credential.givenName?? '');
      await prefs.setString(ApiConstants.APPLE_EMAIL,credential.email?? '');
      await prefs.setString(ApiConstants.APPLE_IDENTIFIER_TOKEN,credential.identityToken?? '');
      await prefs.setString(ApiConstants.IDENTIFIER_TOKEN,credential.userIdentifier?? '');

      print('User ID: ${credential.userIdentifier}');
      print('Email: ${credential.email}');
      print('Full Name: ${credential.givenName} ${credential.familyName}');

      final provider = Provider.of<DataClass>(context, listen: false);
      await provider.sendGoogleUserData(
        name: credential.givenName ?? ''.trim(),
        email: credential.email ?? '',
        googleId: credential.userIdentifier ?? '',
        token: credential.identityToken ?? '',
        image: dummyImageUrl,
      );

      final response = provider.googleUserResponse;
      final response1 = provider.googleExistingUserResponse;
      if (response != null && response.message != null && response.status == 'success') {
        ScaffoldMessenger.of(context).
        showSnackBar(SnackBar(
            content: Text(response.message.toString(),
                style:const TextStyle(fontWeight:FontWeight.w500,fontSize:15,color:Colors.white)),
            backgroundColor: Colors.green,
          ),);
      }else if (response1 != null && response1.message != null && response1.status == 'success'){
        ScaffoldMessenger.of(context).
        showSnackBar(SnackBar(
            content: Text(response1.message.toString(),
                style:const TextStyle(fontWeight:FontWeight.w500,fontSize:15,color:Colors.white)),
            backgroundColor: Colors.green,
          ));
      }
      await prefs.setBool(ApiConstants.IS_LOGIN, true);
      FirebaseMessage("Welcome to SAAOL - Science and Art of Living!","Let's start your Health journey.");
      Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => const ShareLocationScreen(),
        ),
      );
    } catch (e) {
      print('Error during Apple Sign-In: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Apple Sign-In failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                    'Sign In',
                    style: TextStyle(
                        fontSize:20,
                        fontFamily: 'FontPoppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Enter your mobile number to get started',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 13,
                        letterSpacing:0.2,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Mobile Number',
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: _formKey,
                        autovalidateMode: autovalidateMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntlPhoneField(
                              controller: userMobileController,
                              keyboardType: TextInputType.phone,
                              flagsButtonPadding: const EdgeInsets.all(8),
                              dropdownIconPosition: IconPosition.trailing,
                              decoration: InputDecoration(
                                hintText: 'Enter Mobile Number',
                                hintStyle: const TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal:15.0),
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'FontPoppins',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              validator: (phone) {
                                if (phone == null || phone.completeNumber.isEmpty) {
                                  return 'Phone number is required';
                                }
                                if (!RegExp(r'^\+?[1-9]\d{1,14}$')
                                    .hasMatch(phone.completeNumber)) {
                                  return 'Invalid phone number format';
                                }
                                return null;
                              },
                              initialCountryCode: 'IN',
                              onChanged: (phone) {
                                print(phone.completeNumber);
                                selectedCountryCode = phone.countryCode;
                                print('selectedCountryCode:$selectedCountryCode');
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
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
                              side: const BorderSide(color: Colors.white, width: 0.1),
                            ),
                          ),
                          child: const Text(
                            'Get verification code',
                            style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height:15),
                      const Text(
                        'You will receive an SMS to verify your identity,but we will never spam you.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height:20),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Don’t have an account? ',
                            style: const TextStyle(
                              fontSize:15,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                        const RegScreen(isFromOTP: false),
                                      ),
                                    );
                                    Fluttertoast.showToast(msg: 'Hi');
                                  },
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey)),
                          SizedBox(width: 20),
                          Text(
                            'Or Sign In with',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(child: Divider(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              _handleSignIn();
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
                                ),
                              ),
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
                        ],
                      ),
                      const SizedBox(height: 30),
                      if (Platform.isIOS)
                        GestureDetector(
                          onTap: () => _signInWithApple(),
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color:AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow:const [
                                BoxShadow(
                                  color:AppColors.primaryColor,
                                  offset: Offset(0, 4),
                                  blurRadius:6,
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.apple, color: Colors.white, size: 24),
                                SizedBox(width: 10),
                                Text(
                                  'Sign in with Apple',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily:'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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
      bottomNavigationBar: Container(
        color:Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                    "Designed by",
                    style: TextStyle(fontWeight:FontWeight.w400,
                        fontSize:12,fontFamily:'FontPoppins')
                ),
              ),
              Image.network(
                "https://saaolinfotech.com/assets/images/new/SAOOL-Infotech.png",
                width: MediaQuery.of(context).size.width * 0.18,
                height: MediaQuery.of(context).size.height * 0.05,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
