import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/BlogsResponseData.dart';
import '../common/app_colors.dart';
import '../data/network/BaseApiService.dart';
import 'BlogDetailPageScreen.dart';

class OurBlogsScreen extends StatefulWidget {
  const OurBlogsScreen({super.key});

  @override
  State<OurBlogsScreen> createState() => _OurBlogsScreenState();
}

class _OurBlogsScreenState extends State<OurBlogsScreen> {
  List<String> blogsArray = ["Blogs1", "Blog2", "Blog3"];
  List<String> blogArray2 = [
    "Heart",
    "EECP Treatment",
    "EECP therapy",
    "Heart Disease",
    "Natural bypass surgery",
    "EECP",
  ];
  int _selectedIndex = -1;
  String selectedCategory = 'Heart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
                        color: Colors.grey.withOpacity(0.6), width: 0.4),
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
                child: FutureBuilder<BlogsResponseData>(
                  future: BaseApiService().blogsData(selectedCategory),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error fetching blogs: ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.blogs == null ||
                        snapshot.data!.blogs!.isEmpty) {
                      return const Center(child: Text('No blogs available.'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.blogs!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true)
                                  .push(CupertinoPageRoute(
                                builder: (context) => BlogDetailPageScreen(
                                    blogs: snapshot.data!.blogs![index]),
                              ));

                              Fluttertoast.showToast(msg: 'Clicked');
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 250,
                                    width: 260,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.5),
                                          width: 0.5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  snapshot
                                                      .data!.blogs![index].image
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  height: 140,
                                                  width: double.infinity,
                                                ),
                                              ),
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black
                                                            .withOpacity(0.3),
                                                        Colors.transparent,
                                                      ],
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              snapshot.data!.blogs![index].title
                                                  .toString(),
                                              style: const TextStyle(
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
                      );
                    }
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
                child: FutureBuilder<BlogsResponseData>(
                  future: BaseApiService().blogsData('Heart Disease'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error fetching blogs: ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.blogs == null ||
                        snapshot.data!.blogs!.isEmpty) {
                      return const Center(child: Text('No blogs available.'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.blogs!.length,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: SizedBox(
                                              height: 110,
                                              width: 130,
                                              child: Image(
                                                image: NetworkImage(snapshot
                                                    .data!.blogs![index].image
                                                    .toString()),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            // Used Expanded to prevent overflow
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data!.blogs![index]
                                                        .title
                                                        .toString(),
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'FontPoppins',
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                    ),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 7,
                                                  ),
                                                  const Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .calendar_month_outlined,
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
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black54)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.access_time,
                                                        color: Colors.black54,
                                                        size: 18,
                                                      ),

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
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
              const Center(
                child: Text(
                  'Select Category',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'FontPoppins',
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: blogArray2.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(
                        'assets/icons/heart_rate_icon.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        blogArray2[index],
                        style: const TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedCategory = blogArray2[index];
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
