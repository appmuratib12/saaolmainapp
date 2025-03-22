import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/CenterCitiesResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/CountriesResponse.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/StatesResponse.dart';
import '../../common/app_colors.dart';
import '../../data/network/BaseApiService.dart';
import '../CenterDetailsPageScreen.dart';
import '../SearchBarScreem.dart';
import 'CenterSearchScreen.dart';

class OurCenterScreen extends StatefulWidget {
  const OurCenterScreen({super.key});

  @override
  State<OurCenterScreen> createState() => _OurCenterScreenState();
}

class _OurCenterScreenState extends State<OurCenterScreen> {
  final List<Map<String, String>> cities = [
    {'name': 'Delhi-NCR', 'image': 'assets/images/india_gate.png'},
    {'name': 'Bengaluru', 'image': 'assets/images/howrah_bridge.jpg'},
    {'name': 'Mumbai', 'image': 'assets/images/chennai.jpg'},
    {'name': 'Chennai', 'image': 'assets/images/char_minar.jpg'},
    {'name': 'Kolkata', 'image': 'assets/images/banglore_image.jpg'},
  ];

  final List<Map<String, String>> states = [
    {'name': 'Andhra Pradesh', 'image': 'assets/images/states/andhra_pradesh_image.jpg'},
    {'name': 'Assam', 'image': 'assets/images/states/assam_image.jpg'},
    {'name': 'Bangladesh', 'image': 'assets/images/states/bihar_image.jpg'},
    {'name': 'Bihar', 'image': 'assets/images/states/bihar_image.jpg'},
    {'name': 'Chhattisgarh', 'image': 'assets/images/states/chattisgrah_image.jpg'},
    {'name': 'Delhi', 'image': 'assets/images/india_gate.png'},
    {'name': 'Goa', 'image': 'assets/images/states/goa_image.png'},
    {'name': 'Gujarat', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Haryana', 'image': 'assets/images/states/karnal.jpg'},
    {'name': 'Jharkhand', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Karnataka', 'image': 'assets/images/howrah_bridge.jpg'},
    {'name': 'Kerala', 'image': 'assets/images/chennai.jpg'},
    {'name': 'Madhya Pradesh', 'image': 'assets/images/chennai.jpg'},
    {'name': 'Maharashtra', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Nepal', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Odisha', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Punjab', 'image': 'assets/images/chennai.jpg'},
    {'name': 'Rajasthan', 'image': 'assets/images/india_gate.png'},
    {'name': 'Tamil Nadu', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Telangana', 'image': 'assets/images/chennai.jpg'},
    {'name': 'Uttar Pradesh', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'West Bengal', 'image': 'assets/images/india_gate.png'},
    {'name': 'Uttrakhand', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Jammu', 'image': 'assets/images/states/jammu_image.jpg'},

  ];
  final List<Map<String, String>> countries = [
    {'name': 'India', 'image': 'assets/images/countries/indian_flag.jpg'},
    {
      'name': 'Bangladesh',
      'image': 'assets/images/countries/nepal_image.jpg'
    },
    {'name': 'Nepal', 'image': 'assets/images/countries/bangladesh_image.jpg'},
  ];

  final List<String> citiesArray = [
    'Ahmedabad',
    'Ajmer',
    'Amritsar',
    'Anand',
    'Armoor',
    'Aurangabad',
    'Bareilly',
    'Belagavi',
    'Belgaum',
    'Bengaluru',
    'Bharuch',
    'Bhilai',
    'Bhilwara',
    'Bhiwadi',
    'Bhopal',
    'Bhubaneswar',
    'Bilaspur',
    'Bokaro',
    'Burdwan',
    'Chandigarh',
    'Chennai',
    'Coimbatore',
    'Cuddalore',
    'Cuttack',
    'Darjeeling',
    'Dehradun',
    'Delhi',
    'Delhi-NCR'
  ];

  void _showBengaluruDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          margin: const EdgeInsets.all(15),
          height:420,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(storeStateName,
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 0.2,
                  height: 15,
                  color: Colors.grey,
                ),
                const Text(
                  'Select Your Center',
                  style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),

                FutureBuilder<CenterCitiesResponse>(
                  future: BaseApiService().getCenterCitiesResponse(storeStateName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error fetching cities: ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                         snapshot.data!.data == null ||
                        snapshot.data!.data!.isEmpty) {
                      return const Center(child: Text('No cities available.'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        clipBehavior:Clip.hardEdge,
                        itemCount:snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              String centerName = snapshot.data!.data![index];
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          CenterDetailsPageScreen(centerName:centerName)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/howrah_bridge.jpg',
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Text(snapshot.data!.data![index],
                                          style: const TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _selectedIndex = 0;
  int selectedIndex = 0;

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndex == index) {
        _selectedIndex = -1; // Deselect if tapped again
      } else {
        _selectedIndex = index; // Select the new item
      }
    });
  }

  final TextEditingController _controller = TextEditingController();
  final List<String> _states = [
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'Florida',
    'Georgia',
    // Add more states here
  ];


  @override
  void initState() {
    super.initState();
  }


  String storeCountryName = 'india';
  String storeStateName = 'Delhi';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final int halfLength = (citiesArray.length / 2).ceil();
    final List<String> firstColumn = citiesArray.sublist(0, halfLength);
    final List<String> secondColumn = citiesArray.sublist(halfLength);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    FadeRoute(
                      page:CenterSearchScreen(
                        searchController: _searchController, // Pass the searchController to the SearchScreen
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 47.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius:10,
                        offset: const Offset(0, 2),
                      ),
                    ],

                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.black54,
                          size: 25,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Search city',
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    'Selected Country:',
                    style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(child: Container()),
                   Text(storeCountryName,
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),


              FutureBuilder<CountriesResponse>(
                future: BaseApiService().getCountriesData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return  GridView.builder(
                      shrinkWrap: true,
                      physics:const NeverScrollableScrollPhysics(),
                      clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.all(10.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 2,
                      ),
                      itemCount:snapshot.data!.data!.length,
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () {
                          _toggleSelection(index);
                          storeCountryName = snapshot.data!.data![index];

                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              Image.asset(
                                countries[index]['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              if (_selectedIndex == index)
                                const Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(1),
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 7,
                                  ),
                                  child: Text(snapshot.data!.data![index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'FontPoppins',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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


              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    'Selected Location:',
                    style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(child: Container()),
                   Text(storeStateName,
                    style: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              FutureBuilder<CenterStatesResponse>(
              future: BaseApiService().getCenterStatesData(storeCountryName),
              builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
              } else if (snapshot.hasError) {
                print('Error fetching states: ${snapshot.error}');
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData ||
                  snapshot.data!.data == null ||
                  snapshot.data!.data!.isEmpty) {
                return const Center(child: Text('No states available.'));
              } else {
                // Sort states alphabetically
                List<String> sortedStates = List.from(snapshot.data!.data!);
                sortedStates.sort((a, b) => a.compareTo(b));

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1,
                  ),
                  itemCount: sortedStates.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                    //  storeStateName = snapshot.data!.data![index];
                       storeStateName = sortedStates[index];
                      //  _showChennaiDetails(context);
                      _showBengaluruDetails(context);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Image.asset(
                            states[index]['image']!, // Ensure states list is defined
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(1),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 7,
                              ),
                              child: Text(sortedStates[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'FontPoppins',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),

              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Other Cities',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily:'FontPoppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Divider(color: Colors.grey),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: firstColumn
                            .map((city) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7.0),
                          child: InkWell(
                            onTap: () {
                              Fluttertoast.showToast(
                                  msg: '$city clicked');
                            },
                            child: Text(
                              city,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'FontPoppins',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: secondColumn
                            .map((city) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7.0),
                          child: Text(
                            city,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
