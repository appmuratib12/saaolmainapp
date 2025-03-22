import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class ValidationCons {

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your name!';
    }
    if (value.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password!';
    }
    if (value.length < 6) {
      return 'Password must be longer than 6 characters.\n';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return '• Uppercase letter is missing.\n';
    }
    return null;
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Please enter your email id!';
    }
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number!';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    return null;
  }


  void callDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor:Colors.white,
          content:Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You will receive a call back from Health Advisor.Do you want to proceed?',
                    style:TextStyle(fontFamily:'FontPoppins',
                        fontWeight:FontWeight.w500,
                        fontSize:12,color:AppColors.primaryColor)),
                const SizedBox(height:15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height:35,
                      width:90,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:Colors.blue[50],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(6))),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color:AppColors.primaryDark),
                        ),
                      ),
                    ),
                    const SizedBox(width:20,),
                    SizedBox(
                      height:35,
                      width:90,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(6))),
                        ),
                        onPressed: () {
                          requestDialog(context);

                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void requestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Thank you for submitting request',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Our Health Advisors will contact you INSTANTLY!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                bottom: -35, // Places the icon outside the dialog
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.phone_in_talk,
                    color: AppColors.primaryDark,
                    size: 30,
                  ),
                ),
              ),
              Positioned(
                top: 5, // Adjust the position of the close icon
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    // Dismiss both the request dialog and the call dialog
                    Navigator.of(context).pop(); // Dismiss requestDialog
                    Navigator.of(context).pop(); // Dismiss callDialog
                  },
                  child: const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
