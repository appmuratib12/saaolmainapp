import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:saaolapp/Utils/NearCenterScreen.dart';
import 'package:saaolapp/data/model/apiresponsemodel/ReviewRatingResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../DialogHelper.dart';
import '../Utils/AppointmentBookScreen.dart';
import '../Utils/AppointmentsScreen.dart';
import '../Utils/BlogDetailPageScreen.dart';
import '../Utils/DiseaseDetailScreen.dart';
import '../Utils/EditProfileScreen.dart';
import '../Utils/NotificationScreen.dart';
import '../Utils/OurBlogsScreen.dart';
import '../Utils/StatesData.dart';
import '../Utils/TreatmentDetailsPageScreen.dart';
import '../Utils/UploadPrescriptionScreen.dart';
import '../Utils/WellnessCenterScreen.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../constant/text_strings.dart';
import '../data/model/apiresponsemodel/BlogsResponseData.dart';
import '../data/model/apiresponsemodel/DiseaseResponseData.dart';
import '../data/model/apiresponsemodel/TreatmentsResponseData.dart';
import '../data/model/apiresponsemodel/WellnessCenterResponse.dart';
import '../data/model/apiresponsemodel/YoutubeResponse.dart';
import '../data/network/ApiService.dart';
import '../data/network/BaseApiService.dart';
import 'AddAddressScreen.dart';
import 'NavBarScreens/DetoxScreen.dart';
import 'NavBarScreens/LifeStylePageScreen.dart';
import 'NavBarScreens/TreatmentsOverviewScreen.dart';
import 'NavBarScreens/ZeroOilPageScreen.dart';
import 'NearByCenterScreen.dart';
import 'VideoPlayerScreen.dart';


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
  int currentPage = 0;
  Timer? _timer;
  Timer? timer1;
  List<String> treatmentsArray = [
    'SAAOL Natural Bypass',
    'SAAOL Detox',
    'Life Style',
    'Zero oil cooking',
  ];
  List<String> toolsArray = ['Steps Counter','Heart Rate',];
  final List<String> toolImages = [
    'assets/icons/step_counter_tool.png',
    'assets/icons/heart_rate_latest.png',
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
  String? getSubLocality;
  String displayedLocation = '';
  String getLatitude = '';
  String getLongitude = '';
  String getCityName = '';
  String savedLocation = '';


  @override
  void initState() {
    super.initState();
    _loadSavedAddresses();
    _loadSavedAppointment();
   // _getStoredLocation();
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
      getTcmID = prefs.getString(ApiConstants.TCM_ID) ?? '';
      getLatitude = prefs.getString('lat') ?? '';
      getLongitude = prefs.getString('long') ?? '';
      getSubLocality = (prefs.getString('subLocality') ?? '');
      getCity =  prefs.getString('locationName') ?? '';
      getPinCode =prefs.getString(ApiConstants.PINCODE) ?? '';
      savedLocation =prefs.getString('selected_location') ?? '';
      print('GetPincode:$getPinCode$getCity');

      if (getPatientID.isNotEmpty) {
        userName = (prefs.getString('PatientFirstName') ?? '');
        saveDate = prefs.getString('appointmentDate') ?? '';
        saveTime = prefs.getString('appointmentTime') ?? '';

      } else {
        userName = (prefs.getString(ApiConstants.USER_NAME) ?? '');
        saveDate = prefs.getString('appointmentDate') ?? '';
        saveTime = prefs.getString('appointmentTime') ?? '';
        print('isAppointmentAvailable: $isAppointmentAvailable');

      }
    });
  }

  String message = "Welcome to the SAAol...";
  String mobileNumber ='';

  final TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'Heart';
  final ApiService _apiService = ApiService();
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
  List<String> savedAddresses = [];
  void _loadSavedAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedAddresses = prefs.getStringList('saved_addresses') ?? [];
    });
  }
  String _capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
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
                                    fontSize:15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ]
                              else if(googleUserID.isNotEmpty)...[
                                Text('Hello, $googlePatientName',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'FontPoppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ]
                              else ...[
                                  Text('Hi, $userName',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'FontPoppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],

                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor:Colors.grey[200],
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                    ),
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom,
                                        ),
                                        child: Container(
                                          height:400,
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          decoration:  BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 4,
                                                margin: const EdgeInsets.only(bottom: 16),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[400],
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Select Saaol Center location',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:'FontPoppins',
                                                    color:Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: Colors.white, width: 1),
                                                ),
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      leading:  const Icon(Icons.my_location, color:AppColors.primaryColor),
                                                      title: const Text(
                                                        'Use current location',
                                                        style: TextStyle(fontWeight: FontWeight.w500,fontSize:14,fontFamily:'FontPoppins',color:Colors.black),
                                                      ),
                                                      subtitle: Text('$getSubLocality,$getCity,$getPinCode',
                                                        style:const TextStyle(fontWeight:FontWeight.w500,fontSize:13,fontFamily:'FontPoppins',color:Colors.black54),
                                                      ),
                                                      onTap: () async {
                                                        final prefs = await SharedPreferences.getInstance();
                                                        final currentLocation = '$getCity,$getPinCode,';
                                                        await prefs.setString('selected_location', currentLocation);
                                                        if (context.mounted) {
                                                          setState(() {
                                                            savedLocation = currentLocation;
                                                          });
                                                          Navigator.pop(context);
                                                        }
                                                      },
                                                    ),
                                                    const SizedBox(height: 5),
                                                    const Divider(),
                                                    ListTile(
                                                      leading:  const Icon(Icons.add, color:AppColors.primaryColor),
                                                      title:  const Text(
                                                        'Add new address',
                                                        style: TextStyle(color: AppColors.primaryColor,
                                                            fontWeight:FontWeight.w600,fontSize:15,fontFamily:'FontPoppins'),  // Highlighting with green color
                                                      ),
                                                      trailing:  const Icon(Icons.arrow_forward_ios, color:AppColors.primaryColor,size:20,),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => AddAddressScreen(
                                                                latitude: double.tryParse(getLatitude) ?? 0.0,
                                                                longitude: double.tryParse(getLongitude) ?? 0.0,
                                                                currentLocationName:'$getCity,$getSubLocality'
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Divider(),
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Your Saved Address',
                                                  style: TextStyle(fontWeight: FontWeight.w600,fontSize:15,fontFamily:'FontPoppins',color:Colors.black),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Expanded(
                                                child: ListView(
                                                  children: savedAddresses.map((address) {
                                                    final subLocality = address.split(',').first.trim();
                                                    return ListTile(
                                                      leading: const Icon(Icons.location_on_outlined),
                                                      title: Text(
                                                        address,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 14,
                                                          fontFamily: 'FontPoppins',
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        final prefs = await SharedPreferences.getInstance();
                                                        await prefs.setString('selected_location', subLocality);
                                                        prefs.remove('locationName');
                                                        prefs.remove(ApiConstants.PINCODE);
                                                        if (context.mounted) {
                                                          Navigator.pop(context);
                                                        }
                                                      },
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child:Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        (savedLocation.isNotEmpty)
                                            ? savedLocation
                                              : (getCity.isNotEmpty && getPinCode.isNotEmpty)
                                            ? '$getCity, $getPinCode'
                                            : 'Select Location',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'FontPoppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      size: 18,
                                      color: Colors.white,
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
                      FadeRoute1(
                        page: NearCenterScreen(
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
                                fontSize: 14,
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
              margin: const EdgeInsets.only(top: 16),
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
                                  builder: (context) => const MyAppointmentsScreen(initialIndex: 0)),
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
                                  builder: (context) => const MyAppointmentsScreen(initialIndex: 1)),
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
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Expanded(child: Container()),
                      const Text(viwe_all,
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize:13,
                            fontWeight: FontWeight.w500,
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
                          final errorMessage = snapshot.error.toString();
                          if (errorMessage.contains('No internet connection')) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wifi_off_rounded,
                                      size:30,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(height:8),
                                    Text(
                                      'No Internet Connection',
                                      style: TextStyle(
                                        fontSize:14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'Please check your network settings and try again.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:12,
                                        fontFamily: 'FontPoppins',
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Center(child: Text('Error: $errorMessage'));
                          }
                        } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                          return const  Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 12),
                                  Text(
                                    'No Treatments Data are available.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Please check back later. New data will be available soon!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'FontPoppins',
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
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
                                                    fontSize:10,
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
                        fontSize:16,
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
                            crossAxisCount:3,
                            crossAxisSpacing:6,
                            mainAxisSpacing:12,
                            childAspectRatio:1,
                          ),
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .push(
                                  CupertinoPageRoute(
                                    builder: (context) => DiseaseDetailScreen(data: snapshot.data!.data![index],
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
                                        fontSize:9,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'FontPoppins',
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines:2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        final errorMessage = snapshot.error.toString();
                        if (errorMessage.contains('No internet connection')) {
                          return  const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.wifi_off_rounded,
                                    size:30,
                                    color: Colors.redAccent,
                                  ),
                                  SizedBox(height:8),
                                  Text(
                                    'No Internet Connection',
                                    style: TextStyle(
                                      fontSize:14,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    'Please check your network settings and try again.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize:12,
                                      fontFamily: 'FontPoppins',
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Center(child: Text('Error: $errorMessage'));
                        }
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),

                  Visibility(
                    visible:getPatientID.isNotEmpty && patientUniqueID.isNotEmpty,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatesData(patientID: getPatientID),
                          ),
                        );
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
                                      fontSize:15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(check_haps_txt,
                                    style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 11,
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

                  /*Container(
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
                                'Consult with prescription',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'FontPoppins',
                                    fontSize:13,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Upload a prescription for tests',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'FontPoppins',
                                    fontSize:11,
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
                  ),*/

                /*  Row(
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
                                    const PatientAppointmentScreen()),
                          );
                        },
                        child: const Text(viwe_all,
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
                  const AppointmentWidget(),
                  const SizedBox(
                         height: 30,
                  ),*/

                /*  Divider(
                    height: 25,
                    thickness: 5,
                    color: Colors.lightBlue[50],
                  ),*/
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
                                    Text(call_chat_txt,
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize:12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(need_help_txt,
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 12,
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
                                          fontSize:12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    onPressed: () {
                                      DialogHelper.showCallDialog(context, () {
                                        DialogHelper.showRequestDialog(context);
                                        _sendRequest();
                                      });
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
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    onPressed: () {
                                      DialogHelper.sendWhatsAppMessage('Hi,What can we help you?');
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
                    visible:getPatientID.isNotEmpty && patientUniqueID.isNotEmpty,
                    child:GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatesData(patientID: getPatientID),
                          ),
                        );
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
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Check your safety circle',
                                        style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize: 11,
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
                    height:10,
                  ),
                  const Text(
                    'Diet Plan',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize:16,
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
                          'https://www.helpguide.org/wp-content/uploads/2023/02/Mediterranean-Diet-1200x800.jpeg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4), // dark overlay for readability
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Get your digestion on track\nby eliminating dairy',
                                  style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryDark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => StatesData(patientID: getPatientID),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'View my plan',
                                    style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                /*  const Text(
                    'Health Tools For You',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w600,
                        fontSize:16,
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
                                      fontSize:11,
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
                  ),*/
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                            const MyAppointmentsScreen()),
                      );
                    },
                    child:Container(
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
                                    fontSize:13,
                                    color: Colors.white),
                              ),
                              Text(
                                'Consult a Cardiologist Today!',
                                style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize:10,
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
                  ),

                  (getPatientID.isNotEmpty && patientUniqueID.isNotEmpty)
                      ? Column(
                    children: [
                      Divider(
                        height: 30,
                        thickness: 5,
                        color: Colors.lightBlue[50],
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const PatientAppointmentScreen()),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 0.2),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.medical_information_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'My Appointments',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'FontPoppins',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      : const SizedBox.shrink(),

                  Divider(
                    height:30,
                    thickness: 5,
                    color: Colors.lightBlue[50],
                  ),
                  const Text(
                    'Health Benefits of Living in the Hills',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins',
                        fontSize:16,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    height:310,
                    child: FutureBuilder<WellnessCenterResponse>(
                      future: BaseApiService().getWellnessData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          final errorMessage = snapshot.error.toString();
                          if (errorMessage.contains('No internet connection')) {
                            return  const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wifi_off_rounded,
                                      size:30,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(height:8),
                                    Text(
                                      'No Internet Connection',
                                      style: TextStyle(
                                        fontSize:14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'Please check your network settings and try again.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:12,
                                        fontFamily: 'FontPoppins',
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Center(child: Text('Error: $errorMessage'));
                          }
                        } else if (snapshot.hasData && snapshot.data!.data != null) {
                          final wellnessData = snapshot.data!.data!;
                          if (wellnessData.isEmpty) {
                            return const  Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 12),
                                    Text(
                                      'No wellness centers available.',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Please check back later. New wellness center data will be available soon!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'FontPoppins',
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                        height:300,
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
                                                items: item.images!.map((imagePath) {
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
                                                  height:110,
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
                                                      fontSize:12,
                                                      color:AppColors.primaryColor,
                                                    ),
                                                  ),
                                                   const SizedBox(height:5,),
                                                   Text(item.centerName.toString(),
                                                    style: const TextStyle(
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize:14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height:5,),
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

                                                      Text(_capitalizeFirstLetter(item.locationName ?? "Unknown Location"),
                                                        style: const TextStyle(
                                                          fontFamily: 'FontPoppins',
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black87,
                                                          fontSize:13,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                   Divider(thickness: 0.2, height:12, color: Colors.blue[300]),
                                                  Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      OutlinedButton.icon(
                                                        onPressed: () {
                                                          DialogHelper.makingPhoneCall('+918447366000');
                                                        },
                                                        icon: const Icon(Icons.call, color: AppColors.primaryDark),
                                                        label: const Text(
                                                          'Call',
                                                          style: TextStyle(
                                                            fontFamily: 'FontPoppins',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14,
                                                            color: AppColors.primaryDark,
                                                          ),
                                                        ),
                                                        style: OutlinedButton.styleFrom(
                                                          side: const BorderSide(color: AppColors.primaryDark),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                      ),
                                                      OutlinedButton.icon(
                                                        onPressed: () async {
                                                          double destinationLat = 30.3267294;
                                                          double destinationLng = 77.9995589;
                                                          String locationUrl = "https://www.google.com/maps/dir/$getLatitude,$getLongitude/$destinationLat,$destinationLng";
                                                          openUrl(openingUrl: locationUrl);
                                                        },
                                                        icon: const Icon(Icons.directions, color: AppColors.primaryDark),
                                                        label: const Text(
                                                          'Directions',
                                                          style: TextStyle(
                                                            fontFamily: 'FontPoppins',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14,
                                                            color: AppColors.primaryDark,
                                                          ),
                                                        ),
                                                        style: OutlinedButton.styleFrom(
                                                          side: const BorderSide(color: AppColors.primaryDark),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
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
                            fontSize:16,
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
                        child: const Text(viwe_all,
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize:13,
                            fontWeight: FontWeight.w500,
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
                    height:270, // Adjusted height
                    child: FutureBuilder<BlogsResponseData>(
                      future: BaseApiService().blogsData(selectedCategory),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          final errorMessage = snapshot.error.toString();
                          if (errorMessage.contains('No internet connection')) {
                            return  const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wifi_off_rounded,
                                      size:30,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(height:8),
                                    Text(
                                      'No Internet Connection',
                                      style: TextStyle(
                                        fontSize:14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'Please check your network settings and try again.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:12,
                                        fontFamily: 'FontPoppins',
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Center(child: Text('Error: $errorMessage'));
                          }
                        } else if (!snapshot.hasData || snapshot.data!.blogs == null || snapshot.data!.blogs!.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 12),
                                  Text(
                                    'No blogs are available.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Please check back later. New blogs will be available soon!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'FontPoppins',
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
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
                                            fontWeight: FontWeight.w500,
                                            fontSize:13,
                                            fontFamily: 'FontPoppins',
                                            color: Colors.black87,
                                          ),
                                          maxLines: 3, // Allows text to wrap into 2 lines before truncating
                                          overflow: TextOverflow.ellipsis, // Prevents overflow
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                     Align(alignment:Alignment.centerRight,child:GestureDetector(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(CupertinoPageRoute(
                                      builder: (context) => BlogDetailPageScreen(
                                          blogs: snapshot.data!.blogs![index]),
                                    ));
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryDark,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Read more',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          fontFamily: 'FontPoppins',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),),
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
                        'Our Youtube Channel Videos',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            fontSize:16,
                            color: Colors.black),
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse('https://www.youtube.com/@SAAOLHeartCare');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize:13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline, // Optional: looks like a link
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),


                  SizedBox(
                    height: 300,
                    child: FutureBuilder<YoutubeResponse>(
                      future: BaseApiService().getYoutubeData(), // Make sure this matches your actual method
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print('Error fetching YouTube video: ${snapshot.error}');
                          final errorMessage = snapshot.error.toString();
                          if (errorMessage.contains('No internet connection')) {
                            return  const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wifi_off_rounded,
                                      size:30,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(height:8),
                                    Text(
                                      'No Internet Connection',
                                      style: TextStyle(
                                        fontSize:14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'Please check your network settings and try again.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:12,
                                        fontFamily: 'FontPoppins',
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Center(child: Text('Error: $errorMessage'));
                          }
                        } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 12),
                                  Text(
                                    'No YouTube Video Available.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Please check back later. New youtube video will be available soon!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'FontPoppins',
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          final videos = snapshot.data!.data!;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: videos.length,
                            itemBuilder: (context, index) {
                              final video = videos[index];
                              final uri = Uri.parse(video.videoId.toString());
                              final videoId = uri.queryParameters['v'] ?? ''; // Extracts the actual video ID
                              final thumbnailUrl = 'https://img.youtube.com/vi/$videoId/0.jpg';

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayerScreen(videoId: videoId,title:video.title.toString()),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      width: 320,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                  thumbnailUrl,
                                                  width: double.infinity,
                                                  height: 180,
                                                  fit: BoxFit.cover,
                                                ),
                                                Positioned.fill(
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.play_circle_fill,
                                                      size: 60,
                                                      color: Colors.white.withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(Icons.thumb_up, size: 18, color: Colors.grey),
                                              const SizedBox(width: 6),
                                              Text(
                                                video.like.toString(),
                                                style: const TextStyle(
                                                  fontSize:13,
                                                  fontFamily:'FontPoppins',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Expanded(
                                            child: Text(
                                              video.title.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize:13,
                                                fontFamily:'FontPoppins',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                    height: 15,
                  ),
                  const Text(
                    'Google reviews & ratings',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins',
                        fontSize:16,
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
                            fontSize: 27,
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
                    child:FutureBuilder<ReviewRatingResponse>(
                      future: BaseApiService().getReviewRatingData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print('Error fetching review rating: ${snapshot.error}');
                          final errorMessage = snapshot.error.toString();
                          if (errorMessage.contains('No internet connection')) {
                            return  const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wifi_off_rounded,
                                      size:30,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(height:8),
                                    Text(
                                      'No Internet Connection',
                                      style: TextStyle(
                                        fontSize:14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'Please check your network settings and try again.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:12,
                                        fontFamily: 'FontPoppins',
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Center(child: Text('Error: $errorMessage'));
                          }
                        } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 12),
                                  Text(
                                    'No Review Ratings Available.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Please check back later. New ratings will be available soon!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'FontPoppins',
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal:5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height:180,
                                      width: 320,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.15),
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                        border: Border.all(color: Colors.grey.shade200),
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
                                                  child: Image.asset('assets/images/profile.png',
                                                    fit: BoxFit.cover,
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                 Expanded(
                                                  child: Text(
                                                    snapshot.data!.data![index].text.toString().trim(),
                                                    style: const TextStyle(
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 11,
                                                      letterSpacing:0.2,
                                                      color: Colors.black87,
                                                    ),
                                                    maxLines: 6,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text('${snapshot.data!.data![index].authorName.toString()},Uttrakhand',
                                              style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:13,
                                                  color: Colors.black),
                                            ),
                                        const SizedBox(height:5,),
                                        RatingBarIndicator(
                                          rating: double.tryParse(snapshot.data!.data![index].rating.toString()) ?? 0.0,
                                          itemBuilder: (context, index) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize:18.0,
                                          direction: Axis.horizontal,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
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
                DialogHelper.showAgentDialog(
                  context,
                      () => DialogHelper.sendWhatsAppMessage("Hello! I want to book an appointment."),
                      () => DialogHelper.makingPhoneCall(Consulation_Phone), // Replace with your call method
                );
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


Widget buildClickableServiceCard(String imagePath, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal:8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            width: 95,
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
            width: 90,
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
void openUrl({required String openingUrl}) async {
  var url = openingUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


