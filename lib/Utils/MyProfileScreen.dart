import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../AboutDrBimalChhajerScreen.dart';
import '../common/app_colors.dart';
import 'AboutSaaolScreen.dart';
import 'AppointmentBookScreen.dart';
import 'EditProfileScreen.dart';
import 'EmagazineScreen.dart';
import 'FeedbackScreen.dart';
import 'HeartHealthScreen.dart';
import 'NotificationScreen.dart';
import 'OurBlogsScreen.dart';
import 'PatientInstructionScreen.dart';
import 'PaymentHistoryScreen.dart';
import 'PrivacyPoliciesScreen.dart';
import 'SupportAndHelpScreen.dart';
import 'TermConditionScreen.dart';
import 'UserFormAScreen.dart';
import 'WebinarScreen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    color: AppColors.primaryColor,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'My Profile',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 85),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          children: [],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 2.5)),
                            child: const Center(
                              child: Image(
                                image: AssetImage('assets/images/profile.png'),
                                width: 75,
                                height: 75,
                                fit: BoxFit.cover,
                              )

                              /*Text(
                                'MG',
                                style: TextStyle(
                                    fontSize: 25,
                                    letterSpacing: 0.2,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor),
                              )*/
                              ,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Muratib Gour (Self)',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const Text(
                          'mohdmuratib0@gmail.com',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(msg: 'click');
                      },
                      child: const Text(
                        'Manage Profile',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const EditProfileScreen()),
                        );
                        Fluttertoast.showToast(msg: 'click');
                      },
                      child: const Text(
                        'Complete Your Profile',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Your Information',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 2,
                  child: Container(
                    height: 330,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/appointment_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Appointments',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const AppointmentBookScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/payment_history_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Payment History',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const MyPurchase()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/our_blogs_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Our Blogs',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const OurBlogsScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/notification_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Notifications',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const NotificationScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 20,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/our_webinar_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Our Webinar',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const WebinarScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 20,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/pill_reminder_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Pill reminder',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                 /* Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const PillReminderScreen()),
                                  );*/
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
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
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Account',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 2,
                  child: Container(
                    height:280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/heart_rate_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Heart Rate',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                },
                                child:const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/heart_health_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Heart Health',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const HeartHealthScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/magazine_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'SAAOL E-Magzine',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const EmagazineScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/Instructions_patient.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                "Instructions for Patient's",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const PatientInstructionScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/ai-chatbot_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'AI Chatbot',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black,
                                size: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'About',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 2,
                  child: Container(
                    height:450,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/about_us_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'About Us',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const AboutSAAAOLScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),

                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),


                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/About_dr_bimal_chhajer.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'About Dr. Bimal Chhajer',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const AboutDrBimalChhajerScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),

                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/terms_and_condition_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Terms & Conditions',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const TermConditionScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),

                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),

                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/privacy_policy_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Privacy Policy',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const PrivacyPoliciesScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),

                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/feedback_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Provide Feedback',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const FeedbackScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image:
                                    AssetImage('assets/icons/rate_us_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Rate Us',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black,
                                size: 14,
                              ),
                            ],
                          ),
                          const Divider(
                            height: 25,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage('assets/icons/faqs_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Faqs',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const UserFormScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),

                            ],
                          ),
                          const Divider(
                            height: 20,
                            color: Colors.black87,
                            thickness: 0.2,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage(
                                    'assets/icons/support_help_icon.png'),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                'Support & Help',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                        const SupportAndHelpScreen()),
                                  );
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                  size: 14,
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
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 42,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showLogoutPopup(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    icon: const Icon(
                      Icons.logout,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Logout',
                      style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/icons/logout.png',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
          actions: <Widget>[
            SizedBox(
              height: 35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              height: 35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                onPressed: () {
                  // Perform logout action here
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        );
      },
    );
  }
}
