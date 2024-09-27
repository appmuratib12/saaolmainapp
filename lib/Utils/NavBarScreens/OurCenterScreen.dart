import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../common/app_colors.dart';

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
    {'name': 'Assam', 'image': 'assets/images/states/assam_image.jpg'},
    {
      'name': 'Andhra Pradesh',
      'image': 'assets/images/states/andhra_pradesh_image.jpg'
    },
    {'name': 'Bihar', 'image': 'assets/images/states/bihar_image.jpg'},
    {
      'name': 'Chhattisgarh',
      'image': 'assets/images/states/chattisgrah_image.jpg'
    },
    {'name': 'Gujarat', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Goa', 'image': 'assets/images/states/goa_image.png'},
    {'name': 'Haryana', 'image': 'assets/images/states/karnal.jpg'},
    {'name': 'Jammu', 'image': 'assets/images/states/jammu_image.jpg'},
    {'name': 'Jharkhand', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Karnataka', 'image': 'assets/images/howrah_bridge.jpg'},
    {'name': 'Kerala', 'image': 'assets/images/chennai.jpg'},
    {'name': 'Maharashtra', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Madhya Pradesh', 'image': 'assets/images/chennai.jpg'},
    {'name': 'Odisha', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Punjab', 'image': 'assets/images/chennai.jpg'},
    {'name': 'Rajasthan', 'image': 'assets/images/india_gate.png'},
    {'name': 'Tamil Nadu', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Telangana', 'image': 'assets/images/chennai.jpg'},
    {'name': 'Uttrakhand', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'Uttar Pradesh', 'image': 'assets/images/banglore_image.jpg'},
    {'name': 'West Bengal', 'image': 'assets/images/india_gate.png'},
  ];
  final List<Map<String, String>> countries = [
    {'name': 'India', 'image': 'assets/images/countries/indian_flag.jpg'},
    {
      'name': 'Bangladesh',
      'image': 'assets/images/countries/bangladesh_image.jpg'
    },
    {'name': 'Nepal', 'image': 'assets/images/countries/nepal_image.jpg'},
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

  void _showCityDetails(BuildContext context, String cityName) {
    switch (cityName) {
      case 'Delhi-NCR':
        _showDelhiDetails(context, cityName);
        break;
      case 'Bengaluru':
        _showBengaluruDetails(context, cityName);
        break;
      case 'Mumbai':
        _showMumbaiDetails(context);
        break;
      case 'Chennai':
        _showChennaiDetails(context);
        break;
      case 'Kolkata':
        _showKolkataDetails(context);
        break;
    }
  }

  void _showDelhiDetails(BuildContext context, String cityName) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        List<String> citiesArray = [
          'Chhattarpur',
          'Kailash Colony',
          'Nirman Vihar',
          'Pitampura',
          'Rajender Nagar',
          'Dwarka',
          'Janakpuri'
        ];
        return Container(
          margin: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    cityName,
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: citiesArray.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                      /*  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const CenterDetailsPageScreen()),
                        );*/
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
                                  Text(
                                    citiesArray[index],
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBengaluruDetails(BuildContext context, String cityName) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        List<String> citiesArray = [
          'Bangalore Hebbal',
          'Bangalore Banashankari',
          'Bangalore Hubballi',
          'Bangalore Belagavi',
          'Bangalore Kundalahalli',
          'Kalaburgi',
          'Rajajinagar'
        ];
        return Container(
          margin: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    cityName,
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: citiesArray.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        /*Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const CenterDetailsPageScreen()),
                        );*/
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
                                  Text(
                                    citiesArray[index],
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMumbaiDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return _buildBottomSheetContent(
          'Mumbai',
          'assets/images/chennai.jpg',
          'Details about Mumbai.',
        );
      },
    );
  }

  void _showChennaiDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return _buildBottomSheetContent(
          'Chennai',
          'assets/images/char_minar.jpg',
          'Details about Chennai.',
        );
      },
    );
  }

  void _showKolkataDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return _buildBottomSheetContent(
          'Kolkata',
          'assets/images/banglore_image.jpg',
          'Details about Kolkata.',
        );
      },
    );
  }

  Widget _buildBottomSheetContent(
      String cityName, String imagePath, String details) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            cityName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          const SizedBox(height: 20),
          Text(
            details,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
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
  late List<String> _filteredStates;

  @override
  void initState() {
    super.initState();
    _filteredStates = _states;
    _controller.addListener(_filterStates);
  }

  void _filterStates() {
    final query = _controller.text.toLowerCase();
    setState(() {
      _filteredStates = _states
          .where((state) => state.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final int halfLength = (citiesArray.length / 2).ceil();
    final List<String> firstColumn = citiesArray.sublist(0, halfLength);
    final List<String> secondColumn = citiesArray.sublist(halfLength);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey, width: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _controller,
                  decoration:  InputDecoration(
                    hintText: 'Search city',
                    hintStyle: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black38,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                       /* Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                              const MapScreen2()),
                        );*/
                      },
                      child: const Icon(
                        Icons.my_location,
                        size: 15,
                        color: Colors.black87,
                      ),
                    ),
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
                  const Text(
                    'Bangladesh',
                    style: TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 220,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 2,
                  ),
                  itemCount: countries.length,
                  itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () {
                      _toggleSelection(i);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Image.asset(
                            countries[i]['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          if (_selectedIndex == i)
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
                              child: Text(
                                countries[i]['name']!,
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
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 35,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        Fluttertoast.showToast(msg: 'Cities');
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedIndex == 0
                            ? AppColors.primaryColor
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Cities',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w700,
                            color: selectedIndex == 0
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 35,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                        Fluttertoast.showToast(msg: 'Call');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedIndex == 1
                            ? AppColors.primaryColor
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'States',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 15,
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w700,
                            color: selectedIndex == 1
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: selectedIndex == 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                        const Text(
                          'Delhi',
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 340,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 2,
                        ),
                        itemCount: cities.length,
                        itemBuilder: (ctx, i) => GestureDetector(
                          onTap: () => _showCityDetails(
                            context,
                            cities[i]['name']!,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.asset(
                                  cities[i]['image']!,
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
                                    child: Text(
                                      cities[i]['name']!,
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
                      ),
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
              Visibility(
                visible: selectedIndex == 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Select States:',
                      style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 600,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 2,
                        ),
                        itemCount: states.length,
                        itemBuilder: (ctx, i) => GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(msg: 'Click');
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.asset(
                                  states[i]['image']!,
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
                                    child: Text(
                                      states[i]['name']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
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
