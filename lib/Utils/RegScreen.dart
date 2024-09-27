import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_colors.dart';
import 'SignInScreen.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    userPasswordController.dispose();
    userConfirmPasswordController.dispose();
    super.dispose();
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name cannot be empty';
    }
    if (value.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be longer than 6 characters.\n';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return '• Uppercase letter is missing.\n';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != userPasswordController.text) {
      return 'Passwords do not match';
    }
    if (value.length < 6) {
      return 'Password must be longer than 6 characters.\n';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return '• Uppercase letter is missing.\n';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Show custom progress bar
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
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('userName', userNameController.text.toString());
      prefs.setString('userEmailID',userEmailController.text.toString());
      prefs.setString('userPassword', userPasswordController.text.toString());
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
                  'Create an account*',
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'FontPoppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Enter Your Personal Information!',
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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
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
                            'Username',
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
                            controller: userNameController,
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
                              hintStyle: const TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                              prefixIcon: const Icon(Icons.contact_page,
                                  color: AppColors.primaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                              filled: true,
                              fillColor: Colors.lightBlue[50],
                            ),
                            validator: validateName,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Email',
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
                            controller: userEmailController,
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle: const TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                              prefixIcon: const Icon(Icons.mail,
                                  color: AppColors.primaryColor),
                              filled: true,
                              fillColor: Colors.lightBlue[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                            ),
                            validator: validateEmail,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Password',
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
                              hintText: 'Enter password',
                              hintStyle: const TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                              prefixIcon: const Icon(Icons.lock,
                                  color: AppColors.primaryColor),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.blue,
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
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                            ),
                            validator: _validatePassword,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Confirm password',
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
                            controller: userConfirmPasswordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: 'Enter confirm password',
                              hintStyle: const TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                              prefixIcon: const Icon(Icons.lock,
                                  color: AppColors.primaryColor),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.blue,
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
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                            ),
                            validator: _validateConfirmPassword,
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
                            _submitForm();
                            _incrementCounter();
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
                          'Register',
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
                    Row(
                      children: [
                        Checkbox(
                          value: this.value,
                          onChanged: (bool? value) {
                            setState(() {
                              this.value = value!;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            "By clicking 'Register' you agree to our Terms & Conditions as well as our Privacy Policy",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        )
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
                            " Sign In",
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
