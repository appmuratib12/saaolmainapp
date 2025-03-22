import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import '../common/app_colors.dart';

final List<Map<String, dynamic>> saaolHeartCenters = [
  {'name': 'Nirman Vihar', 'lat': 28.6362211, 'lng': 77.2922332},
  {'name': 'Lajpat Nagar', 'lat': 28.5683786, 'lng': 77.2416464},
  {'name': 'Pitampur', 'lat': 28.6930443, 'lng': 77.1350949},
  {'name': 'SAAOL Karnataka Rajajinagar', 'lat': 13.0066617, 'lng': 77.5449837},
  {'name': 'Karol Bagh', 'lat': 28.6354261, 'lng': 77.1856762},
  {'name': 'Uttar Pradesh Meerut', 'lat': 29.0188653, 'lng': 77.7680952},
  {'name': 'Jharkhand  Ranchi', 'lat': 23.3780353, 'lng': 85.3187914},
  {'name': 'Rajasthan Jaipur', 'lat': 26.8573411, 'lng': 75.7865653},
  {'name': 'Uttar Pradesh Noida', 'lat': 28.5875317, 'lng': 77.3841197},
  {'name': 'Tamil Nadu Kilpauk', 'lat': 13.0856795, 'lng': 80.2452474},
  {'name': 'Tamil Nadu Mambalam', 'lat': 13.0350433, 'lng': 80.2217267},
  {'name': 'DLF', 'lat': 28.4550173, 'lng': 77.1837006},
  {'name': 'Telangana  Hyderabad', 'lat': 17.4006724, 'lng': 78.4881736},
  {'name': 'Mumbai Vile Parle', 'lat': 19.1007377, 'lng': 72.8484952},
  {'name': 'Mumbai Vikhroli', 'lat': 19.1025427, 'lng': 72.9254307},
  {'name': 'Mumbai Virar', 'lat': 19.4344289, 'lng': 72.9224329},
  {'name': 'Mumbai Borivali', 'lat': 19.2326877, 'lng': 72.7983705},
  {'name': 'Mumbai Vashi', 'lat': 19.0793547, 'lng': 72.9992013},
  {'name': 'Mumbai Dadar', 'lat': 19.0147962, 'lng': 72.8454534},
  {'name': 'Karnataka Hebbal', 'lat': 13.0487446, 'lng': 77.5923297},
  {'name': 'Karnataka Kundalahalli', 'lat': 12.9566294, 'lng': 77.7046823},
  {'name': 'Madhya Pradesh Indore', 'lat': 22.7368996, 'lng': 75.8823563},
  {'name': 'Uttarakhand Dehradun', 'lat': 30.3267294, 'lng': 77.9995589},
  {'name': 'Uttar Pradesh Agra', 'lat': 27.2251305, 'lng': 78.0024134},
  {'name': 'Uttar Pradesh Bulandshahr', 'lat': 28.4302371, 'lng': 77.8595963},
  {'name': 'Uttar Pradesh Bareilly', 'lat': 28.4422629, 'lng': 79.4422593},
  {'name': 'Rajasthan Kota', 'lat': 25.1551679, 'lng': 75.8272482},
  {'name': 'Uttar Pradesh Bareilly', 'lat': 28.4422629, 'lng': 79.4422593},
  {'name': 'Uttar Pradesh Muzaffarnagar', 'lat': 29.4722225, 'lng': 77.7223162},
  {'name': 'Rajasthan Bikaner', 'lat': 28.2165605, 'lng': 73.1349605},
  {'name': 'Haryana Yamuna Nagar', 'lat': 30.1014803, 'lng': 77.2749964},
  {'name': 'Punjab Ludhiana', 'lat': 30.9058885, 'lng': 75.8359645},
  {'name': 'Punjab Mohali', 'lat': 30.7264274, 'lng': 76.7076768},
  {'name': 'Bihar Bhagalpur', 'lat': 25.2560821, 'lng': 86.9849308},
  {'name': 'Haryana Ambala', 'lat': 30.377589, 'lng': 76.860565},
  {'name': 'Bihar Bhagalpur', 'lat': 25.2560821, 'lng': 86.9849308},
  {'name': 'Bihar Muzaffarpur', 'lat': 26.1517238, 'lng': 85.4117608},
  {'name': 'Bihar Patna', 'lat': 25.6271433, 'lng': 85.1103291},
  {'name': 'Bihar Muzaffarpur', 'lat': 26.1517238, 'lng': 85.4117608},
  {'name': 'Madhya Pradesh Bhopal', 'lat': 23.1246919, 'lng': 77.4128193},
  {
    'name': 'Maharashtra Nagpur Vyankatesh Nagar',
    'lat': 21.0995693,
    'lng': 79.0673302
  },
  {'name': 'Maharashtra Jalgaon', 'lat': 21.0119747, 'lng': 75.5451379},
  {'name': 'Maharashtra Nashik', 'lat': 19.98462, 'lng': 73.7360175},
  {'name': 'Kerala Kozhikode', 'lat': 11.315009, 'lng': 75.7574989},
  {'name': 'Karnataka Belgavi', 'lat': 15.8763289, 'lng': 74.5023819},
  {'name': 'Tamil Nadu Coimbatore', 'lat': 11.0104033, 'lng': 76.9499028},
  {'name': 'West Bengal Asansol', 'lat': 23.705801, 'lng': 86.9098159},
  {'name': 'West Bengal Siliguri', 'lat': 26.7232775, 'lng': 88.4258483},
  {'name': 'Assam Guwahati', 'lat': 26.16363, 'lng': 91.7611838},
  {'name': 'Andhra Pradesh Vijaywada', 'lat': 16.5098886, 'lng': 80.6354665},
  {'name': 'Andhra Pradesh Vizag', 'lat': 17.7121136, 'lng': 83.3121281},
  {'name': 'Bihar Purnia', 'lat': 25.7774797, 'lng': 87.4950586},
  {'name': 'Chhattisgarh Raipur', 'lat': 21.2329892, 'lng': 81.6582994},
  {'name': 'Chhattisgarh Bhilai', 'lat': 21.2096036, 'lng': 81.3124341},
  {'name': 'Chhattisgarh Bilaspur', 'lat': 22.0808325, 'lng': 82.0516102},
  {'name': 'Gujrat Ahmedabad', 'lat': 22.9974387, 'lng': 72.5107843},
  {'name': 'Gujrat Anand', 'lat': 22.5698599, 'lng': 72.9637728},
  {'name': 'Gujrat Vadodara', 'lat': 22.3008241, 'lng': 73.1733127},
  {'name': 'Gujrat Vapi', 'lat': 20.370056, 'lng': 73.0641396},
  {'name': 'Gujrat Rajkot', 'lat': 22.2964051, 'lng': 70.7941564},
  {'name': 'Gujrat Surat', 'lat': 21.1807255, 'lng': 72.8184548},
  {'name': 'Goa', 'lat': 15.6120672, 'lng': 73.8566087},
  {'name': 'Haryana Karnal', 'lat': 29.6386837, 'lng': 77.0794705},
  {'name': 'Haryana Rohtak', 'lat': 28.9034473, 'lng': 76.5719414},
  {'name': 'Haryana Hisar', 'lat': 29.1235418, 'lng': 75.7051647},
  {'name': 'Haryana Sirsa', 'lat': 29.4305507, 'lng': 74.9208772},
  {'name': 'Jharkhand Jamshedpur', 'lat': 22.7824121, 'lng': 86.1599149},
  {'name': 'Jharkhand Dhanbad', 'lat': 23.7890996, 'lng': 86.4946007},
  {'name': 'Maharashtra Thane', 'lat': 19.1900019, 'lng': 72.9682017},
  {'name': 'Maharashtra Panvel', 'lat': 19.000914, 'lng': 73.2057595},
  {'name': 'Maharashtra Hadapsar Pune', 'lat': 18.5149325, 'lng': 73.9261587},
  {'name': 'Maharashtra Solapur', 'lat': 17.6730444, 'lng': 75.9071272},
  {'name': 'Maharashtra Kalyan', 'lat': 19.2527132, 'lng': 73.1290596},
  {'name': 'Maharashtra Pimpri Chinchwad', 'lat': 18.5883095, 'lng': 73.800734},
  {'name': 'Maharashtra Aurangabad', 'lat': 19.8756639, 'lng': 75.3393162},
  {'name': 'Odisha Bhubaneswar', 'lat': 20.3081, 'lng': 85.8255855},
  {'name': 'Punjab Amritsar', 'lat': 31.6427636, 'lng': 74.8565613},
  {'name': 'Punjab Patiala', 'lat': 30.2896414, 'lng': 76.3405733},
  {'name': 'Punjab Jalandhar', 'lat': 31.3271102, 'lng': 75.5917092},
  {'name': 'Madhya Pradesh Gwalior', 'lat': 26.2208223, 'lng': 78.2077368},
  {'name': 'Madhya Pradesh Jabalpur', 'lat': 23.2103329, 'lng': 79.8856824},
  {'name': 'Punjab Hoshiarpur', 'lat': 31.4695584, 'lng': 75.911483},
  {'name': 'Punjab Bhatinda', 'lat': 30.1738414, 'lng': 74.8974925},
  {'name': 'Punjab Firozpur', 'lat': 30.9939928, 'lng': 74.6166192},
  {'name': 'Rajasthan Ajmer', 'lat': 26.4573487, 'lng': 74.6458987},
  {'name': 'Rajasthan Jodhpur', 'lat': 26.1563518, 'lng': 72.9814877},
  {'name': 'Rajasthan Hanumangarh', 'lat': 29.6344136, 'lng': 74.2531465},
  {'name': 'Rajasthan Udaipur', 'lat': 24.598284, 'lng': 73.7242486},
  {'name': 'Uttarakhand Haldwani', 'lat': 29.1520637, 'lng': 79.605288},
  {'name': 'Uttarakhand Rudrpur', 'lat': 29.0087308, 'lng': 79.391605},
  {'name': 'Uttar Pradesh Varanasi', 'lat': 25.2868656, 'lng': 82.973149},
  {'name': 'Uttar Pradesh Aligarh', 'lat': 27.9079413, 'lng': 78.0766036},
  {'name': 'Uttar Pradesh Kanpur', 'lat': 26.4692427, 'lng': 80.3018107},
  {'name': 'Uttar Pradesh Gorakhpur', 'lat': 26.7892124, 'lng': 83.3735966},
  {'name': 'Uttar Pradesh Moradabad', 'lat': 28.8736556, 'lng': 78.7249469},
  {'name': 'Uttar Pradesh Lucknow', 'lat': 26.9485309, 'lng': 80.9705292},
  {'name': 'Uttar Pradesh Gorakhpur', 'lat': 26.7892124, 'lng': 83.3735966},
  {'name': 'Uttar Pradesh Jhansi', 'lat': 25.4600153, 'lng': 78.5320107},
  {'name': 'Uttar Pradesh Prayagraj', 'lat': 25.4640822, 'lng': 81.8169709},
  {'name': 'Delhi Lajpat Nagar', 'lat': 28.5683786, 'lng': 77.2416464},
  {'name': 'Delhi Pitampura', 'lat': 28.6930443, 'lng': 77.1350949},
  {'name': 'Delhi Karol Bag', 'lat': 28.6354261, 'lng': 77.1856762},
  {'name': 'Delhi Dwarka', 'lat': 28.6102254, 'lng': 77.0300594},
  {'name': 'Haryana Faridabad', 'lat': 28.419423, 'lng': 77.3668965},
  {'name': 'Uttar Pradesh Ghaziabad', 'lat': 28.6805926, 'lng': 77.4587239},
  {'name': 'Haryana Gurugram', 'lat': 28.474679, 'lng': 77.1048978},
  {'name': 'Delhi Janakpuri', 'lat': 28.6217426, 'lng': 77.0882695},
  {'name': 'Karnataka Gulbarga', 'lat': 17.3088971, 'lng': 76.9412601},
  {'name': 'SAAOL Uttarakhand Haridwar', 'lat': 29.9498376, 'lng': 78.0766036},
  {'name': 'Saaol Rajasthan Alwar', 'lat': 27.4966161, 'lng': 76.5025742},
  {
    'name': 'Saaol West Bengal Kolkata Shri Siddhivinayak Devsthanam ',
    'lat': 22.5825574,
    'lng': 88.3617028
  },
  {
    'name': 'Saaol West Bengal Kolkata Salt Lake',
    'lat': 22.5924571,
    'lng': 88.412665
  },
  {
    'name': 'SAAOL Maharshtra  Nagpur Lakadganj',
    'lat': 21.150653,
    'lng': 79.1294516
  },
  {'name': 'SAAOL Odisha Sambalpur', 'lat': 21.4893754, 'lng': 83.9823627},
  {'name': 'SAAOL Uttar Pradesh Rampur', 'lat': 28.7619131, 'lng': 79.0419053},
  {'name': 'SAAOL Mumbai Andheri', 'lat': 19.1121049, 'lng': 79.0419053},
  {'name': 'SAAOL Uttar Pradesh Rampur', 'lat': 28.7619131, 'lng': 79.0419053},
  {'name': 'SAAOL Mumbai Andheri', 'lat': 19.1121049, 'lng': 72.861073},
  {'name': 'SAAOL Uttar Pradesh Jaunpur', 'lat': 25.7275335, 'lng': 82.6807458},
  {'name': 'SAAOL Madhya Pradesh Guna', 'lat': 24.6747256, 'lng': 77.355413},
  {'name': 'SAAOL Punjab Gurdaspur', 'lat': 32.0579368, 'lng': 75.3995089},
  {'name': 'SAAOL Punjab Nawanshahr', 'lat': 31.1338927, 'lng': 76.1203982},
  {'name': 'SAAOL West Bengal Bardhaman', 'lat': 23.1887705, 'lng': 87.8255007},
  {'name': 'SAAOL Jammu', 'lat': 32.688772, 'lng': 74.9325683},
  {'name': 'SAAOL Uttar Pradesh Hapur', 'lat': 28.6977289, 'lng': 77.7680952},
  {'name': 'SAAOL Maharashtra Erandwane', 'lat': 18.515729, 'lng': 73.8348683},
  {'name': 'SAAOL Bihar Gaya', 'lat': 24.7912052, 'lng': 84.9973546},
  {
    'name': 'SAAOL Uttarakhand Dehradun Wellness Research Institute',
    'lat': 30.4006197,
    'lng': 78.0309542
  },
  {'name': 'SAAOL Karnataka Rajajinagar', 'lat': 13.0066617, 'lng': 77.5449837},
  {'name': 'SAAOL Madhya Pradesh Guna', 'lat': 24.6747256, 'lng': 77.355413},
  {'name': 'SAAOL Punjab Gurdaspur', 'lat': 32.0579368, 'lng': 75.3995089},
  {'name': 'SAAOL Punjab Nawanshahr', 'lat': 31.1338927, 'lng': 76.1203982},
  {'name': 'SAAOL West Bengal Bardhaman', 'lat': 23.1887705, 'lng': 87.8255007},
  {'name': 'SAAOL Jammu', 'lat': 32.688772, 'lng': 74.9325683},
  {'name': 'SAAOL Uttar Pradesh Hapur', 'lat': 28.6977289, 'lng': 77.7680952},
  {'name': 'SAAOL Maharashtra Erandwane', 'lat': 18.515729, 'lng': 73.8348683},
  {'name': 'SAAOL Bihar Gaya', 'lat': 24.7912052, 'lng': 84.9973546},
];
final List<Map<String, dynamic>> indianStates = [
  {'name': 'Delhi', 'lat': 28.7041, 'lng': 77.1025},
  {'name': 'Maharashtra', 'lat': 19.7515, 'lng': 75.7139},
  {'name': 'Uttar Pradesh', 'lat': 26.8467, 'lng': 80.9462},
  {'name': 'Karnataka', 'lat': 15.3173, 'lng': 75.7139},
  {'name': 'Tamil Nadu', 'lat': 11.1271, 'lng': 78.6569},
  {'name': 'Gujarat', 'lat': 22.2587, 'lng': 71.1924},
  {'name': 'Rajasthan', 'lat': 27.0238, 'lng': 74.2179},
  {'name': 'West Bengal', 'lat': 22.9868, 'lng': 87.8550},
  {'name': 'Madhya Pradesh', 'lat': 22.9734, 'lng': 78.6569},
  {'name': 'Bihar', 'lat': 25.0961, 'lng': 85.3131},
  // Add more states as needed
];

