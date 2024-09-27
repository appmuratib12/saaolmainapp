import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../common/app_colors.dart';
import 'LocationService.dart';
import 'MyHomePageScreen.dart';


class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({super.key});

  @override
  _SearchBarScreenState createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> cities = [
    'Gurgaon',
    'New Delhi',
    'Bangalore',
    'Hyderabad',
    'Mumbai',
    'Pune',
    'Kolkata'
  ];
  List<String> filteredCities = [];

  Map<String, IconData> cityIcons = {
    'Gurgaon': Icons.location_city,
    'New Delhi': Icons.account_balance,
    'Bangalore': Icons.business,
    'Hyderabad': Icons.home,
    'Mumbai': Icons.apartment,
    'Pune': Icons.local_hospital,
    'Kolkata': Icons.school,
  };

  @override
  void initState() {
    super.initState();
    filteredCities = cities;
    _searchController.addListener(() {
      filterCities();
    });
  }

  void filterCities() {
    List<String> results = [];
    if (_searchController.text.isEmpty) {
      results = cities;
    } else {
      results = cities
          .where((city) =>
              city.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredCities = results;
    });
  }

  final LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.primaryColor,
                child: const Center(
                  child: Text(
                    'Search for your city',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'FontPoppins',
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Container(
                height: 45,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  // Adjusted border radius
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5, // Adjusted blur radius
                      offset: Offset(0, 3), // Adjusted offset
                    ),
                  ],
                ),
                child: Row(
                  children: [
                     Icon(Icons.location_on,
                        size: 20, color: AppColors.primaryColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Search for your city",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'FontPoppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      // Adjusted icon size
                      onPressed: () {
                        _searchController.clear();
                      },
                      padding: EdgeInsets.all(0),
                      // Remove additional padding
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Divider(
                  height: 10,
                  thickness: 0.2,
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      Position position =
                          await _locationService.getCurrentLocation();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Location: ${position.latitude}, ${position.longitude}'),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to get location'),
                        ),
                      );
                    }
                    Fluttertoast.showToast(msg: 'Click');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(color: Colors.grey, width: 0.3),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.my_location,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          'Use your current location',
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 10,
                  thickness: 0.2,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Text(
                'Cities',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                String city = filteredCities[index];
                return ListTile(
                  leading: Icon(
                    cityIcons[city] ?? Icons.location_city,
                    color: AppColors.primaryColor,
                  ),
                  title: Text(
                    city,
                    style: const TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 18,
                  ),
                  onTap: () {
                    /* Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const HomePage(initialIndex: 0)),
                    );*/

                    String city = filteredCities[index];
                    // You should map the city to its coordinates. Assuming you have this data.
                    Map<String, LatLng> cityCoordinates = {
                      'Gurgaon': LatLng(28.4595, 77.0266),
                      'New Delhi': LatLng(28.6139, 77.2090),
                      'Bangalore': LatLng(12.9716, 77.5946),
                      'Hyderabad': LatLng(17.3850, 78.4867),
                      'Mumbai': LatLng(19.0760, 72.8777),
                      'Pune': LatLng(18.5204, 73.8567),
                      'Kolkata': LatLng(22.5726, 88.3639),
                    };

                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => HomePage(initialIndex: 0),
                      ),
                    );
                    Fluttertoast.showToast(
                      msg: 'Clicked on $city',
                    );
                  },
                );
              },
              childCount: filteredCities.length,
            ),
          ),
        ],
      ),
    );
  }
}
