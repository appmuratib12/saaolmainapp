import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../DialogHelper.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../data/model/apiresponsemodel/CentersResponseData.dart';
import '../data/model/apiresponsemodel/NearestCenterResponseData.dart';
import '../data/network/BaseApiService.dart';
import 'GoogleMapDemoScreen.dart';

class NearCenterScreen extends StatefulWidget {
  final TextEditingController searchController;

  const NearCenterScreen({super.key, required this.searchController});

  @override
  State<NearCenterScreen> createState() => _NearCenterScreenState();
}

class _NearCenterScreenState extends State<NearCenterScreen> {
  String getLatitude = '';
  String getLongitude = '';
  String getPinCode = '';
  String? locationName;
  String? subLocality;
  bool isFiltering = false;
  List<dynamic> filteredHospitals = []; // To hold filtered results
  List<dynamic> hospitals = []; // Example list for filtering
  late Future<NearestCenterResponseData>? nearestCenterFuture;

  @override
  void initState() {
    super.initState();
    nearestCenterFuture = null; // initially null
    _loadCounter();
    widget.searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.searchController.removeListener(() {});
    super.dispose();
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

  void openUrl({required String openingUrl}) async {
    var url = openingUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      locationName = prefs.getString('locationName') ?? '';
      subLocality = prefs.getString('subLocality') ?? '';
      getLatitude = prefs.getString('lat') ?? '';
      getLongitude = prefs.getString('long') ?? '';
      getPinCode = prefs.getString('pinCode') ??
          prefs.getString(ApiConstants.PINCODE) ??
          '';
      print('LocationName --> $locationName');
      print('getLatLong --> $getLatitude , $getLongitude');
      print('LocationCODE --> $getPinCode');
      if (getLatitude.isNotEmpty &&
          getLongitude.isNotEmpty &&
          getPinCode.isNotEmpty) {
        nearestCenterFuture = getNearestCenters(
          latitude: double.parse(getLatitude),
          longitude: double.parse(getLongitude),
          radius: 10,
        );
      }
    });
  }

  Future<NearestCenterResponseData> getNearestCenters({
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    final url = Uri.parse(
      'https://saaol.org/saaolapp/api/locations/centers?latitude=$latitude&longitude=$longitude&radius=10',
    );
    final headers = {
      'Content-Type': 'application/json',
      'API-KEY': ApiConstants.apiKey,
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        return NearestCenterResponseData.fromJson(jsonBody);
      } else {
        throw Exception('Failed to load nearest centers');
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: GestureDetector(
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
                SizedBox(width:5),
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
        ),
        body: SingleChildScrollView(
          child:Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top:20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /*GestureDetector(
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
              ),*/
                /*const SizedBox(
                height: 30,
              ),*/
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
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
                          fontSize: 14,
                          color: Colors.black38,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.primaryColor,
                          size: 25,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
                        border: InputBorder.none,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Show clear icon only when there's input
                            if (widget.searchController.text.isNotEmpty)
                              IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  widget.searchController.clear();
                                  filterHospitals('');
                                  setState(() {}); // Refresh to hide the icon
                                },
                              ),
                            IconButton(
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
                          ],
                        ),
                      ),
                      onChanged: (value) {
                        filterHospitals(value);
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: 'FontPoppins',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: isFiltering
                      ? buildFilteredListView()
                      : buildNearestCenterListView(),
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget buildNearestCenterListView() {
    return FutureBuilder<NearestCenterResponseData>(
      future: nearestCenterFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 40,
                  color: AppColors.primaryDark,
                ),
                SizedBox(height: 16),
                Text(
                  'No Centers Found',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'FontPoppins',
                      color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'We couldn’t find any centers for your selected location.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: 'FontPoppins',
                  ),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.centers!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_off,
                  size: 40,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 12),
                Text(
                  'No centers found',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'FontPoppins',
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Please try again later or check your location settings.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ],
            ),
          );
        } else {
          final centers = snapshot.data!.centers!;
          return ListView.builder(
            itemCount: centers.length,
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
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
                          center.cityName ?? 'Unknown Center',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
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
                      center.cityAddr ?? 'No Address Available',
                      style: const TextStyle(
                        fontSize: 13.0,
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
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Expanded(child: Container()),
                        Text(
                          center.cityName.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FontPoppins',
                              fontSize: 14,
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
                                fontSize: 14,
                                color: Colors.black)),
                        Expanded(child: Container()),
                        Text(center.distanceText.toString(),
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
                        /* GestureDetector(
                          onTap: () {
                            DialogHelper.makingPhoneCall(snapshot
                                .data!.centers![index].phoneNo
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
                                  'Call now',
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryDark),
                                ),
                              ],
                            ),
                          ),
                        ),*/
                        GestureDetector(
                          onTap: () {
                            final rawNumbers =
                                snapshot.data!.centers![index].phoneNo ?? "";
                            final phoneNumbers = rawNumbers
                                .split(',')
                                .map((e) => e.trim())
                                .toList();

                            if (phoneNumbers.length == 1) {
                              DialogHelper.makingPhoneCall(phoneNumbers.first);
                            } else if (phoneNumbers.isNotEmpty) {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (context) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.phone_android,
                                            size: 30,
                                            color: AppColors.primaryDark),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Choose a number to call',
                                          style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Divider(height: 20),
                                        ...phoneNumbers.map((number) {
                                          return Card(
                                            color: Colors.grey[200],
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                            child: ListTile(
                                              leading: const Icon(Icons.call,
                                                  color: AppColors.primaryDark),
                                              title: Text(
                                                number.trim(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              trailing: const Icon(
                                                  Icons.chevron_right),
                                              onTap: () {
                                                Navigator.pop(context);
                                                DialogHelper.makingPhoneCall(
                                                    number);
                                              },
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                            width: 120,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone,
                                    color: AppColors.primaryDark, size: 15),
                                SizedBox(width: 6),
                                Text(
                                  'Call now',
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
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () async {
                            if (getLatitude.isEmpty && getLongitude.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Unable to get current location.')),
                              );
                              return;
                            }
                            String location = snapshot
                                .data!.centers![index].hmPincodeCoordinates
                                .toString();
                            String locationUrl =
                                "https://www.google.com/maps/dir/$getLatitude,$getLongitude/$location";
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
                                    fontSize: 12,
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
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 40,
                  color: AppColors.primaryDark,
                ),
                SizedBox(height: 16),
                Text(
                  'No Centers Found',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'FontPoppins',
                      color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'We couldn’t find any centers for your selected location.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: 'FontPoppins',
                  ),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_off,
                  size: 60,
                  color: Colors.grey,
                ),
                const SizedBox(height: 12),
                Text(
                  'No centers found',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Please try again later or check your location settings.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        } else {
          final centers = snapshot.data!.data!;
          return ListView.builder(
            itemCount: centers.length,
            shrinkWrap: true,
            physics:NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemBuilder: (context, index) {
              final center = centers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      center.cityName ?? 'Unknown Center',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        fontFamily: 'FontPoppins',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      center.cityAddr ?? 'No Address Available',
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
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
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Expanded(child: Container()),
                        Text(
                          center.stateName.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FontPoppins',
                              fontSize: 14,
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
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Expanded(child: Container()),
                        Text(
                          '${center.distance?.toStringAsFixed(2)}Km',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FontPoppins',
                              fontSize: 14,
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
                            final rawNumbers =
                                snapshot.data!.data![index].phoneNo ?? "";
                            final phoneNumbers = rawNumbers
                                .split(',')
                                .map((e) => e.trim())
                                .toList();

                            if (phoneNumbers.length == 1) {
                              DialogHelper.makingPhoneCall(phoneNumbers.first);
                            } else if (phoneNumbers.isNotEmpty) {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (context) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.phone_android,
                                            size: 30,
                                            color: AppColors.primaryDark),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Choose a number to call',
                                          style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Divider(height: 20),
                                        ...phoneNumbers.map((number) {
                                          return Card(
                                            color: Colors.grey[200],
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                            child: ListTile(
                                              leading: const Icon(Icons.call,
                                                  color: AppColors.primaryDark),
                                              title: Text(
                                                number.trim(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              trailing: const Icon(
                                                  Icons.chevron_right),
                                              onTap: () {
                                                Navigator.pop(context);
                                                DialogHelper.makingPhoneCall(
                                                    number);
                                              },
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                            width: 120,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone,
                                    color: AppColors.primaryDark, size: 15),
                                SizedBox(width: 6),
                                Text(
                                  'Call now',
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
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () async {
                            if (getLatitude.isEmpty && getLongitude.isEmpty) {
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
                                "https://www.google.com/maps/dir/$getLatitude,$getLongitude/$location";
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

class FadeRoute1 extends PageRouteBuilder {
  final Widget page;

  FadeRoute1({required this.page})
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

