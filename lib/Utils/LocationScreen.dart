import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/Utils/MyHomePageScreen.dart';
import 'package:saaoldemo/constant/ApiConstants.dart';
import '../common/app_colors.dart';
import 'ManuallyLocationScreen.dart';

class ShareLocationScreen extends StatefulWidget {
  const ShareLocationScreen({super.key});

  @override
  State<ShareLocationScreen> createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {

  late SharedPreferences sharedPreferences;

  Future<void> _requestLocationPermission() async {
    PermissionStatus permission = await Permission.location.request();
    if (permission.isGranted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Fluttertoast.showToast(msg: 'Location: LAT: ${position.latitude}, LNG: ${position.longitude}');
    } else if (permission.isDenied || permission.isPermanentlyDenied) {
      Fluttertoast.showToast(msg: 'Location permission denied.');
    }
  }


  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }
    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      throw Exception('Location permissions are permanently denied.');
    }
    // Get the current location
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void fetchLocation() async {
    try {
      Position position = await getCurrentLocation();
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String? locationName = placemark.locality; // City or locality name
        String? subLocality = placemark.subLocality; // More specific location
        String? pincode = placemark.postalCode; // Pincode
        sharedPreferences = await SharedPreferences.getInstance();
        if (pincode != null) {
          await sharedPreferences.setString(ApiConstants.PINCODE, pincode);
          await sharedPreferences.setString('locationName', locationName.toString());
          await sharedPreferences.setString('subLocality', subLocality.toString());
          await sharedPreferences.setString('lat',position.latitude.toString());
          await sharedPreferences.setString('long',position.longitude.toString());
          print('Pincode stored in SharedPreferences: $pincode');
          print('Location Name: $locationName');
          print('Sub Locality: $subLocality');
          print('Pincode: $pincode');
          Navigator.push(context,
            CupertinoPageRoute(
                builder: (context) => const HomePage(initialIndex:0)),
          );

        }
      } else {
        print('No placemarks found.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background container
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey[200]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Centered content
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage('assets/images/location.jpg'),
                    fit: BoxFit.fill,
                    height: 410,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const SizedBox(height: 20),
                  // Main text
                  const Text(
                    'Please share your location',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Sub text
                  const Text(
                    'We need your delivery location to provide\nbetter services',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        //_requestLocationPermission();
                        fetchLocation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      icon: const Icon(
                        Icons.my_location,
                        size: 20,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Enable device location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'FontPoppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const SearchBarScreen()),
                        );
                        Fluttertoast.showToast(msg: 'Click');

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: const BorderSide(
                                color: AppColors.primaryColor, width: 0.6)),
                      ),
                      icon: const Icon(
                        Icons.search_outlined,
                        size: 25,
                        color: AppColors.primaryColor,
                      ),
                      label: const Text(
                        'Enter location manually',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'FontPoppins',
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
