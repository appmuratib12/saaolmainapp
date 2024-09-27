import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/app_colors.dart';
import 'BlogDetailPageScreen.dart';

class OurBlogsScreen extends StatefulWidget {
  const OurBlogsScreen({super.key});

  @override
  State<OurBlogsScreen> createState() => _OurBlogsScreenState();
}

class _OurBlogsScreenState extends State<OurBlogsScreen> {
  List<String> blogsArray = ["Blogs1", "Blog2", "Blog3"];
  List<String> blogArray2 = [
    "Heart Attack",
    "Heart Disease",
    "Lifestyle",
    "Cardiology",
    "Nutrition"
  ];
  int _selectedIndex = -1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Our Blogs',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _showCategoriesBottomSheet(); // Function to open bottom sheet
                },
                child: Container(
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.3), width: 0.3),
                  ),
                  child: const Center(
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 270,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: blogsArray.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                              const BlogDetailPageScreen()),
                        );
                        Fluttertoast.showToast(msg: 'click');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 250,
                              width: 260,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/blog_image_latest.jpg',
                                            fit: BoxFit.cover,
                                            height: 140,
                                            width: double.infinity,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.black.withOpacity(0.3),
                                                  Colors.transparent,
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                sigmaX: 0.3,
                                                sigmaY: 0.3,
                                              ),
                                              child: Container(
                                                color: Colors.black
                                                    .withOpacity(0.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const SizedBox(
                                      width: 250,
                                      child: Text(
                                        textAlign: TextAlign.start,
                                        'Essential Heart Tests for Early Detection: Safeguard Your Heart Health Now',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'FontPoppins',
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          size: 18,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'June 11, 2024',
                                          style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.black54,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '5 Minutes',
                                          style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Text(
                'Recommended for you',
                style: TextStyle(
                    fontFamily: 'FontPoppins',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: blogsArray.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Fluttertoast.showToast(msg: 'click');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 130,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: const SizedBox(
                                        height: 110,
                                        width: 130,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/blog_image1.jpg'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Expanded(
                                      // Used Expanded to prevent overflow
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Essential Heart Tests for Early Detection: Safeguard Your Heart Health Now',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'FontPoppins',
                                                fontSize: 12,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: 18,
                                                  color: Colors.black54,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('June 11, 2024',
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'FontPoppins',
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 13,
                                                        color: Colors.black54)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.access_time,
                                                  color: Colors.black54,
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('5 Minutes',
                                                    style: TextStyle(
                                                        fontFamily:
                                                        'FontPoppins',
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontSize: 13,
                                                        color: Colors.black54)),
                                              ],
                                            ),
                                          ],
                                        ),
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the bottom sheet dialog
  void _showCategoriesBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(child:Text(
                'Select Category',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily:'FontPoppins',
                  color:Colors.black,
                  fontSize: 18,
                ),
              ),),
              const SizedBox(height: 10), // Spacer between text and ListView
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: blogArray2.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:Image.asset(
                        'assets/icons/heart_rate_icon.png', // Path to your image
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        blogArray2[index],
                        style: const TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize:15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: 'Selected: ${blogArray2[index]}');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
