import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/constant/ApiConstants.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/CentersResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/NearestCenterResponseData.dart';
import 'package:saaoldemo/data/network/BaseApiService.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/app_colors.dart';
import 'GoogleMapDemoScreen.dart';

class SearchScreen extends StatefulWidget {
  final TextEditingController searchController;

  const SearchScreen({super.key, required this.searchController});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
/*  final List<Map<String, String>> hospitals = [];

  List<Map<String, String>> filteredHospitals = [];*/



  Position? position;
  String getPinCode = '';
  String? locationName;
  String? subLocality;
  String? latitude;
  String? longitude;
  bool isFiltering = false;
  List<dynamic> filteredHospitals = []; // To hold filtered results
  List<dynamic> hospitals = []; // Example list for filtering

  @override
  void initState() {
    super.initState();
    filteredHospitals = hospitals; // Start with all hospitals showing
    _loadCounter();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {}); // Trigger a rebuild once the position is fetched
  }

  void filterHospitals(String query) {
    setState(() {
      if (query.isEmpty) {
        isFiltering = false; // Reset to default view
        filteredHospitals = [];
      } else {
        isFiltering = true; // Switch to filtered view
        filteredHospitals = hospitals
            .where((hospital) =>
                hospital.centerName!
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                hospital.address1!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  /* void filterHospitals(String query) {
    setState(() {
      filteredHospitals = hospitals
          .where((hospital) =>
              hospital['title']!.toLowerCase().contains(query.toLowerCase()) ||
              hospital['address']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }*/


  void openUrl({required String openingUrl}) async {
    var url = openingUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _makingPhoneCall(String phoneNumber) async {
    var url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int calculateDistance(String centerCoordinates) {
    try {
      final coords = centerCoordinates.split(',');
      final centerLatitude = double.parse(coords[0]);
      final centerLongitude = double.parse(coords[1]);
      double distanceInMeters = Geolocator.distanceBetween(
        position!.latitude,
        position!.longitude,
        centerLatitude,
        centerLongitude,
      );
      return (distanceInMeters / 1000).toInt();
    } catch (e) {
      print('Error parsing coordinates: $e');
      return 0; // Return 0 in case of error
    }
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
     // getPinCode = (prefs.getString(ApiConstants.PINCODE) ?? '');
      locationName = (prefs.getString('locationName') ?? '');
      subLocality = (prefs.getString('subLocality') ?? '');
      latitude = (prefs.getString('lat') ?? '');
      longitude = (prefs.getString('long') ?? '');
      getPinCode = prefs.getString('pinCode') ?? prefs.getString(ApiConstants.PINCODE) ?? '';
      print('LocationName-->$locationName');
      print('LocationCODE-->$getPinCode');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 16,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Light black shadow
                    blurRadius: 6, // Softening the shadow
                    offset:
                        const Offset(0, 2), // Horizontal and Vertical position
                  ),
                ],
              ),
              child: Container(
                height: 45.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextField(
                  controller: widget.searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Find Our nearest centers...',
                    hintStyle: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black38,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                      size: 25,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.my_location,
                        color: AppColors.primaryDark,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const MapScreen2()),
                        );
                      },
                    ),
                  ),
                  onChanged: (value) {
                    filterHospitals(value); // Call the filter method
                  },
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: isFiltering
                      ? buildFilteredListView()
                      : buildNearestCenterListView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNearestCenterListView() {
    return FutureBuilder<NearestCenterResponseData>(
      future: BaseApiService().getNearestCenter(getPinCode, '10'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red)),
          );
        } else if (!snapshot.hasData || snapshot.data!.centers!.isEmpty) {
          return const Center(child: Text('No centers found.'));
        } else {
          final centers = snapshot.data!.centers!;
          return ListView.builder(
            itemCount: centers.length,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemBuilder: (context, index) {
              final center = centers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${center.centerName ?? 'Unknown Center'},',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'FontPoppins',
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      center.address1 ?? 'No Address Available',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                        fontFamily: 'FontPoppins',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primaryDark,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Location',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        Expanded(child: Container()),
                        Text(
                          center.city.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/icons/distance_icon.png',
                            color: AppColors.primaryDark,
                            height: 20,
                            width: 20),
                        const SizedBox(width: 10),
                        const Text('Distance',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                color: Colors.black)),
                        Expanded(child: Container()),
                        Text(
                            position == null
                                ? '0 km'
                                : '${calculateDistance(center.hmPincodeCoordinates.toString())} km',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                color: Colors.black)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _makingPhoneCall(snapshot
                                .data!.centers![index].contactNo
                                .toString());
                          },
                          child: Container(
                            width: 120,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone,
                                    color: AppColors.primaryDark, size: 15),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'Contact Us',
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryDark),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () async {
                            if (position == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Unable to get current location.')),
                              );
                              return;
                            }

                            String location = snapshot
                                .data!.centers![index].hmPincodeCoordinates
                                .toString();
                            String locationUrl =
                                "https://www.google.com/maps/dir/${position!.latitude},${position!.longitude}/$location";
                            openUrl(openingUrl: locationUrl);
                          },
                          child: Container(
                            width: 120,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.directions,
                                    color: AppColors.primaryDark, size: 15),
                                SizedBox(width: 6),
                                Text(
                                  'Direction',
                                  style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                      height: 24.0,
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget buildFilteredListView() {
    String saveCenterName = widget.searchController.text.toString();
    return FutureBuilder<CentersResponseData>(
      future: BaseApiService().getCenterData(saveCenterName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red)),
          );
        } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
          return const Center(child: Text('No centers found.'));
        } else {
          final centers = snapshot.data!.data!;
          return ListView.builder(
            itemCount: centers.length,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemBuilder: (context, index) {
              final center = centers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${center.centerName ?? 'Unknown Center'},',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'FontPoppins',
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          snapshot.data!.data![index].pincode.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'FontPoppins',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      center.address1 ?? 'No Address Available',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                        fontFamily: 'FontPoppins',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primaryDark,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Location',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        Expanded(child: Container()),
                        Text(
                          center.state.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/distance_icon.png',
                          color: AppColors.primaryDark,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Distance',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        Expanded(child: Container()),
                        Text(
                          '${calculateDistance(center.hmPincodeCoordinates.toString())} km',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _makingPhoneCall(snapshot
                                .data!.data![index].contactNo
                                .toString());
                          },
                          child: Container(
                            width: 120,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone,
                                    color: AppColors.primaryDark, size: 15),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'Contact Us',
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryDark),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () async {
                            if (position == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Unable to get current location.')),
                              );
                              return;
                            }

                            String location = snapshot
                                .data!.data![index].hmPincodeCoordinates
                                .toString();
                            String locationUrl =
                                "https://www.google.com/maps/dir/${position!.latitude},${position!.longitude}/$location";
                            openUrl(openingUrl: locationUrl);
                          },
                          child: Container(
                            width: 120,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.directions,
                                    color: AppColors.primaryDark, size: 15),
                                SizedBox(width: 6),
                                Text(
                                  'Direction',
                                  style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                      height: 24.0,
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
