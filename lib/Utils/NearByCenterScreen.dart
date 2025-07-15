import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:saaolapp/data/network/BaseApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../DialogHelper.dart';
import '../common/app_colors.dart';
import '../constant/ApiConstants.dart';
import '../data/model/apiresponsemodel/NearestCenterResponseData.dart';

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
  String getSubLocality = '';
  String getPinCode = '';
  String coordinates = '';
  String nearByCentersName = '';
  String address = '';
  String getLatitude = '';
  String getLongitude = '';
  late Future<NearestCenterResponseData>? nearestCenterFuture;

  

  @override
  void initState() {
    super.initState();
    _loadSavedLocation();
    _initializeMarkers();
    nearestCenterFuture = null;
  }

  @override
  void dispose() {
    mapController.dispose();
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
    String? selectedLat = prefs.getDouble('selected_latitude')?.toString();
    String? selectedLng = prefs.getDouble('selected_longitude')?.toString();
    String defaultLat = prefs.getString('lat') ?? '';
    String defaultLng = prefs.getString('long') ?? '';

    setState(() {
      savedLocation = location ?? 'No location saved';
      getCityName = prefs.getString('cityName') ?? '';
      getCityName = prefs.getString('locationName') ?? '';
      getSubLocality = prefs.getString('subLocality') ?? '';
      getLatitude = selectedLat ?? defaultLat;
      getLongitude = selectedLng ?? defaultLng;
      getPinCode = prefs.getString('pinCode') ?? prefs.getString(ApiConstants.PINCODE) ?? '';
      if (getLatitude.isNotEmpty && getLongitude.isNotEmpty && getPinCode.isNotEmpty) {
        nearestCenterFuture = BaseApiService().getNearestCenters(
          latitude: double.tryParse(getLatitude) ?? 0.0,
          longitude: double.tryParse(getLongitude) ?? 0.0,
          radius: 10,
        );
      }
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

  void openUrl({required String openingUrl}) async {
    var url = openingUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
            fontSize: 16,
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
      ),
      body: Column(
        children: [
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

          Expanded(child: FutureBuilder<NearestCenterResponseData>(
            future:nearestCenterFuture,
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
              } else if (!snapshot.hasData || snapshot.data!.centers == null || snapshot.data!.centers!.isEmpty) {
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
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.centers!.length,
                  itemBuilder: (context, index) {
                    String coordinatesString = snapshot
                        .data!.centers![index].hmPincodeCoordinates
                        .toString();
                    List<String> latLng = coordinatesString.split(',');
                    LatLng centerCoordinates = LatLng(
                      double.parse(latLng[0].trim()), // Latitude
                      double.parse(latLng[1].trim()), // Longitude
                    );

                    String centerName =
                        snapshot.data!.centers![index].cityName ??
                            'Unknown Center';
                    String centerAddress =
                        snapshot.data!.centers![index].cityAddr ??
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
                          border: Border.all(color: Colors.white, width:1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Saaol $centerName Center',
                                style: const TextStyle(
                                  fontSize:14,
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
                                  Text(
                                    snapshot.data!.centers![index].distanceText.toString(),
                                    style: const TextStyle(
                                      fontSize: 13,
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
                                        fontSize: 13,
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
                                    _setSelectedLocation(centerCoordinates, centerName, centerAddress);
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
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (snapshot.data!.centers![index].phoneNo != null &&
                                      snapshot.data!.centers![index].phoneNo!.trim().isNotEmpty)
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          final rawNumbers =
                                              snapshot.data!.centers![index].phoneNo ?? "";
                                          final phoneNumbers = rawNumbers
                                              .split(',')
                                              .map((e) => e.trim())
                                              .toList();
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
                                        /*  DialogHelper.makingPhoneCall(
                                            snapshot.data!.centers![index].phoneNo.toString(),
                                          );*/
                                        },
                                        icon: const Icon(Icons.call, color: AppColors.primaryDark),
                                        label: const Text(
                                          'Call',
                                          style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
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
                                    ),
                                  if (snapshot.data!.centers![index].phoneNo != null &&
                                      snapshot.data!.centers![index].phoneNo!.trim().isNotEmpty)
                                    const SizedBox(width: 10),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        if (getLatitude.isEmpty && getLongitude.isEmpty) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Unable to get current location.'),
                                            ),
                                          );
                                          return;
                                        }

                                        String location = snapshot.data!.centers![index].hmPincodeCoordinates.toString();
                                        String locationUrl =
                                            "https://www.google.com/maps/dir/$getLatitude,$getLongitude/$location";
                                        openUrl(openingUrl: locationUrl);
                                      },
                                      icon: const Icon(Icons.directions, color: AppColors.primaryDark),
                                      label: const Text(
                                        'Directions',
                                        style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
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
                                  ),
                                ],
                              ),
                            ],
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
        ],
      ),
    );
  }
}

