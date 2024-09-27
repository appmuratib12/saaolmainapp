import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../common/app_colors.dart';
import '../constant/GoogleSignInService.dart';
import 'ForgetPasswordScreen.dart';
import 'OtpScreen.dart';
import 'RegScreen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool value = false;
  bool checkedValue = true;

  TextEditingController userMobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GoogleSignInService _googleSignInService = GoogleSignInService();

  String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
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
                      child: IntlPhoneField(
                        flagsButtonPadding: const EdgeInsets.all(8),
                        dropdownIconPosition: IconPosition.trailing,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: const TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 16,
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
                          if (phone == null || phone.completeNumber.isEmpty) {
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
                      'You will receive an SMS to verify your identity,but will never spam.',
                      style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const OtpPhoneWidget()),
                          );
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
                                            const RegScreen()),
                                  );
                                  Fluttertoast.showToast(msg: 'Hi');
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
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
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
                            final googleUser =
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
                            }
                            Fluttertoast.showToast(msg: 'Click');
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
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /*Row(mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children: [
                        CustomSocialButton(
                          onTap: () {
                            Fluttertoast.showToast(msg: 'Click');
                          },
                          icon: AppAssets.kGoogle,
                        ),
                        CustomSocialButton(
                          onTap: () {},
                          icon: AppAssets.kGoogle,
                        ),
                        CustomSocialButton(
                          onTap: () {},
                          icon: AppAssets.kFacebook,
                        ),
                      ],
                    ),*/
                    const SizedBox(height: 20),
                    const AgreeTermsTextCard(),
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

class CustomSocialButton extends StatefulWidget {
  final String icon;
  final VoidCallback onTap;

  const CustomSocialButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  State<CustomSocialButton> createState() => _CustomSocialButtonState();
}

class _CustomSocialButtonState extends State<CustomSocialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Container(
          height: 48,
          width: 72,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFF6F6F6),
            image: DecorationImage(image: AssetImage(widget.icon)),
          ),
        ),
      ),
    );
  }
}

class AgreeTermsTextCard extends StatelessWidget {
  const AgreeTermsTextCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: RichText(
        text: TextSpan(
          text: 'By signing up you agree to our ',
          style: const TextStyle(
              fontSize: 14,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w400,
              color: Colors.black87),
          children: [
            TextSpan(
                text: 'Terms',
                recognizer: TapGestureRecognizer()..onTap = () {},
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor)),
            const TextSpan(
                text: ' and ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87)),
            TextSpan(
                text: 'Conditions of Use',
                recognizer: TapGestureRecognizer()..onTap = () {},
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor)),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
