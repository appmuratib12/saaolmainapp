import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/AppointmentBookScreen.dart';
import '../Utils/AppointmentsScreen.dart';
import '../Utils/BlogDetailPageScreen.dart';
import '../Utils/DietPlanScreen.dart';
import '../Utils/DiseaseDetailScreen.dart';
import '../Utils/EditProfileScreen.dart';
import '../Utils/HapsReportScreen.dart';
import '../Utils/LabTestScreen.dart';
import '../Utils/MaintainVitalScreen.dart';
import '../Utils/NearByCenterScreen.dart';
import '../Utils/NotificationScreen.dart';
import '../Utils/SearchBarScreem.dart';
import '../Utils/TreatmentDetailsPageScreen.dart';
import '../Utils/UploadPrescriptionScreen.dart';
import '../Utils/WellnessCenterScreen.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';

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
  final List<String> imgList = [
    'https://drsanjaykumar.co.in/wp-content/uploads/2022/10/Best-Cardiologist-in-Faridabad-explains-What-is-a-Complete-Heart-Block.jpg',
    'https://drsanjaykumar.co.in/wp-content/uploads/2022/10/Best-Cardiologist-in-Faridabad-explains-What-is-a-Complete-Heart-Block.jpg',
  ];

  final List<String> items = List<String>.generate(10, (i) => "Item $i");

  final Uri _url = Uri.parse(
      'https://file-examples.com/storage/fef44df12666d835ba71c24/2017/10/file-sample_150kB.pdf');

  Future<void> _launchUrl1() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  List<String> labTestArray = [
    "KFT with Uric Acid",
    "KFT with Uric Acid",
    "KFT with Uric Acid"
  ];
  String saveDate = "";
  String saveTime = "";
  bool isAppointmentAvailable = false;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    _startAutoSlide1();
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
      saveDate = prefs.getString('appointmentDate') ?? '';
      saveTime = prefs.getString('appointmentTime') ?? '';
      print('saveDate: $saveDate');
      print('saveTime: $saveTime');
      isAppointmentAvailable = saveDate.isNotEmpty && saveTime.isNotEmpty;
      print('isAppointmentAvailable: $isAppointmentAvailable');
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
  String mobileNumber = "+918447776000";

  launchWhatsappWithMobileNumber() async {
    final url = "whatsapp://send?phone=$mobileNumber&text=$message";
    if (await canLaunchUrl(Uri.parse(Uri.encodeFull(url)))) {
      await launchUrl(Uri.parse(Uri.encodeFull(url)));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _startAutoSlide1() {
    timer1 = Timer.periodic(const Duration(seconds: 3), (Timer timer1) {
      if (currentPage < images.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  final List<Specialty> specialties = [
    Specialty('Coronary Artery Disease', 'assets/images/coronary_disease2.png'),
    Specialty('Angina', 'assets/icons/angina_icon6.png'),
    Specialty(
        'Hypertension (High Blood Pressure)', 'assets/images/hypertension.png'),
    Specialty('Chest Pain', 'assets/images/chest_pain2.png'),
    Specialty('Heart Attack', 'assets/images/heart_attack.png'),
    Specialty('Heart Failure', 'assets/images/heart_failure.png'),
    Specialty('Diabetic Foot Ulcers', 'assets/images/diabetic.png'),
    Specialty('Stroke Rehabilitation', 'assets/images/stroke.png'),
  ];

  List<String> imageUrls = [
    'https://www.mirakleihc.com/wellness_admin/resource/uploads/srcimg/1MYiNSWnzn23032024025902mirakle-eecp.jpeg',
    'https://www.nightingaledubai.com/wp-content/uploads/2023/05/iv-drip-detox.jpg',
    'https://img.freepik.com/free-photo/young-beautiful-woman-doing-yoga-nature_1139-909.jpg?t=st=1721718678~exp=1721722278~hmac=65a9b900e0b3dfdfd5e389b028796e6a9298430e93915a50c41127d86cbc8a5d&w=1480',
    'https://img.freepik.com/free-photo/couple-preparing-vegetable-salad-kitchen_23-2148114229.jpg?t=st=1721718415~exp=1721722015~hmac=4f57403ab941482b517e514d7c3062306bd3cc254c21a45deddc640f7ed4646c&w=1480'
  ];

  List<String> packagesImages = [
    'https://media.istockphoto.com/id/1453121684/photo/modern-hotel-room-with-double-bed-night-tables-and-day-sofa-bed.webp?b=1&s=170667a&w=0&k=20&c=0MGlloRKwQjR_xeIt0s0IklHyt2bQHDNoFvKml3BQPc=',
  ];

  //CarouselController carouselController = CarouselController();

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

  final TextEditingController _searchController =
      TextEditingController(); // Search Controller for input

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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
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
                              const Text(
                                'Welcome, Mohd',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'FontPoppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Fluttertoast.showToast(msg: 'Click');
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      'Location Delhi',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'FontPoppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    Icon(
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
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const NotificationScreen(),
                                  ),
                                );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildClickableServiceCard(
                        'assets/images/online_appointment.jpg',
                        'BOOK ONLINE CONSULT',
                        () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const MyAppointmentsScreen()),
                          );
                        },
                      ),
                      buildClickableServiceCard(
                        'assets/images/offline_appointment.jpg',
                        'BOOK OFFLINE CONSULT',
                        () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const MyAppointmentsScreen()),
                          );
                        },
                      ),
                      buildClickableServiceCard(
                        'assets/images/lab_test.jpg',
                        'BOOK LAB TEST',
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
                        'NEARBY CENTERS',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NearByCenterScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: images.length,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 7,
                        dotWidth: 7,
                        activeDotColor: AppColors.primaryColor,
                        dotColor: Colors.grey,
                      ),
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
                          builder: (context) => const PDFScreen(
                            url:
                                'https://file-examples.com/storage/fef44df12666d835ba71c24/2017/10/file-sample_150kB.pdf',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 65,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[50],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Haps Report',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Text(
                                'Check your haps report and you can download it',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor),
                              )
                            ],
                          ),
                          Expanded(child: Container()),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                        ],
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
                      color: Colors.white,
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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Book with prescription!',
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
                              child: const Text(
                                'upload',
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
                  isAppointmentAvailable
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
                      : const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 30,
                                  color: AppColors.primaryDark,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'No Appointment Scheduled',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Please schedule an appointment.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
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

                  Divider(
                    height: 40,
                    thickness: 5,
                    color: Colors.lightBlue[50],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Diseases We Treat',
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 240,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio:
                            0.7, // Adjusted to provide more space for text
                      ),
                      itemCount: specialties.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      const DiseaseDetailScreen()),
                            );
                            Fluttertoast.showToast(
                                msg: '${specialties.length}');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.2),
                                  shape: BoxShape.circle,
                                  // color: Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60.0),
                                  child: Center(
                                    child: Image.asset(
                                      specialties[index].imagePath,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Expanded(
                                child: Text(
                                  specialties[index].name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    // Reduced font size to fit text
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
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                  Container(
                    height: 118,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Call or Chat with a Health Expert',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'Need Help? Talk to our health experts!',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                                        _makingPhoneCall();
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
                                    width: 5,
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
                              )
                            ],
                          ),
                          const Image(
                            image:
                                AssetImage('assets/images/female_dcotor.png'),
                            fit: BoxFit.cover,
                            height: 90,
                            width: 70,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemCount: slider2Images.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            slider2Images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: images.length,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 6,
                        dotWidth: 6,
                        activeDotColor: AppColors.primaryColor,
                        dotColor: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: treatmentsArray.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TreatmentDetailsPageScreen()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 145,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrls[index]),
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
                                          child: Text(
                                            treatmentsArray[index],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'FontPoppins',
                                              fontSize: 12,
                                            ),
                                            // Ensure the text is visible
                                            textAlign: TextAlign.center,
                                            // Center-align the text
                                            overflow: TextOverflow.ellipsis,
                                            // Handle overflow
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
                    ),
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
                              'https://img.freepik.com/free-photo/healthy-bowl-homemade-vegetarian-salad-variation-generated-by-ai_188544-27079.jpg?t=st=1721723112~exp=1721726712~hmac=bfd5fe8c78bc0c0a94a7be77ffffff96788899bc7d3b0be3e3d89afcd5338698&w=1800'),
                          fit: BoxFit.fill),
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
                                  backgroundColor: AppColors.primaryColor,
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
                    height: 25,
                    thickness: 5,
                    color: Colors.lightBlue[50],
                  ),

                  /*const Text(
                    'Tips of the day',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 120.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                    ),
                    items: imgList
                        .map((item) => Container(
                              margin: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0)),
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(
                                      item,
                                      fit: BoxFit.cover,
                                      width: 1000.0,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Text(
                                            'Image not available',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        );
                                      },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 10,
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                  const Text(
                    'Your Monthly Goals',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),*/

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
                  Image.asset('assets/images/lab_test_banner.png',
                    width:double.infinity,height:210,fit:BoxFit.fill,),
                  /*Container(
                    height: 215,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Manage Stress',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'FontPoppins'),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Your kit includes nasal drops with pure ghee that leads to healthy sleep patterns',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Add some space between the text and image
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Colors.white, // Border color
                                    width: 1.0, // Border width
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    'https://media.licdn.com/dms/image/C5612AQFHxUCo6bar3w/article-cover_image-shrink_720_1280/0/1627329862056?e=2147483647&v=beta&t=BLUWvvm2tidEKxs3NEC3DzNwiQUjLD15qQO1bYUT17k',
                                    height: 70,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Row(
                            children: [
                              Text(
                                'MONTH',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.primaryColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'FontPoppins',
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Fluttertoast.showToast(msg: 'Explore');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'More Details',
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
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
                                      const MaintainVitalScreen()),
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
                  Row(
                    children: [
                      const Text(
                        'SAAOL Wellness Centers',
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
                  SizedBox(
                    height: 290,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: packagesImages.length,
                      // Update this to the actual length of your data array
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const PropertyScreen()),
                            );
                            Fluttertoast.showToast(msg: 'click');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 280,
                                  width: 280,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey, width: 0.4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: CarouselSlider(
                                            items:
                                                packagesImages.map((imagePath) {
                                              return SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Image.network(
                                                  imagePath,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    return Image.asset(
                                                        "assets/logo.png"); // Fallback image
                                                  },
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Your Path to Heart Health At',
                                              style: TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Colors
                                                    .blue, // Replace with AppColors.primaryColor if defined
                                              ),
                                            ),
                                            const Text(
                                              'Saaol Wellness & Research Institute',
                                              style: TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                            RatingBar.builder(
                                              initialRating: 3,
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
                                                    'Rating for item at index $index: $rating');
                                              },
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            const Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Colors.blue,
                                                  // Replace with AppColors.primaryColor if defined
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Dehradun, Uttarakhand',
                                                  style: TextStyle(
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 0.2,
                                        height: 10,
                                        color: Colors.grey,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          'This is a sample package text',
                                          // Update with your variable `packageTxt`
                                          style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            color: Colors.black54,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
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
                    height: 215,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: treatmentsArray.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      const BlogDetailPageScreen()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 140,
                                  width: 260,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/blog_image1.jpg'),
                                          fit: BoxFit.fill)),
                                ),
                                const SizedBox(height: 8),
                                const SizedBox(
                                  width: 250,
                                  child: Text(
                                    'Understanding Arteriosclerosis and Safeguarding Your Heart Health',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'FontPoppins',
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      size: 18,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('June 11, 2024',
                                        style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.black54)),
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.black54,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('5 Minutes',
                                        style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.black54)),
                                  ],
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

                  const SizedBox(
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
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'What our users have to say',
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
                    height: 200,
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
                                  width: 300,
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
              onPressed: () {},
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

class Specialty {
  final String name;
  final String imagePath;

  Specialty(this.name, this.imagePath);
}
