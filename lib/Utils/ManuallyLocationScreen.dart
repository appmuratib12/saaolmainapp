import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/app_colors.dart';
import '../data/model/apiresponsemodel/StatesResponseData.dart';
import '../data/network/BaseApiService.dart';
import 'LocationService.dart';
import 'NearByCenterScreen.dart';


class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({super.key});


  @override
  _SearchBarScreenState createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Data> allCities = []; // Holds all cities fetched from the API
  List<Data> filteredCities = []; // Holds filtered cities



  @override
  void initState() {
    super.initState();
    _searchController
        .addListener(_filterCities); // Listen for changes in the search bar
    _fetchCities(); // Fetch the cities from API
  }

  String currentLocation = 'Unknown location';
  final LocationService _locationService = LocationService();

  Future<void> _fetchCities() async {
    try {
      final statesResponse = await BaseApiService().getStatesData();
      setState(() {
        allCities = statesResponse.data!;
        filteredCities = allCities; // Initially, show all cities
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to fetch cities: ${e.toString()}');
    }
  }

  void _filterCities() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      filteredCities = allCities
          .where((city) =>
              city.state!.toLowerCase().contains(query) ||
              city.pincode!.toLowerCase().contains(query))
          .toList();
    });
  }
  late String cityName;
  late String pinCode;

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('cityName',cityName.toString(), );
      prefs.setString('pinCode',pinCode.toString());

    });
  }

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
                    const Icon(Icons.location_on,
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
                      padding: const EdgeInsets.all(0),
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
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    'Your current location: $currentLocation',
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
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
                      Position position = await _locationService.getCurrentLocation();
                      String cityAndPincode = await _locationService.getCityAndPincode(position);
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('saved_location', cityAndPincode);
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              const NearByCenterScreen(), // Your target screen
                        ),
                      );

                      Fluttertoast.showToast(msg: 'Location: $cityAndPincode');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to get location'),
                        ),
                      );
                    }
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
                          'Use my current location',
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Cities',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: filteredCities.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index1) {
                        String stateName =
                            filteredCities[index1].state.toString();
                        String capitalizedStateName =
                            stateName[0].toUpperCase() +
                                stateName.substring(1).toLowerCase();

                        return InkWell(
                          onTap: () {
                             cityName = filteredCities[index1].state.toString();
                             pinCode = filteredCities[index1].pincode.toString();
                             _incrementCounter();
                             Navigator.pop(context);
                            /* Navigator.push(
                               context,
                               CupertinoPageRoute(
                                   builder: (context) => const HomePage(initialIndex: 0)),
                             );*/
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.location_city,
                                        color: AppColors.primaryDark),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        capitalizedStateName,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
