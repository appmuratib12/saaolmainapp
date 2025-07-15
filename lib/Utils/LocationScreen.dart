import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
            padding:
                const EdgeInsets.only(top: 60, left: 15, right: 15, bottom: 20),
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
                  'This app uses your location to provide local features and content near you.',
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
                      'Continue',
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

Future<Position?> _determinePosition(BuildContext context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Navigator.pop(context);
    return null;
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Navigator.pop(context);
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Navigator.pop(context);
    if (Platform.isIOS) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          title: const Row(
            children: [
              Icon(Icons.location_on, color: AppColors.primaryColor),
              SizedBox(width: 4),
              Text(
                "Location Permission Needed",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'FontPoppins',
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          content: const Text(
            "We use your location to deliver personalized content and nearby services. Please enable location access in Settings to enjoy full app functionality.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              fontFamily: 'FontPoppins',
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Continue without",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  fontFamily: 'FontPoppins',
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Geolocator.openAppSettings();
                Navigator.pop(context);
              },
              child: const Text(
                "Open Settings",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  fontFamily: 'FontPoppins',
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return null;
  }
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

/*Future<Position> _determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Navigator.pop(context);
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Navigator.pop(context);
      await Geolocator.openLocationSettings();
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Navigator.pop(context);
    if (Platform.isIOS) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          title: const Row(
            children: [
              Icon(Icons.location_on, color: AppColors.primaryColor),
              SizedBox(width: 4),
              Text(
                "Location Permission Needed",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'FontPoppins',
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          content: const Text(
            "We use your location to deliver personalized content and nearby services. Please enable location access in Settings to enjoy full app functionality.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              fontFamily: 'FontPoppins',
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Maybe Later",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  fontFamily: 'FontPoppins',
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.pop(context);
              },
              child: const Text(
                "Open Settings",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  fontFamily: 'FontPoppins',
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      openAppSettings();
    }
    return Future.error('Location permissions are permanently denied.');
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}*/

/*void fetchLocation(BuildContext context) async {
  try {
    showLoadingDialog(context);

    Position position = await _determinePosition(context);
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

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(ApiConstants.PINCODE, pincode ?? 'Unknown');
      sharedPreferences.setString('locationName', locationName ?? 'Unknown');
      sharedPreferences.setString('subLocality', subLocality ?? 'Unknown');
      sharedPreferences.setString('lat', position.latitude.toStringAsFixed(6));
      sharedPreferences.setString(
          'long', position.longitude.toStringAsFixed(6));
      print('PincodeStore: ${placemark.postalCode}');
      print('PincodeStoring: ${position.latitude},${position.longitude}');

      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) => const HomePage(initialIndex: 0)),
      );
    } else {
      showSnackbar(context, 'No placemarks found.');
    }
  } catch (e) {
    print("${e}");
    showSnackbar(context, 'Error fetching location: $e');
  }
}*/

void fetchLocation(BuildContext context) async {
  try {
    showLoadingDialog(context);
    Position? position;
    if (Platform.isIOS) {
      try {
        position = await _determinePosition(context);
      } catch (e) {
        print("iOS Location not granted: $e");
      }
    } else {
      position = await _determinePosition(context);
      print('Latitude: ${position!.latitude}, Longitude: ${position.longitude}');
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (position != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        sharedPreferences.setString(ApiConstants.PINCODE, placemark.postalCode ?? 'Unknown');
        sharedPreferences.setString('locationName', placemark.locality ?? 'Unknown');
        sharedPreferences.setString('subLocality', placemark.subLocality ?? 'Unknown');
        sharedPreferences.setString('lat', position.latitude.toStringAsFixed(6));
        sharedPreferences.setString('long', position.longitude.toStringAsFixed(6));
      }
    } else if (Platform.isIOS) {
      // iOS fallback values
      sharedPreferences.setString(ApiConstants.PINCODE, 'Unknown');
      sharedPreferences.setString('locationName', 'Location not granted');
      sharedPreferences.setString('subLocality', 'Unknown');
      sharedPreferences.setString('lat', '');
      sharedPreferences.setString('long', '');
    }
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => const HomePage(initialIndex: 0)),
    );
  } catch (e) {
    Navigator.pop(context); // close loading
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
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
                SizedBox(height: 20),
                Icon(Icons.navigation, size: 30, color: AppColors.primaryColor),
                SizedBox(height: 10),
                Text(
                  "Fetching your location...",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'FontPoppins',
                      color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
