import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:saaolapp/common/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MyHomePageScreen.dart';

class AddAddressScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String currentLocationName;

  const AddAddressScreen(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.currentLocationName});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late GoogleMapController mapController;
  late Marker _currentLocationMarker;
  String locationName = '';
  late TextEditingController _searchController = TextEditingController();
  final String apiKey = 'AIzaSyAPUheDqseUFITXvISm-fcyOt4VoPFBfMg';
  String distance = '';
  String duration = '';
  double? selectedLat;
  double? selectedLng;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {}); // Needed to show/hide the clear button
    });
    _currentLocationMarker = Marker(
      markerId: const MarkerId('current_location'),
      position: LatLng(widget.latitude, widget.longitude),
      infoWindow: const InfoWindow(title: 'Current Location'),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Map<String, String>>> getSuggestions(String input) async {
    final String request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&components=country:in';

    final response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List predictions = data['predictions'];
      return predictions.map<Map<String, String>>((p) {
        return {
          'description': p['description'],
          'place_id': p['place_id'],
        };
      }).toList();
    } else {
      throw Exception('Failed to fetch suggestions');
    }
  }
  Future<LatLng> getPlaceCoordinates(String placeId) async {
    final String detailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    final response = await http.get(Uri.parse(detailsUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final location = data['result']['geometry']['location'];
      return LatLng(location['lat'], location['lng']);
    } else {
      throw Exception('Failed to fetch place details');
    }
  }
  Future<LatLng> getLatLngFromPlace(String placeDescription) async {
    const String apiKey = 'AIzaSyAPUheDqseUFITXvISm-fcyOt4VoPFBfMg';
    final autocompleteUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${Uri.encodeComponent(placeDescription)}&key=$apiKey&components=country:in';

    final autocompleteResponse = await http.get(Uri.parse(autocompleteUrl));
    final autocompleteData = json.decode(autocompleteResponse.body);
    final placeId = autocompleteData['predictions'][0]['place_id'];

    final detailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    final detailsResponse = await http.get(Uri.parse(detailsUrl));
    final detailsData = json.decode(detailsResponse.body);
    final location = detailsData['result']['geometry']['location'];

    return LatLng(location['lat'], location['lng']);
  }
  Future<void> getDistanceMatrix(String origin, String destination) async {
    const String apiKey = 'AIzaSyAPUheDqseUFITXvISm-fcyOt4VoPFBfMg';
    final url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=${Uri.encodeComponent(origin)}&destinations=${Uri.encodeComponent(destination)}&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);

    if (jsonData['status'] == 'OK') {
      final elements = jsonData['rows'][0]['elements'][0];
      setState(() {
        distance = elements['distance']['text'];
        duration = elements['duration']['text'];
      });
    } else {
      throw Exception('Failed to load distance matrix');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Add Address',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude, widget.longitude),
              zoom: 15,
            ),
            markers: {_currentLocationMarker},
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: TypeAheadField<Map<String, String>>(
                suggestionsCallback: (pattern) async {
                  if (pattern.length > 2) {
                    return await getSuggestions(pattern);
                  }
                  return [];
                },
                builder: (context, controller, focusNode) {
                  _searchController = controller;
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search for a new area, locality',
                      contentPadding: const EdgeInsets.symmetric(vertical: 11),
                      hintStyle: const TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: controller.text.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            controller.clear();
                          });
                        },
                      )
                          : null,
                    ),
                  );
                },
                itemBuilder: (context, suggestion) {
                  final fullAddress = suggestion['description']!;
                  final parts = fullAddress.split(',');
                  final subLocality = parts.isNotEmpty ? parts[0].trim() : '';
                  final remainingAddress = parts.length > 1
                      ? parts.sublist(1).join(',').trim()
                      : '';

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFE8F5E9),
                        child: Icon(Icons.location_on, color: Colors.green),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subLocality,
                            style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (remainingAddress.isNotEmpty)
                            Text(
                              remainingAddress,
                              style: const TextStyle(
                                fontSize: 13,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
                onSelected: (suggestion) async {
                  final latLng = await getPlaceCoordinates(suggestion['place_id']!);
                  mapController.animateCamera(
                    CameraUpdate.newLatLngZoom(latLng, 15),
                  );

                  final location = suggestion['description']!;

                  setState(() {
                    locationName = location;
                    selectedLat = latLng.latitude;
                    selectedLng = latLng.longitude;

                    _searchController.text = location;
                    _currentLocationMarker = Marker(
                      markerId: const MarkerId('current_location'),
                      position: latLng,
                      infoWindow: InfoWindow(title: location),
                    );
                  });

                  final prefs = await SharedPreferences.getInstance();
                  List<String> savedAddresses = prefs.getStringList('saved_addresses') ?? [];

                  if (!savedAddresses.contains(location)) {
                    savedAddresses.add(location);
                    await prefs.setStringList('saved_addresses', savedAddresses);
                  }

                  final origin = '${widget.latitude},${widget.longitude}';
                  final destination = '${latLng.latitude},${latLng.longitude}';
                  await getDistanceMatrix(origin, destination);
                },
              ),
            ),
          ),

          Positioned(
            bottom: 220, // Adjust to be just above your bottom container
            right: 15,
            child: GestureDetector(
              onTap: () {
                mapController.animateCamera(
                  CameraUpdate.newLatLng(
                    LatLng(widget.latitude, widget.longitude),
                  ),
                );
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child:const Icon(Icons.my_location,
                    color: AppColors.primaryColor, size: 24),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Saaol Center at this location',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: 'FontPoppins',
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'location:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            fontFamily: 'FontPoppins',
                            color: Colors.black,
                          ),
                        ),
                        if (distance.isNotEmpty && duration.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'Distance: $distance | Duration: $duration',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                           const Icon(Icons.pin_drop_rounded,
                              color:AppColors.primaryColor, size: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              locationName.isNotEmpty
                                  ? locationName
                                  : 'Current Location',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final prefs = await SharedPreferences.getInstance();
                              final subLocality = locationName.split(',').first.trim();
                              await prefs.setString('selected_location', subLocality);
                              if (selectedLat != null && selectedLng != null) {
                                await prefs.setDouble('selected_latitude', selectedLat!);
                                await prefs.setDouble('selected_longitude', selectedLng!);
                              } else {
                                debugPrint("Coordinates are null, cannot save.");
                              }
                              if (context.mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const HomePage(
                                          initialIndex:
                                              0)), // replace with your Home widget
                                );
                              }
                            },
                            child:const Text(
                              'Change',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontFamily: 'FontPoppins',
                                color:AppColors.primaryColor
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
          ),
        ],
      ),
    );
  }
}
