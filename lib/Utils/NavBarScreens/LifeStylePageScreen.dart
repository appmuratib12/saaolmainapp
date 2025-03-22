import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../constant/text_strings.dart';
import '../AppointmentsScreen.dart';

class LifeStylePageScreen extends StatefulWidget {
  final String id;
  const LifeStylePageScreen({super.key,required this.id});

  @override
  State<LifeStylePageScreen> createState() => _LifeStylePageScreenState();
}

class _LifeStylePageScreenState extends State<LifeStylePageScreen> {
  List lifeStyleArray = [
    "https://saaol.com/psd//assets/images/about/home/young-beautiful-woman-doing-yoga.jpg",
    "https://thumbs.dreamstime.com/b/senior-african-american-woman-senior-biracial-woman-smiling-doing-yoga-outdoors-senior-african-american-woman-309471417.jpg",
  ];

  final List<IconData> icons = [
    Icons.ac_unit_rounded,
    Icons.ac_unit_rounded,
    Icons.ac_unit_rounded,
    Icons.ac_unit_rounded,
    Icons.ac_unit_rounded,
  ];

  final List<String> titles = [
    'Holistic Nutrition:',
    'Gentle Approach',
    'Addressing Cardiac Blockages Naturally',
    'Increased Vitality',
    'Refined Blood Circulation',
  ];

  final List<String> subtitles = [
    'Our highly-specialized team firmly believes in non-invasive methods for treating heart-related problems across ',
    'Our highly-specialized team firmly believes in non-invasive methods for treating heart-related problems across ',
    'Our highly-specialized team firmly believes in non-invasive methods for treating heart-related problems across ',
    'Our highly-specialized team firmly believes in non-invasive methods for treating heart-related problems across ',
    'Our highly-specialized team firmly believes in non-invasive methods for treating heart-related problems across ',
  ];

  final List<bool> isCompleted = [
    true,
    true,
    true,
    true,
    true,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'LIFE STYLE',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 260, // Adjust this height value as needed
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      child: CarouselSlider(
                        items: lifeStyleArray.map((imagePath) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset("assets/logo.png");
                              },
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 240, // Adjust this height value as needed
                          autoPlay: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              /*carouselController.previousPage(
                                curve: Curves.easeIn,
                              );*/
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(.5),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              /*carouselController.nextPage(
                                curve: Curves.easeIn,
                              );*/
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(.5),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 210.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Embrace Heart Wellness:',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColors.primaryColor),
                          ),
                          Text(
                            'Heart Yoga and a Healthy Lifestyle for Your Heart',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            textAlign: TextAlign.justify,
                            'Welcome to the world of SAAOL’s Heart Healthy Lifestyle, your portal to a holistic approach to nurturing your heart’s health. We firmly believe that the path to a heart-healthy existence extends far beyond conventional treatments',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 15,
                      thickness: 5,
                      color: Colors.lightBlue[50],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Our Main Treatment',
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: AppColors.primaryColor),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            lifeStyleTxt,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 550, // Set a height for ListView
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: titles.length,
                              itemBuilder: (context, index) {
                                return _buildTimelineTile(
                                  icon: icons[index],
                                  title: titles[index],
                                  subTitle: subtitles[index],
                                  isCompleted: isCompleted[index],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                        width: 0.4, color: Colors.grey.withOpacity(0.6)),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const MyAppointmentsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Book Appointment',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                iconSize: 25,
                icon: const Icon(
                  Icons.call,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineTile({
    required IconData icon,
    required String title,
    required bool isCompleted,
    required String subTitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              icon,
              color: isCompleted ? AppColors.primaryColor : Colors.grey,
            ),
            Container(
              height: 80,
              width: 2,
              color: isCompleted ? AppColors.primaryColor : Colors.grey,
            ),
          ],
        ),
        const SizedBox(width: 13),
        Expanded(
          // Wrap the text column in an Expanded widget
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'FontPoppins',
                    color: Colors.black),
              ),
              Text(
                subTitle,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.black54,
                    letterSpacing: 0.1),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