class MapScreen2 extends StatefulWidget {
  const MapScreen2({super.key});

  @override
  _MapScreen2State createState() => _MapScreen2State();
}

class _MapScreen2State extends State<MapScreen2> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  final LatLng _initialPosition = const LatLng(20.5937, 78.9629); // Default to center of India
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  String _searchQuery = '';
  List _filteredStates = indianStates.map((state) => state['name']).toList();

  @override
  void initState() {
    super.initState();
    _checkLocationPermissionAndFetch();
  }

  Future<void> _checkLocationPermissionAndFetch() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _addMarkers();
      });
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 14.0),
        ),
      );
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  /*void _addMarkers() async {
    if (_currentPosition != null) {
      _markers.clear();

      // Add a marker for the user's current location
      _markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: InfoWindow(title: 'Your Location'),
        ),
      );

      // Calculate the distance between the user's location and each SAAOL Heart Center
      List<Map<String, dynamic>> nearestCenters =
          saaolHeartCenters.map((center) {
        double distance = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          center['lat'],
          center['lng'],
        );
        return {...center, 'distance': distance};
      }).toList();

      // Sort the centers by distance
      nearestCenters.sort((a, b) => a['distance'].compareTo(b['distance']));

       BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), // Adjust size as needed
        'assets/images/saool_logo.png', // Replace with your logo image path
      );

      // Add markers for the nearest centers (you can limit to a specific number if needed)
      nearestCenters.take(140).forEach((center) {
        _markers.add(
          Marker(
            markerId: MarkerId(center['name']),
            position: LatLng(center['lat'], center['lng']),
            infoWindow: InfoWindow(
              title: center['name'],
              snippet: 'Saaol Heart Center',
            ),
          ),
        );
      });

      setState(() {});
    }
  }*/

  void _filterStates(String query) {
    setState(() {
      _searchQuery = query;
      _filteredStates = indianStates
          .where((state) =>
              state['name'].toLowerCase().contains(query.toLowerCase()))
          .map((state) => state['name'])
          .toList();
    });
  }

  void _navigateToState(String stateName) async {
    final selectedState = indianStates.firstWhere(
      (state) => state['name'].toLowerCase() == stateName.toLowerCase(),
      orElse: () => {'name': '', 'lat': 0.0, 'lng': 0.0},
    );

    if (selectedState['name'].isNotEmpty && _currentPosition != null) {
      final LatLng stateLatLng =
          LatLng(selectedState['lat'], selectedState['lng']);
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: stateLatLng, zoom: 10.0),
        ),
      );

      // Add marker at the selected state location
      _markers.add(
        Marker(
          markerId: MarkerId(selectedState['name']),
          onTap: () {
            Fluttertoast.showToast(msg: 'Click');
          },
          position: stateLatLng,
          infoWindow: InfoWindow(
            title: selectedState['name'],
            snippet: 'Saaol Heart Centre',
          ),
        ),
      );

      // Draw polyline from the current location to the selected state
      final PolylineId polylineId = PolylineId('route');
      final Polyline polyline = Polyline(
        polylineId: polylineId,
        color: AppColors.primaryColor,
        width: 5,
        points: [
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          stateLatLng,
        ],
      );

      setState(() {
        _polylines.clear(); // Clear existing polylines if any
        _polylines.add(polyline); // Add new polyline
      });
    }
  }

  Future<void> _addMarkers() async {
    if (_currentPosition != null) {
      _markers.clear();

      // Load the custom marker icon
      Uint8List markerIcon =
          await getImages('assets/icons/location_logo.png',160);

      BitmapDescriptor customIcon = BitmapDescriptor.fromBytes(markerIcon);

      // Add a marker for the user's current location
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: customIcon, // Use the custom icon
        ),
      );

      // Calculate the distance between the user's location and each SAAOL Heart Center
      List<Map<String, dynamic>> nearestCenters =
          saaolHeartCenters.map((center) {
        double distance = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          center['lat'],
          center['lng'],
        );
        return {...center, 'distance': distance};
      }).toList();

      // Sort the centers by distance
      nearestCenters.sort((a, b) => a['distance'].compareTo(b['distance']));

      // Add markers for the nearest centers
      nearestCenters.take(140).forEach((center) {
        _markers.add(
          Marker(
            markerId: MarkerId(center['name']),
            position: LatLng(center['lat'], center['lng']),
            infoWindow: InfoWindow(
              title: center['name'],
              snippet: 'Saaol Heart Center',
            ),
            icon: customIcon, // Use the custom icon
          ),
        );
      });

      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 5.0,
                  ),
                  circles: _currentPosition == null
                      ? Set()
                      : {
                          Circle(
                            circleId: CircleId('currentCircle'),
                            center: LatLng(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude,
                            ),
                            radius: 3000,
                            // Adjust the radius as needed
                            fillColor: Colors.blue.shade100.withOpacity(0.5),
                            strokeColor: Colors.blue.shade100.withOpacity(0.1),
                            strokeWidth: 2, // Adjust the stroke width as needed
                          ),
                        },
                  markers: _markers,
                  //  polylines: _polylines,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    if (_currentPosition != null) {
                      _mapController?.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(_currentPosition!.latitude,
                                _currentPosition!.longitude),
                            zoom: 14.0,
                          ),
                        ),
                      );
                    }
                  },
                ),
          buildFloatingSearchBar(),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          onPressed: _checkLocationPermissionAndFetch,
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(Icons.my_location, size: 30, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: _searchQuery.isEmpty ? 'Search for center or state' : _searchQuery,
      hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'FontPoppins',
          fontWeight: FontWeight.w500,
          color: Colors.black),
      openAxisAlignment: 0.0,
      axisAlignment: isPortrait ? 0.0 : -1.0,
      scrollPadding: const EdgeInsets.only(top: 25, bottom: 56),
      elevation: 4.0,
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      physics: const BouncingScrollPhysics(),
      onQueryChanged: (query) {
        _filterStates(query);
      },
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      debounceDelay: const Duration(milliseconds: 300),
      leadingActions: [
        FloatingSearchBarAction(
          child: CircularButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 22),
            onPressed: () {
              // Optionally handle icon tap if needed
            },
          ),
        ),
      ],
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.mic, color: Colors.black, size: 22),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: _filteredStates.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _searchQuery = _filteredStates[index];
                        FloatingSearchBar.of(context)!.close();
                      });
                      // _navigateToState(_filteredStates[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.primaryColor,
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _filteredStates[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const Text(
                                'Saaol Heart Centre : EECP Treatment',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
