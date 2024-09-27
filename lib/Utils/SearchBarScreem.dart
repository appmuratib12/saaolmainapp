import 'package:flutter/material.dart';
import '../common/app_colors.dart';



class SearchScreen extends StatelessWidget {
  final TextEditingController searchController;

  const SearchScreen({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> hospitals = [
      {
        'title': 'SAAOl Heart Center, Chhattarpur, New Delhi',
        'address':
            'Westend DLF, Farm No.5, Mandi Road, Chhattarpur, New Delhi - 110030'
      },
      {
        'title': 'SAAOl Heart Center,Kailash Colony, New Delhi',
        'address':
            'E-3, Kailash Colony Rd, Block E, Kailash Colony, New Delhi, Delhi 110048.'
      },
      {
        'title': 'SAAOl Heart Center,Nirman Vihar,New Delhi',
        'address': 'A-27, Nirman Vihar, Delhi - 110092'
      },
      {
        'title': 'SAAOl Heart Center, Pitampura',
        'address':
            'A-8, Fourth Floor, Service Rd, near Navjeevan Hospital, Pushpanjali Enclave, Pitampura, Delhi, 110034'
      },
      {
        'title': 'SAAOl Heart Center, New Rajender Nagar',
        'address':
            'SAAOL Heart Center, R Block- R-559, New Rajender Nagar, New Delhi – 110060'
      },
      {
        'title': 'SAAOl Heart Center, Dwarka',
        'address':
            'Flat No 42, Ground Floor, Netaji Subhash Apartment, Pocket 1, Phase 2, Sector 13, Dwarka New Delhi-110078'
      },
    ];



    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 16,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            /* Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation:2,
              child: Container(
                height:50,
                width: double.infinity,
                decoration:BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Light black shadow
                      blurRadius: 6, // Softening the shadow
                      offset: Offset(0, 3), // Horizontal and Vertical position
                    ),
                  ],
                ),
                child: Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Find Our nearest centers...',
                      hintStyle: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black38,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 13.0),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      // Implement search functionality
                    },
                  ),
                ),
              ),
            ),*/

            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Light black shadow
                    blurRadius: 6, // Softening the shadow
                    offset:
                        const Offset(0, 2), // Horizontal and Vertical position
                  ),
                ],
              ),
              child: Container(
                height: 45.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Find Our nearest centers...',
                    hintStyle: const TextStyle(
                      fontFamily: 'FontPoppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black38,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                      size: 25,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.my_location,
                        color: AppColors.primaryDark,
                        size: 20,
                      ),
                      onPressed: () {
                        // Handle location icon press
                      },
                    ),
                  ),
                  onChanged: (value) {
                    // Implement search functionality
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 3,
              child: Container(
                height: 630,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 620,
                      child: ListView.builder(
                        itemCount: hospitals.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hospitals[index]['title']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      fontFamily: 'FontPoppins',
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  hospitals[index]['address']!,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                      fontFamily: 'FontPoppins'),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                  height: 24.0,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
  );
}
