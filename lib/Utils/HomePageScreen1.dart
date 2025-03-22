import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/Utils/ManuallyLocationScreen.dart';
import 'package:saaoldemo/Utils/NavBarScreens/DetoxScreen.dart';
import 'package:saaoldemo/Utils/NavBarScreens/LifeStylePageScreen.dart';
import 'package:saaoldemo/Utils/NavBarScreens/TreatmentsOverviewScreen.dart';
import 'package:saaoldemo/Utils/NavBarScreens/ZeroOilPageScreen.dart';
import 'package:saaoldemo/constant/ValidationCons.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/DiseaseResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/TreatmentsResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/WellnessCenterResponse.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/AppointmentBookScreen.dart';
import '../Utils/AppointmentsScreen.dart';
import '../Utils/BlogDetailPageScreen.dart';
import '../Utils/DietPlanScreen.dart';
import '../Utils/DiseaseDetailScreen.dart';
import '../Utils/EditProfileScreen.dart';
import '../Utils/HeartRateScreen.dart';
import '../Utils/LabTestScreen.dart';
import '../Utils/MaintainVitalScreen.dart';
import '../Utils/NearByCenterScreen.dart';
import '../Utils/NotificationScreen.dart';
import '../Utils/OurBlogsScreen.dart';
import '../Utils/SearchBarScreem.dart';
import '../Utils/StatesData.dart';
import '../Utils/StepCounterScreen.dart';
import '../Utils/TreatmentDetailsPageScreen.dart';
import '../Utils/UploadPrescriptionScreen.dart';
import '../Utils/WellnessCenterScreen.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../constant/text_strings.dart';
import '../data/model/apiresponsemodel/BlogsResponseData.dart';
import '../data/network/ApiService.dart';
import '../data/network/BaseApiService.dart';

class HomPageScreen1 extends StatefulWidget {
  const HomPageScreen1({super.key});

  @override
  State<HomPageScreen1> createState() => _HomPageScreen1State();
}

class _HomPageScreen1State extends State<HomPageScreen1> {
  final PageController _pageController = PageController();
  final PageController pageController = PageController();
  int selectedIndex1 = -1;
  int selectedIndex = 0;
  int _currentPage = 0;
  int currentPage = 0;
  Timer? _timer;
  Timer? timer1;
  List<String> images = [
    'assets/icons/webinar_banner.png',
    'assets/icons/Zero_oil.png',
    'assets/icons/Ortho.png',
  ];
  List<String> slider2Images = [
    'assets/images/heartImage.png',
    'assets/images/heartImage.png',
    'assets/images/medicine_image.jpg',
    'assets/images/surgeon_Image.jpg',
  ];
  List<String> treatmentsArray = [
    'SAAOL Natural Bypass',
    'SAAOL Detox',
    'Life Style',
    'Zero oil cooking',
  ];
  List<String> vitalsArray = [
    'Heart Rate (Pulse)',
    'Blood Pressure',
    'Cholesterol Levels',
    'Respiratory Rate',
  ];

  final List<String> vitalImagesArray = [
    'assets/images/heart_rate_latest1.jpg',
    'assets/images/blood_pressure_latest.jpg',
    'assets/images/Cholesterol_level_latest.jpg',
    'assets/images/Respiratory_Rate_image.jpg',
  ];

  List<String> toolsArray = ['Steps Counter', 'Heart Rate', 'Know Your Food'];
  final List<String> toolImages = [
    'assets/icons/step_counter_tool.png',
    'assets/icons/heart_rate_latest.png',
    'assets/icons/know_your_food2.png'
  ];


  final List<String> items = List<String>.generate(10, (i) => "Item $i");


  String saveDate = '';
  String saveTime = '';
  String getCity = '';
  String getPinCode = '';
  String? locationName;
  String? locationPinCode;
  bool isAppointmentAvailable = false;
  String getPatientID = '';
  String userName = '';
  String googleUserID = '';
  String googlePatientName = '';
  String googlePatientEmail = '';
  String patientUniqueID = '';
  String getTcmID = '';
  String? getMobileNumber;
  String? getEmailID;
  String?getUserID ;

