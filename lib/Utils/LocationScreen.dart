import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saaolapp/constant/ApiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_colors.dart';
import 'MyHomePageScreen.dart';


class ShareLocationScreen extends StatefulWidget {
  const ShareLocationScreen({super.key});

  @override
  State<ShareLocationScreen> createState() => _ShareLocationScreenState();
}


class _ShareLocationScreenState extends State<ShareLocationScreen> {

  late SharedPreferences sharedPreferences;

  // void fetchLocation(BuildContext context) async {
  //   try {
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         showSnackbar(context, 'Location permission denied. Please allow it to continue.');
  //         return;
  //       }
  //     }
  //     if (permission == LocationPermission.deniedForever) {
  //       showSnackbar(context, 'Location permission permanently denied. Enable it from settings.');
  //       await Geolocator.openLocationSettings();
  //       return;
  //     }
  //     showLoadingDialog(context);
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //       timeLimit: const Duration(seconds:30),
  //     );
  //     if (position == null) {
  //       showSnackbar(context, "Could not get location. Try again.");
  //       return;
  //     }
  //
  //     print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );
  //
  //     if (placemarks.isNotEmpty) {
  //       Placemark placemark = placemarks.first;
  //       String? locationName = placemark.locality;
  //       String? subLocality = placemark.subLocality;
  //       String? pincode = placemark.postalCode;
  //
  //       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //       sharedPreferences.setString(ApiConstants.PINCODE, pincode ?? 'Unknown');
  //       sharedPreferences.setString('locationName', locationName ?? 'Unknown');
  //       sharedPreferences.setString('subLocality', subLocality ?? 'Unknown');
  //       sharedPreferences.setString('lat', position.latitude.toStringAsFixed(6));
  //       sharedPreferences.setString('long', position.longitude.toStringAsFixed(6));
  //       print('PincodeStore: ${placemark.postalCode}');
  //       print('PincodeStoring: ${position.latitude},${position.longitude}');
  //
  //       Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const HomePage(initialIndex: 0)));
  //     } else {
  //       showSnackbar(context, 'No placemarks found.');
  //     }
  //   } catch (e) {
  //     showSnackbar(context, 'Error fetching location: $e');
  //   }
  // }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 15, right: 15, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/location.jpg',
                  fit: BoxFit.fill,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Please Share Your Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'FontPoppins',
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'We need your location to offer you the best services tailored to your area.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'FontPoppins',
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      fetchLocation(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    ),
  );
}
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    openAppSettings();
    // SmartDialog.dismiss();
    return Future.error('Location permissions are permanently denied.');
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 30));
}
void fetchLocation(BuildContext context) async {
  try {
    showLoadingDialog(context);

    Position position = await _determinePosition(); // ⬅️ Uses your permission-handling method

    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String? locationName = placemark.locality;
      String? subLocality = placemark.subLocality;
      String? pincode = placemark.postalCode;

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(ApiConstants.PINCODE, pincode ?? 'Unknown');
      sharedPreferences.setString('locationName', locationName ?? 'Unknown');
      sharedPreferences.setString('subLocality', subLocality ?? 'Unknown');
      sharedPreferences.setString('lat', position.latitude.toStringAsFixed(6));
      sharedPreferences.setString('long', position.longitude.toStringAsFixed(6));
      print('PincodeStore: ${placemark.postalCode}');
      print('PincodeStoring: ${position.latitude},${position.longitude}');

      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const HomePage(initialIndex: 0)),
      );
    } else {
      showSnackbar(context, 'No placemarks found.');
    }
  } catch (e) {
    print("${e}");
    showSnackbar(context, 'Error fetching location: $e');
  }
}
void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
                SizedBox(height: 20),
                Icon(Icons.navigation, size: 30, color: AppColors.primaryColor),
                SizedBox(height: 10),
                Text(
                  "Fetching your location...",
                  style: TextStyle(fontSize:13,
                      fontWeight: FontWeight.w500,fontFamily:'FontPoppins',
                      color:Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}