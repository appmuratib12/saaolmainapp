

/*

final List<Map<String, dynamic>> saaolHeartCenters = [
  {'name': 'Nirman Vihar', 'lat': 28.6362211, 'lng': 77.2922332},
  {'name': 'Lajpat Nagar', 'lat': 28.5683786, 'lng': 77.2416464},
  {'name': 'Pitampur', 'lat': 28.6930443, 'lng': 77.1350949},
  {'name': 'Karol Bagh', 'lat': 28.6354261, 'lng': 77.1856762},
];

class MapScreen extends StatefulWidget {
  final String selectedCity;
  final LatLng selectedCityCoordinates;

  const MapScreen({
    super.key,
    required this.selectedCity,
    required this.selectedCityCoordinates,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Set<Marker> _markers = {};
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLocationPermissionAndFetch();
    _addSelectedCityMarker();
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
      });
      _addMarkers();
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

  void _addMarkers() {
    if (_currentPosition != null) {
      _markers.clear();

      _markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position:
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: InfoWindow(title: 'Your Location'),
        ),
      );

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

      nearestCenters.sort((a, b) => a['distance'].compareTo(b['distance']));

      nearestCenters.take(10).forEach((center) {
        _markers.add(
          Marker(
            markerId: MarkerId(center['name']),
            position: LatLng(center['lat'], center['lng']),
            infoWindow: InfoWindow(
                title: center['name'], snippet: 'Saaol Heart Center'),
          ),
        );
      });

      setState(() {});
    }
  }

  void _addSelectedCityMarker() {
    _markers.add(
      Marker(
        markerId: MarkerId(widget.selectedCity),
        position: widget.selectedCityCoordinates,
        infoWindow: InfoWindow(
          title: widget.selectedCity,
          snippet: 'Selected City',
        ),
      ),
    );

    // Update the camera position to center on the selected city
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: widget.selectedCityCoordinates,
            zoom: 14.0,
          ),
        ),
      );
    });

    setState(() {});
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
                    target: widget.selectedCityCoordinates,
                    zoom: 14.0,
                  ),
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    _addSelectedCityMarker();
                  },
                ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Image(
                            image: AssetImage('assets/images/saool_logo.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const SearchBarScreen()),
                        );
                      },
                      child: const Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            'New Delhi',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: 24,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    */
/* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(
                      searchController: _searchController,
                    ),
                  ),
                );*//*

                   */
/* Navigator.push(
                      context,
                      FadeRoute(
                        page: GoogleMapNewScreen(
                          searchController: _searchController,
                        ),
                      ),
                    );*//*



                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Search for cities...',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.mic, color: Colors.black),
                          onPressed: () {
                            // Implement microphone functionality here
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkLocationPermissionAndFetch,
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(Icons.my_location, size: 30, color: Colors.white),
      ),
    );
  }
}
*/


