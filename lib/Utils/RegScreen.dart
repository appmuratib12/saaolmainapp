import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/constant/ApiConstants.dart';
import 'package:saaoldemo/data/model/requestmodel/RegisterRequestData.dart';
import '../common/app_colors.dart';
import '../constant/ValidationCons.dart';
import '../data/network/ApiService.dart';
import '../data/network/ChangeNotifier.dart';
import 'LocationScreen.dart';
import 'LoginOtpScreen.dart';
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
    _showLoadingDialog(); // Display loading indicator
    try {
      var patient = await apiService.verifyPatient(enteredPhoneNumber);
      if (patient != null) {
        if (mounted) {
          Navigator.pop(context); // Close the loading dialog
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
        Navigator.pop(context); // Close the loading dialog
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
    }


    String name = userNameController.text.trim();
    //mobileNumberController.text = widget.phoneNumber;
    String email = userEmailController.text.trim();
    String phone = mobileNumberController.text.trim();
    String password = userPasswordController.text.trim();

    RegisterRequestData registerRequestData = RegisterRequestData(
      name: name,
      mobile:phone,
      email: email,
      password: password,
    );


    var provider = Provider.of<DataClass>(context, listen: false);
    _showLoadingDialog();
    try {
      await provider.postUserRegisterRequest(registerRequestData);
      print("Registration response: ${provider.isBack}");
    } catch (e) {
      print("Error during registration: $e");
    } finally {
      if (mounted) Navigator.pop(context);
    }
    if (provider.isBack) {
      await _incrementCounter();
      // Save the registered phone number locally
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //await prefs.setString('registered_phone',widget.phoneNumber);


      if (mounted) {
        if (widget.isFromOTP) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ShareLocationScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginOtpScreen(phone:phone)),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
  Widget build(BuildContext context) {
   //mobileNumberController.text = widget.phoneNumber;
    return Scaffold(
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
                    'Create an account*',
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'FontPoppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Enter Your Personal Information!',
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
                              keyboardType: TextInputType.name,
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
                              keyboardType: TextInputType.emailAddress,
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
                              'Mobile Number',
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                                prefixIcon: const Icon(Icons.phone,
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
                                hintText: 'Create your password',
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
                      const SizedBox(height:30,),
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
