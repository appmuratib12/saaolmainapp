import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saaoldemo/common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../data/model/apiresponsemodel/NearestCenterResponseData.dart';
import '../data/network/BaseApiService.dart';
import 'ManuallyLocationScreen.dart';

class NearByCenterScreen extends StatefulWidget {
  const NearByCenterScreen({super.key});

  @override
  State<NearByCenterScreen> createState() => _NearByCenterScreenState();
}

class _NearByCenterScreenState extends State<NearByCenterScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(28.4829, 77.1640);
  final Set<Marker> _markers = {}; // Set to hold markers dynamically
  String savedLocation = 'No location saved';
  String getCityName = '';
  String getPinCode = '';
  String coordinates = '';
  String nearByCentersName = '';
  String address = '';


  @override
  void initState() {
    super.initState();
    _loadSavedLocation();
    _initializeMarkers();
  }

  @override
  void dispose() {
    mapController.dispose(); // Dispose the controller to avoid memory leaks
    super.dispose();
  }

  void _initializeMarkers() {
    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId('initialMarker'),
        position: _center,
        infoWindow: const InfoWindow(
          title: 'Default Location',
          snippet: 'This is the default location',
        ),
      ));
    });
  }

  void _loadSavedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? location = prefs.getString('saved_location');
    setState(() {
      savedLocation = location ?? 'No location saved';
      getCityName = (prefs.getString('cityName') ?? '');
      getPinCode = prefs.getString('pinCode') ??
          prefs.getString(ApiConstants.PINCODE) ??
          '';
      print('NearestCenterPinCode:$getPinCode');
    });
  }

  Future<Uint8List?> _getMarkerIcon(String assetPath, int width) async {
    try {
      ByteData byteData = await rootBundle.load(assetPath);
      final codec = await instantiateImageCodec(
        byteData.buffer.asUint8List(),
        targetWidth: width,
      );
      final frame = await codec.getNextFrame();
      final data = await frame.image.toByteData(format: ImageByteFormat.png);
      return data?.buffer.asUint8List();
    } catch (e) {
      print("Error loading marker icon: $e");
      return null;
    }
  }

  // Function to set the marker on the map and animate the camera
  Future<void> _setSelectedLocation(
      LatLng selectedLocation, String centerName, String address) async {
    Uint8List? customMarkerIcon =
        await _getMarkerIcon('assets/icons/location_logo.png', 150);

    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId(centerName),
          position: selectedLocation,
          infoWindow: InfoWindow(
            title: centerName,
            snippet: address,
          ),
          icon: customMarkerIcon != null
              ? BitmapDescriptor.fromBytes(customMarkerIcon)
              : BitmapDescriptor.defaultMarker,
        ),
      );

      mapController.animateCamera(
        CameraUpdate.newLatLng(selectedLocation),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor:AppColors.primaryColor,
        title: const Text(
          'Nearby Centers',
          style: TextStyle(
            fontFamily: 'FontPoppins',
            fontSize: 18,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  getCityName,
                  style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchBarScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        getPinCode,
                        style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Display the Google Map
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12,
              ),
              markers: _markers,
            ),
          ),
          Expanded(
            child: FutureBuilder<NearestCenterResponseData>(
              future: BaseApiService().getNearestCenter(getPinCode, '10'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.centers!.length,
                    itemBuilder: (context, index) {
                      // Parse coordinates from the API response
                      String coordinatesString = snapshot
                          .data!.centers![index].hmPincodeCoordinates
                          .toString();
                      List<String> latLng = coordinatesString.split(',');
                      LatLng centerCoordinates = LatLng(
                        double.parse(latLng[0].trim()), // Latitude
                        double.parse(latLng[1].trim()), // Longitude
                      );

                      String centerName =
                          snapshot.data!.centers![index].centerName ??
                              'Unknown Center';
                      String centerAddress =
                          snapshot.data!.centers![index].address1 ??
                              'No Address';

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 8),
                        child: Container(
                          constraints: const BoxConstraints(
                            minHeight:150, // Set the minimum height here
                          ),
                          decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.white,
                                width:1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  centerName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(snapshot.data!.centers![index].distanceText.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      height: 15,
                                      width: 0.8,
                                      color: Colors.grey.withOpacity(0.6),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        centerAddress,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  height: 36,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _setSelectedLocation(
                                        centerCoordinates,
                                        centerName,
                                        centerAddress,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryDark,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'View Center',
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(
                  child: Container(
                    width: 60, // Set custom width
                    height:60, // Set custom height
                    decoration: BoxDecoration(
                      color:AppColors.primaryColor.withOpacity(0.1), // Background color for the progress indicator
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor, // Custom color
                        strokeWidth:6, // Set custom stroke width
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