  @override
  void initState() {
    super.initState();
    _loadSavedAppointment();
  }

  @override
  void dispose() {
    _timer?.cancel();
    timer1?.cancel();
    _pageController.dispose();
    pageController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedAppointment() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      getPatientID = prefs.getString('pmId') ?? '';
      googleUserID = prefs.getString('GoogleUserID') ?? '';
      googlePatientName = prefs.getString('GoogleUserName') ?? '';
      googlePatientEmail = prefs.getString('GoogleUserEmail') ?? '';
      patientUniqueID = prefs.getString('patientUniqueID') ?? '';
      getMobileNumber = prefs.getString(ApiConstants.USER_MOBILE) ?? '';
      getEmailID = prefs.getString(ApiConstants.USER_EMAIL) ?? '';
      getUserID = prefs.getString(ApiConstants.USER_ID) ?? '';
      getTcmID = prefs.getString('tcmID') ?? '';


      if (getPatientID.isNotEmpty) {
        userName = (prefs.getString('PatientFirstName') ?? '');
        getCity = prefs.getString('cityName') ?? prefs.getString('locationName') ?? 'Select City';
        getPinCode = prefs.getString('pinCode') ?? prefs.getString(ApiConstants.PINCODE) ?? '';
        saveDate = prefs.getString('appointmentDate') ?? '';
        saveTime = prefs.getString('appointmentTime') ?? '';
        print('saveDate: $saveDate');
        print('saveTime: $saveTime');


      } else {
        userName = (prefs.getString(ApiConstants.USER_NAME) ?? '');
        saveDate = prefs.getString('appointmentDate') ?? '';
        saveTime = prefs.getString('appointmentTime') ?? '';
        /*getCity = prefs.getString('cityName') ?? '';
         getPinCode = prefs.getString('pinCode') ?? '';
        locationName = prefs.getString('locationName') ?? '';
        locationPinCode = prefs.getString(ApiConstants.PINCODE) ?? '';*/
        getCity = prefs.getString('cityName') ?? prefs.getString('locationName') ?? 'Select City';
        getPinCode = prefs.getString('pinCode') ?? prefs.getString(ApiConstants.PINCODE) ?? '';
        print('PINCODE:$getPinCode');
        print('saveDate: $saveDate');
        print('saveTime: $saveTime');
        print('isAppointmentAvailable: $isAppointmentAvailable');
      }
    });
  }


  _makingPhoneCall() async {
    var url = Uri.parse("tel:8447776000");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String message = "Welcome to the SAAol...";
  String mobileNumber ='';


  launchWhatsappWithMobileNumber() async {
    final url = "whatsapp://send?phone=$mobileNumber&text=$message";
    if (await canLaunchUrl(Uri.parse(Uri.encodeFull(url)))) {
      await launchUrl(Uri.parse(Uri.encodeFull(url)));
    } else {
      throw 'Could not launch $url';
    }
  }



  List<String> packagesImages = [
    'https://media.istockphoto.com/id/1453121684/photo/modern-hotel-room-with-double-bed-night-tables-and-day-sofa-bed.webp?b=1&s=170667a&w=0&k=20&c=0MGlloRKwQjR_xeIt0s0IklHyt2bQHDNoFvKml3BQPc=',
    'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630'
  ];



  final List<Map<String, String>> videosArray = [
    {
      'videoId': 'VILLXKBM2WQ',
      'category': 'By Dr. Bimal Chhajer | Saaol',
      'likes': '10k Likes',
      'title': 'Treat Heart Disease without Surgery - EECP Treatment'
    },
    {
      'videoId': 'de0Z5OXgIGE',
      'category': 'By Dr. Bimal Chhajer | Saaol',
      'likes': '28k Likes',
      'title': 'Foods to Reduce Heart Blockages'
    },
  ];

  final TextEditingController _searchController = TextEditingController(); // Search Controller for input


  Future<void> handleUrlOpening(String tcmID, String getPatientID, String patientUniqueID) async {
    String encodedTcmID = base64Encode(utf8.encode(tcmID));
    String encodedGetPatientID = base64Encode(utf8.encode(getPatientID));
    String encodedPatientUniqueID = base64Encode(utf8.encode(patientUniqueID));
    String url = 'https://crm.saaol.com/haps_score.php?pdf_id=$encodedTcmID&p_id=$encodedGetPatientID&pu_id=$encodedPatientUniqueID&app_id=5DCAD06B90925BE3D750837F392A8FC6';

    if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,  // Opens in the default browser
    );
    } else {
    throw 'Could not launch $url';
    }
  }

  Future<void> handleSafetyCircle(String tcmID, String getPatientID, String patientUniqueID) async {
    String encodedTcmID = base64Encode(utf8.encode(tcmID));
    print('encodedTCMID:$encodedTcmID');
    String encodedGetPatientID = base64Encode(utf8.encode(getPatientID));
    String encodedPatientUniqueID = base64Encode(utf8.encode(patientUniqueID));
    String url = 'https://crm.saaol.com/safety_circle_page.php?pdf_id=$encodedTcmID&p_id=$encodedGetPatientID&pu_id=$encodedPatientUniqueID&app_id=5DCAD06B90925BE3D750837F392A8FC6';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,  // Opens in the default browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }


  void _showAgentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColors.primaryColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/call_center.png',
                      fit: BoxFit.cover,
                      width: 45,
                      height: 45,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Need help?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  _launchURLApp();
                },
                icon: const Icon(
                  Icons.call,
                  color: Colors.black,
                ),
                label: const Text(
                  "WhatsApp",
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  _makingPhoneCall();
                },
                icon: const Icon(
                  Icons.call,
                  color: Colors.black87,
                ),
                label: const Text(
                  "Call",
                  style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  String selectedCategory = 'Heart';
  final ApiService _apiService = ApiService(); // Create an instance of ApiService
  void _sendRequest() async {
    bool success = await _apiService.sendCallRequest(
      userId:int.tryParse(getUserID!) ?? 0,
      mobileNumber:getMobileNumber.toString(),
      emailId: getEmailID.toString()
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? "Request sent successfully!" : "Failed to send request."),
      ),
    );
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
                          _sendRequest();
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primaryColor,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Image(
                          image: AssetImage('assets/images/saool_logo.png'),
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (getPatientID.isNotEmpty) ...[
                                Text('Hi, $userName',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'FontPoppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ]
                              else if(googleUserID.isNotEmpty)...[
                                Text('Hello, $googlePatientName',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'FontPoppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ]
                              else ...[
                                  Text('Hi, $userName',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'FontPoppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const SearchBarScreen()),
                                  ).then((_) {
                                    _loadSavedAppointment();
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      '$getCity,$getPinCode',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'FontPoppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    const Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 18,
                                      color: Colors
                                          .white, // Changed color to match the text
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              iconSize: 25,
                              icon: const Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                              ),
                              onPressed: () {
                               /* Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const NotificationScreen(),
                                  ),
                                );*/
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              iconSize: 25,
                              icon: const Icon(
                                Icons.account_circle_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen(),
                                  ),
                                );
                                /* Navigator.push(
                              context,
                              CupertinoPageRoute(
                            builder: (context) => const MyProfileScreen()),
                        );*/
                              },
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: SearchScreen(
                          searchController:
                              _searchController, // Pass the searchController to the SearchScreen
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 45.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.primaryColor.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Icon(
                              Icons.search,
                              color: AppColors.primaryColor,
                              size: 25,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Find our nearest centers...',
                              style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        buildClickableServiceCard(
                          'assets/images/online_appointment.jpg',
                          'Online Book Consultation',
                              () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const MyAppointmentsScreen()),
                            );
                          },
                        ),
                        buildClickableServiceCard(
                          'assets/images/offline_appointment.jpg',
                          'Offline Book Consultation',
                              () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const MyAppointmentsScreen()),
                            );
                          },
                        ),
                        buildClickableServiceCard(
                          'assets/images/lab_test.jpg',
                          'Test Lab Booking',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LabTestScreen()),
                            );
                          },
                        ),
                        buildClickableServiceCard(
                          'assets/images/nearby_center.jpg',
                          'Nearest Centers',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NearByCenterScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const MyAppointmentsScreen()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const Image(
                        image: AssetImage('assets/images/bannner_image1.png'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Our Treatments',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Expanded(child: Container()),
                      const Text(
                        'View All',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height:150,
                    child: FutureBuilder<TreatmentsResponseData>(
                      future: BaseApiService().getTreatmentsData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                          return const Center(child: Text('No Data available.'));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  String id = snapshot.data!.data![index].id.toString();

                                  if (id == '14') {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(CupertinoPageRoute(
                                      builder: (context) => ZeroOilPageScreen(
                                          id: snapshot.data!.data![index].id
                                              .toString()),
                                    ));
                                  } else if (id == '15') {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(CupertinoPageRoute(
                                      builder: (context) => DetoxScreen(
                                          id: snapshot.data!.data![index].id
                                              .toString()),
                                    ));
                                  } else if (id == '16') {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(CupertinoPageRoute(
                                      builder: (context) =>
                                          TreatmentDetailsPageScreen(
                                              id: snapshot.data!.data![index].id
                                                  .toString()),
                                    ));
                                  } else if (id == '13') {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(CupertinoPageRoute(
                                      builder: (context) => LifeStylePageScreen(
                                          id: snapshot.data!.data![index].id
                                              .toString()),
                                    ));
                                  } else if (id == '17') {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(CupertinoPageRoute(
                                      builder: (context) =>
                                          TreatmentsOverviewScreen(
                                              id: snapshot.data!.data![index].id
                                                  .toString()),
                                    ));
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 7),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 105,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7),
                                          borderRadius: BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot.data!.data![index].image.toString()),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: 50,
                                                // Adjust the height as needed
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black.withOpacity(1),
                                                    ],
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.vertical(
                                                    bottom: Radius.circular(8.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0, vertical: 4.0),
                                                child: Text(snapshot.data!.data![index].title.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'FontPoppins',
                                                    fontSize: 13,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines:
                                                  2, // Limit the text to 2 lines
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Divider(
                    height: 40,
                    thickness: 5,
                    color: Colors.lightBlue[50],
                  ),
                  const Text(
                    'Diseases We treat',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  FutureBuilder<DiseaseResponseData>(
                    future: BaseApiService().getDiseaseData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics:const NeverScrollableScrollPhysics(),
                          clipBehavior: Clip.hardEdge,
                          padding: const EdgeInsets.all(16.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing:8,
                            mainAxisSpacing:10,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(
                                  CupertinoPageRoute(
                                    builder: (context) => DiseaseDetailScreen(
                                      data: snapshot.data!.data![index],
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey, width: 0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60.0),
                                      child: Center(
                                        child: Image.network(
                                          snapshot.data!.data![index].icon.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Expanded(
                                    child: Text(
                                      snapshot.data!.data![index].title.toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'FontPoppins',
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Padding(padding: const EdgeInsets.all(15),
                          child:Center(child:Text('${snapshot.error}',
                            style:const TextStyle(fontWeight:FontWeight.w500,
                                fontSize:15,fontFamily:'FontPoppins',color:Colors.red),)),);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Visibility(
                    visible: getTcmID.isNotEmpty && getPatientID.isNotEmpty && patientUniqueID.isNotEmpty,
                    child: GestureDetector(
                      onTap: () {
                        /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PDFScreen(
                            url:
                            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
                          ),
                        ),
                      );*/
                        if (getTcmID.isNotEmpty && getPatientID.isNotEmpty && patientUniqueID.isNotEmpty) {
                          handleUrlOpening(getTcmID, getPatientID, patientUniqueID);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Something is wrong!'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Haps Report',
                                    style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Check your haps report and you can download it',
                                    style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  const SizedBox(
                    height: 15,
                  ),


                  Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Consult with prescription!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'FontPoppins',
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Upload a prescription for tests!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'FontPoppins',
                                    fontSize: 12,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          SizedBox(
                            height: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const UploadPrescriptionScreen()),
                                );
                              },
                              child:  const Row(
                                children: [
                                  Image(image:AssetImage('assets/icons/prescription_icon.png'),
                                    width:15,height:15,color:Colors.white,),
                                  SizedBox(width:5,),
                                  Text(
                                    'upload',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Upcoming Appointment',
                        style: TextStyle(
                            fontSize: 18,
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
                        child: const Text(
                          'View All',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                    saveDate.isNotEmpty && saveTime.isNotEmpty
                      ? Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                offset: const Offset(0, 30),
                                blurRadius: 1,
                                spreadRadius: -10,
                              ),
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.3),
                                offset: const Offset(0, 20),
                                blurRadius: 1,
                                spreadRadius: -10,
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(250, 30, 149, 195),
                                const Color.fromARGB(200, 30, 149, 195)
                                    .withOpacity(0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/bima_sir.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dr. Bimal Chhajer',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Cardiology',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    const Row(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/icons/star.png'),
                                          width: 15,
                                          height: 15,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '4.5',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          saveDate, // Display saved date
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        const Icon(
                                          Icons.access_time,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          saveTime, // Display saved time
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 30,
                                  color: AppColors.primaryDark,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'No Appointment Scheduled',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const MyAppointmentsScreen()),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  // Icon for the button
                                  label: const Text(
                                    'Book Appointment',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontFamily: 'FontPoppins',
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 12.0,
                                    ),
                                    backgroundColor: AppColors.primaryColor,
                                    // Customize button color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Rounded corners
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                         height: 30,
                  ),


                  /* ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Image(
                      image: AssetImage('assets/icons/Treatments.png'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),*/

                  /*Container(
                    height: 190,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, top: 12),
                      child: Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Dr. Bimal Chhajer',
                                  style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Cardiology',
                                  style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'MBBS, MD, Founder | SAAOL',
                                  style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Flexible(
                                  child: Text(
                                    'Dr. Bimal Chhajer MBBS, MD is a well-known personality in the world of medical science in India and abroad.',
                                    style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 32,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.grey.withOpacity(0.2),
                                            width: 0.2),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Fluttertoast.showToast(msg: 'click');
                                    },
                                    child: const Text(
                                      'Digital Consult',
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Image(
                              image: AssetImage('assets/images/bima_sir.png'),
                              fit: BoxFit.cover,
                              height: 150,
                              width: 120,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/

                  /* GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const MyAppointmentsScreen()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const Image(
                        image: AssetImage('assets/images/bannner_image1.png'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),*/


                  Divider(
                    height: 25,
                    thickness: 5,
                    color: Colors.lightBlue[50],
                  ),
                  const SizedBox(
                    height: 15,
                  ),



                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align image to the top of the text
                              children: [
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Call or Chat with a Health Expert',
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Need Help? Talk to our health experts!',
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),),
                                SizedBox(width: 10), // Add spacing between the text and image
                                Image(
                                  image: AssetImage('assets/images/female_dcotor.png'),
                                  fit: BoxFit.cover,
                                  height: 90,
                                  width: 80,
                                ),
                              ],
                            ),
                            const SizedBox(height:10,),
                            Row(
                              children: [
                                SizedBox(
                                  height: 35,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.call,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    label: const Text(
                                      'Call Now',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    onPressed: () {
                                      //_makingPhoneCall();
                                      ValidationCons().callDialog(context);
                                      Fluttertoast.showToast(msg: 'Hi');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width:10,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.call,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    label: const Text(
                                      'Chat with us',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    onPressed: () {
                                      launchWhatsappWithMobileNumber();
                                      // ValidationCons().sendMessage();
                                      Fluttertoast.showToast(msg: 'Call');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Visibility(
                    visible: getTcmID.isNotEmpty && getPatientID.isNotEmpty && patientUniqueID.isNotEmpty,
                    child: GestureDetector(
                      onTap: () {
                        /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PDFScreen(
                            url:
                            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
                          ),
                        ),
                      );*/
                        if (getTcmID.isNotEmpty && getPatientID.isNotEmpty && patientUniqueID.isNotEmpty) {
                          handleUrlOpening(getTcmID, getPatientID, patientUniqueID);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Something is wrong!'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Haps Report',
                                    style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Check your haps report and you can download it',
                                    style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: getTcmID.isNotEmpty && getPatientID.isNotEmpty && patientUniqueID.isNotEmpty,
                    child:GestureDetector(
                      onTap: () {
                        if(getTcmID.isNotEmpty && getPatientID.isNotEmpty && patientUniqueID.isNotEmpty){
                          handleSafetyCircle(getTcmID,getPatientID,patientUniqueID);
                          Fluttertoast.showToast(msg:getTcmID);

                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Something is wrong!'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Saaol Safety Circle',
                                        style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Check your safety circle',
                                        style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                              ],
                            ),
                            const Divider(height:30,thickness:5,color:AppColors.primaryColor),
                            Padding(padding:const EdgeInsets.only(bottom:10),
                              child:SafetyCircleSection(
                                tcmID:getTcmID,
                                getPatientID:getPatientID,
                                patientUniqueID: patientUniqueID,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  const SizedBox(
                    height: 15,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Diet Plan',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 0.1),
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://www.helpguide.org/wp-content/uploads/2023/02/Mediterranean-Diet-1200x800.jpeg'),
                          fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Get your digestion on\ntrack by eliminating\ndairy',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryDark,
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontStyle: FontStyle.normal),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const DietPlanScreen()),
                                  );
                                },
                                child: const Text(
                                  'View my plan',
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Health Tools For You',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: toolsArray.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if(toolsArray[index] == 'Steps Counter'){
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const StepCounterScreen()),
                              );
                            }else if(toolsArray[index] == 'Heart Rate'){
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                    const HeartRateScreen()),
                              );
                            }
                            Fluttertoast.showToast(
                                msg: 'Clicked on ${toolsArray[index]}');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // Align items to the start to avoid overflow
                              children: [
                                Container(
                                  height: 55,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(toolImages[index]),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Added const for consistency and better performance
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    toolsArray[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.black87,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.hardRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border:
                                  Border.all(color: Colors.red, width: 0.5)),
                          child: const Image(
                            image: AssetImage('assets/images/chest_Pain.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Worried About Heart Health?',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                            Text(
                              'Consult a Cardiologist Today!',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 30,
                    thickness: 5,
                    color: Colors.lightBlue[50],
                  ),


                  Row(
                    children: [
                      const Text(
                        'Recommended test for you',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      Expanded(child: Container()),
                      const Text(
                        'View All',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const LabTestScreen()),
                      );
                    },
                    child: Image.asset(
                      'assets/images/lab_test_banner.png',
                      width: double.infinity,
                      height: 210,
                      fit: BoxFit.fill,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Maintain your vitals',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      Expanded(child: Container()),
                      const Text(
                        'View All',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  /*SizedBox(
  height: 220,
  child: GridView.builder(
    padding: const EdgeInsets.all(16.0),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio:
      0.8, // Adjusted to provide more space for text
    ),
    itemCount: specialties.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Fluttertoast.showToast(msg: 'Click');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                          'assets/images/chest_Pain.png'),
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: 90,
                      // Set the width to match the container width
                      child: Text(
                        'Heart',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'FontPoppins',
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  ),
),*/
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: vitalsArray.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                       MaintainVitalScreen(vitals: vitalsArray[index])),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 95,
                                  width: 95,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              vitalImagesArray[index]),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 95,
                                  // Set the width to match the container width
                                  child: Text(
                                    vitalsArray[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'FontPoppins',
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AppointmentBookScreen()),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.medical_information_outlined,
                              color: Colors.black,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              'My Appointments',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'FontPoppins',
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            Expanded(child: Container()),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 25,
                    thickness: 5,
                    color: Colors.lightBlue[50],
                  ),
                  const Text(
                    'Health Benefits of Living in the Hills',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins',
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    height:270,
                    child: FutureBuilder<WellnessCenterResponse>(
                      future: BaseApiService().getWellnessData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return  Center(child:Text('Error: ${snapshot.error}',
                            style:const TextStyle(fontWeight:FontWeight.w500,
                                fontFamily:'FontPoppins',fontSize:15,color:Colors.red),),);
                        } else if (snapshot.hasData && snapshot.data!.data != null) {
                          final wellnessData = snapshot.data!.data!;
                          if (wellnessData.isEmpty) {
                            return const Center(
                              child: Text("No wellness centers available."),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: wellnessData.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item = wellnessData[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true).push(
                                    CupertinoPageRoute(
                                      builder: (context) => PropertyScreen(data: item),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 7),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:260,
                                        width:300,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey, width: 0.4),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              child: CarouselSlider(
                                                items: packagesImages.map((imagePath) {
                                                  return SizedBox(
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Image.network(
                                                      imagePath,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Image.asset("assets/logo.png"); // Fallback image
                                                      },
                                                      loadingBuilder: (context, child, progress) {
                                                        if (progress == null) return child;
                                                        return Center(
                                                          child: CircularProgressIndicator(
                                                            value: progress.expectedTotalBytes != null
                                                                ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes!)
                                                                : null,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }).toList(),
                                                options: CarouselOptions(
                                                  viewportFraction: 1.0,
                                                  height: 100,
                                                  autoPlay: true,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                   const Text(
                                                    'Your Path to Heart Health At',
                                                    style: TextStyle(
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 13,
                                                      color:AppColors.primaryColor,
                                                    ),
                                                  ),
                                                   Text(item.centerName.toString(),
                                                    style: const TextStyle(
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize:16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: 5,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 15,
                                                    itemBuilder: (context, _) => const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 7,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print('Rating for item at index $index: $rating');
                                                    },
                                                  ),
                                                  const SizedBox(height: 7),
                                                  Row(
                                                    children: [
                                                       const Icon(
                                                        Icons.location_on_outlined,
                                                        color: AppColors.primaryDark,
                                                        size: 18,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        item.locationName ?? "Unknown Location",
                                                        style: const TextStyle(
                                                          fontFamily: 'FontPoppins',
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black87,
                                                          fontSize:13,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(thickness: 0.2, height: 10, color: Colors.grey),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text("No data available."));
                        }
                      },
                    ),
                  ),


                  Divider(
                    height: 25,
                    thickness: 5,
                    color: Colors.lightBlue[50],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Articles for you',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => const OurBlogsScreen()),
                          );
                        },
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    height: 240, // Adjusted height
                    child: FutureBuilder<BlogsResponseData>(
                      future: BaseApiService().blogsData(selectedCategory),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print('Error fetching blogs: ${snapshot.error}');
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.blogs == null || snapshot.data!.blogs!.isEmpty) {
                          return const Center(child: Text('No blogs available.'));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.blogs!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(CupertinoPageRoute(
                                    builder: (context) => BlogDetailPageScreen(
                                        blogs: snapshot.data!.blogs![index]),
                                  ));
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                  padding: const EdgeInsets.all(10),
                                  width: 270,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey.shade300, width: 0.8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min, // Prevent unnecessary space
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          snapshot.data!.blogs![index].image.toString(),
                                          height: 130,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Flexible( // Ensures dynamic height for large text
                                        child: Text(
                                          snapshot.data!.blogs![index].title.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily: 'FontPoppins',
                                            color: Colors.black87,
                                          ),
                                          maxLines: 2, // Allows text to wrap into 2 lines before truncating
                                          overflow: TextOverflow.ellipsis, // Prevents overflow
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                       const Row(
                                        children: [
                                          Icon(Icons.calendar_month_outlined, size: 16, color: Colors.black54),
                                          SizedBox(width: 5),
                                          Text(
                                            'June 11, 2024', // Replace with dynamic date if available
                                            style: TextStyle(fontSize: 12, color: Colors.black54,fontFamily: 'FontPoppins',fontWeight:FontWeight.w500),
                                          ),
                                          Spacer(),
                                          Icon(Icons.access_time, size: 16, color: Colors.black54),
                                          SizedBox(width: 5),
                                           Text(
                                            '5 min read',
                                            style: TextStyle(fontSize: 12, color: Colors.black54,fontFamily: 'FontPoppins',fontWeight:FontWeight.w500),
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
                      },
                    ),
                  ),


                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 25,
                    thickness: 5,
                    color: Colors.lightBlue[50],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Videos',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      Expanded(child: Container()),
                      const Text(
                        'View All',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  /* SizedBox(
                    height: 300, // Adjust height as needed to fit content
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: videosArray.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final videoData = videosArray[index];
                        final YoutubePlayerController _controller =
                            YoutubePlayerController(
                          initialVideoId: videoData['videoId']!,
                          flags: const YoutubePlayerFlags(
                            autoPlay: false,
                            mute: false,
                          ),
                        );
                        return InkWell(
                          onTap: () {
                            Fluttertoast.showToast(msg: 'click');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Card(
                                  semanticContainer: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 2,
                                  child: Container(
                                    height: 270,
                                    width: 310,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: YoutubePlayer(
                                              controller: _controller,
                                              showVideoProgressIndicator: true,
                                              progressIndicatorColor:
                                                  Colors.blueAccent,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.thumb_up,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                videoData['likes']!,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'FontPoppins',
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            videoData['title']!,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),*/

                  /*  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 30,
                    thickness: 5,
                    color: Colors.lightBlue[50],
                  ),
                  Container(
                    height: 240,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'SAAOL',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: AppColors.primaryDark),
                          ),
                          Text(
                            'Science and Art of Living',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Image(
                                image:
                                    AssetImage('assets/icons/treated_icon.jpg'),
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '550000+',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppColors.primaryColor),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    // Adjust the width as necessary to ensure the text wraps
                                    child: Text(
                                      'Patients Treated',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image(
                                image:
                                    AssetImage('assets/icons/treated_icon.jpg'),
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '130+',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppColors.primaryColor),
                                  ),
                                  SizedBox(
                                    // Adjust the width as necessary to ensure the text wraps
                                    child: Text(
                                      'Across the India\nCenters',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/icons/experience_icon.jpg'),
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '29+',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppColors.primaryColor),
                                  ),
                                  SizedBox(
                                    // Adjust the width as necessary to ensure the text wraps
                                    child: Text(
                                      'of Saaol healthcare\nyears of experience',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Icon(
                                Icons.location_city,
                                size: 30,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '25+',
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppColors.primaryColor),
                                  ),
                                  SizedBox(
                                    // Adjust the width as necessary to ensure the text wraps
                                    child: Text(
                                      'Across states in\nindia',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  */

                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Google reviews & ratings',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins',
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        '4.6',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                            initialRating: 5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 17,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 10,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            '2000 rating',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 190,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: treatmentsArray.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Fluttertoast.showToast(msg: 'click');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 170,
                                  width: 320,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey, width: 0.2),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.asset(
                                                'assets/images/profile.png',
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            // Add spacing between the image and text
                                            const Expanded(
                                              child: Text(
                                                textAlign: TextAlign.start,
                                                testimonialTxt,
                                                style: TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              'Vinod Kumar Joshi,',
                                              style: TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Uttrakhand',
                                              style: TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Colors.black38),
                                            ),
                                          ],
                                        ),
                                        RatingBar.builder(
                                          initialRating: 5,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 15,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 7,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(
                                                'Rating for ${items[index]}: $rating');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: GestureDetector(
              onTap: () {
                _showAgentDialog(context);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: BorderRadius.circular(10)),
                child: const Image(
                  image: AssetImage('assets/images/call_center.png'),
                  height: 30,
                  width: 30,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildClickableServiceCard(
    String imagePath, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 95,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'FontPoppins',
                fontSize: 11,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}


_launchURLApp() async {
  var url = Uri.parse("https://saaol.com/zero-oil-cooking");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
