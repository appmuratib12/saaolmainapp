import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/Utils/HeartRateScreen.dart';
import 'package:saaoldemo/Utils/MedicineReminderDetailScreen.dart';
import 'package:saaoldemo/Utils/SignInScreen.dart';
import 'package:saaoldemo/constant/ApiConstants.dart';
import '../AboutDrBimalChhajerScreen.dart';
import '../common/app_colors.dart';
import 'AboutSaaolScreen.dart';
import 'AppointmentBookScreen.dart';
import 'DemoScreen.dart';
import 'EditProfileScreen.dart';
import 'EmagazineScreen.dart';
import 'FeedbackScreen.dart';
import 'HeartHealthScreen.dart';
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

  String userName = '';
  String userEmail = '';
  String patientLastName = '';
  String patientMiddleName = '';
  late SharedPreferences sharedPreferences;
  String getPatientID = '';
  String userToken = '';
  String googleUserID = '';
  String googlePatientName = '';
  String googlePatientEmail = '';
  bool _showVerifyButton = false;

  void _loadUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? loginMethod = sharedPreferences.getString('login_method');
    setState(() {
      _showVerifyButton = (loginMethod == 'google');
      getPatientID = sharedPreferences.getString('pmId') ?? '';
      googleUserID = sharedPreferences.getString('GoogleUserID') ?? '';
      googlePatientName = sharedPreferences.getString('GoogleUserName') ?? '';
      googlePatientEmail = sharedPreferences.getString('GoogleUserEmail') ?? '';
      print('GoogleID:$googleUserID');

      if (getPatientID.isNotEmpty) {
        userName = (sharedPreferences.getString('PatientFirstName') ?? '');
        userEmail = (sharedPreferences.getString('patientEmail') ?? '');
        patientLastName = (sharedPreferences.getString('PatientLastName') ?? '');
        patientMiddleName = (sharedPreferences.getString('PatientMiddleName') ?? '');
      } else {
        userName = (sharedPreferences.getString(ApiConstants.USER_NAME) ?? '');
        userEmail = (sharedPreferences.getString(ApiConstants.USER_EMAIL) ?? '');
        patientLastName = (sharedPreferences.getString(ApiConstants.USER_LASTNAME) ?? '');
        patientMiddleName = (sharedPreferences.getString(ApiConstants.USER_MIDDLE_NAME) ?? '');
        userToken = (sharedPreferences.getString('UserToken') ?? '');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _logoutUser(BuildContext context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
          (Route<dynamic> route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Background Container
                Container(
                  height: 170,
                  padding: const EdgeInsets.only(top: 45, left: 10, right: 10),
                  width: double.infinity,
                  color: AppColors.primaryColor,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'My Profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Profile Card
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 110),
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
                    ),
                  ),
                ),

                // Profile Image & Edit Icon
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 75),
                      Stack(
                        children: [
                          // Profile Image
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2.5,
                              ),
                            ),
                            child: const Center(
                              child: Image(
                                image: AssetImage('assets/images/profile.png'),
                                width: 75,
                                height: 75,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // User Info
                      if (getPatientID.isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userName.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              patientMiddleName.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              patientLastName.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          userEmail.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ] else if (googleUserID.isNotEmpty) ...[
                        Text(
                          googlePatientName.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          googlePatientEmail.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ] else ...[
                        Text(
                          userName.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          userEmail.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Edit Icon Positioned in Top Right Corner
                Positioned(
                  top: 120, // Adjust the position to match the profile card's top
                  right: 25, // Position it properly inside the card
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 1),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.black87,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),


            const SizedBox(
              height: 20,
            ),
            Center(
              child: (googleUserID.isNotEmpty && getPatientID.isEmpty)
                  ? Padding(padding: EdgeInsets.all(13),child:SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      side: BorderSide(
                        color: Colors.grey,
                        width: 0.1,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DemoScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Verify Patient',
                    style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),)
                  : const SizedBox.shrink(), // Placeholder if button should not be visible
            ),

           /* Row(
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
            ),*/
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

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const AppointmentBookScreen(),
                              ),
                            );
                          },
                          child: const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage('assets/icons/appointment_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      'Appointments',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),
                            ],
                          ),
                        ),


                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const MyPurchase()),
                            );
                          },
                          child:  const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/payment_history_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child: Text(
                                    'Payment History',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  )),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  )
                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),

                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const OurBlogsScreen()),
                            );
                          },
                          child:   const Column(
                            children: [

                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/our_blogs_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child:Text(
                                    'Our Blogs',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  )
                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            /*Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const NotificationScreen()),
                            );*/
                          },
                          child:const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/notification_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),

                                  Expanded(child:   Text(
                                    'Notifications',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  )),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  )
                                ],
                              ),
                              Divider(
                                height: 20,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),

                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const WebinarScreen()),
                            );
                          },
                          child:const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/our_webinar_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child:Text(
                                    'Our Webinar',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  )
                                ],
                              ),
                              Divider(
                                height: 20,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),


                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const MedicineReminderDetailScreen()),
                            );
                          },
                          child: const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/pill_reminder_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child: Text(
                                    'Pill reminder',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  )
                                ],
                              ),
                            ],
                          ),
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

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const HeartRateScreen(),
                              ),
                            );
                          },
                          child:const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/heart_rate_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child: Text(
                                    'Heart Rate',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  )

                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),

                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const HeartHealthScreen()),
                            );
                          },
                          child:const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/heart_health_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child:  Text(
                                    'Heart Health',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  )
                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const EmagazineScreen()),
                            );
                          },
                          child:const Column(
                            children: [

                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/magazine_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child:Text(
                                    'SAAOL E-Magzine',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),

                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const PatientInstructionScreen()),
                            );
                          },
                          child:const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/Instructions_patient.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child:Text(
                                    "Instructions for Patient's",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,),

                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),


                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {

                          },
                          child:const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/ai-chatbot_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child:  Text(
                                    'AI Chatbot',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
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

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const AboutSAAAOLScreen()),
                            );
                          },
                          child:const Column(
                            children: [

                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/about_us_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child:  Text(
                                    'About Us',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),


                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const AboutDrBimalChhajerScreen()),
                            );
                          },
                          child: const Column(
                            children: [

                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/About_dr_bimal_chhajer.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child: Text(
                                    'About Dr. Bimal Chhajer',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  )

                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),


                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const TermConditionScreen()),
                            );
                          },
                          child: const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/terms_and_condition_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child: Text(
                                    'Terms & Conditions',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  ),

                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),

                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const PrivacyPoliciesScreen()),
                            );
                          },
                          child: const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/privacy_policy_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child:Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),

                            ],
                          ),
                        ),


                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const FeedbackScreen()),
                            );
                          },
                          child: Column(
                            children: [

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

                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {

                          },
                          child: const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image:
                                    AssetImage('assets/icons/rate_us_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child: Text(
                                    'Rate Us',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 25,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),


                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const UserFormScreen()),
                            );
                          },
                          child:  const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage('assets/icons/faqs_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child:Text(
                                    'Faqs',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  )
                                ],
                              ),
                              Divider(
                                height: 20,
                                color: Colors.black87,
                                thickness: 0.2,
                              ),

                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                  const SupportAndHelpScreen()),
                            );
                          },
                          child:  const Column(
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/icons/support_help_icon.png'),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(child:Text(
                                    'Support & Help',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                onPressed: () async {
                  await _logoutUser(context);
                },
              ),
            )
          ],
        );
      },
    );
  }
}
