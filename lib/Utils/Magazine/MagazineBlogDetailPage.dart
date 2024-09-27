import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import 'SAAOLEMagzineDetailScreen.dart';

class MagazineBlogDetailPage extends StatefulWidget {
  const MagazineBlogDetailPage({super.key});

  @override
  State<MagazineBlogDetailPage> createState() => _MagazineBlogDetailPageState();
}

class _MagazineBlogDetailPageState extends State<MagazineBlogDetailPage> {
  List<String> eventArray = [
    "The Need for Non-Invasive Heart Treatments",
    "The Need for Non-Invasive Heart Treatments"
  ];

  List<String> magazineBlogsArray = [
    "Explore Why Heart Patients Are Taking a Closer Look at Diabetes",
    "Lifelong Heart Health: Practical Advice and Tips",
    "Unlocking the Importance of a Heart-Nourishing Lifestyle for Cardiovascular Wellness",
    "Does Summer Heat Stress the Heart?",
    "Transforming Heart Care: Discover Non-Invasive Heart Treatment Options"
  ];

  List<String> talkArray = [
    "The American Society of Preventive Cardiology Annual Conference in Salt Lake City was a landmark event, showcasing groundbreaking discussions on cardiovascular prevention and fostering.",
    "In New Jersey, key insights into preventive cardiology were shared with an engaged audience committed to advancing heart health. The exchange of knowledge and ideas fostered meaningful connections.",
    "The visit to BAPS Swaminarayan Akshardham in the USA offered a profound moment of spiritual reflection, significantly enriching the journey in heart health..",
    "Meeting the visionary Dr. Dean Ornish in the USA was a defining moment in the journey of heart health exploration. This extraordinary encounter, coupled with the vibrant landscapes and dynamic culture of the USA."
  ];

  int selectedIndex = 0;

  List<String> newsCategoriesArray = [
    "All",
    "New Center",
    "Punyya heart Foundation",
    "Patient Reviews",
    "SAAOL Webinar"
  ];

  List<String> newsTitleArray = [
    "How to prevent and reverse heart diseases with Diet & Lifestyle Changes by Dr. Bimal Chhajer",
    "Upcoming:Your Guide to Reverse heart Diseases with Dr. Bimal Chhajer"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'SAAOL E-Magzine Detail',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
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
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: magazineBlogsArray.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const SAAOLlEMagazineDetailScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 190,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8.0),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/heart_blog_image.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 60,
                                      // Adjust the height as needed
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(1),
                                          ],
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          bottom: Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: Text(
                                        magazineBlogsArray[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'FontPoppins',
                                          fontSize: 12,
                                        ),
                                        // Ensure the text is visible
                                        textAlign: TextAlign.center,
                                        // Center-align the text
                                        overflow: TextOverflow.ellipsis,
                                        // Handle overflow
                                        maxLines:
                                            2, // Limit the text to 2 lines
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(
                height: 15,
                thickness: 0.5,
                color: Colors.grey,
              ),
              const Text(
                "Dr. Bimal Chhajer Talk's",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 290,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: talkArray.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 2,
                          child: Container(
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/sonakshi_marriage.jpg',
                                    fit: BoxFit.cover,
                                    height: 140,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.justify,
                                        talkArray[index],
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        maxLines: 5,
                                        // Limit to 2 lines
                                        overflow: TextOverflow.ellipsis,
                                        // Show ellipsis if text overflows
                                        softWrap: true,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'by SAAOL  July, 2024',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily: 'FontPoppins',
                                            color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(
                height: 15,
                thickness: 0.5,
                color: Colors.grey,
              ),
              const Text(
                'SAAOL News',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsCategoriesArray.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedIndex;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index; // Update the selected index
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Container(
                                height: 37,
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.4),
                                    width: 0.4,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(
                                      newsCategoriesArray[index].toUpperCase(),
                                      // Convert text to uppercase
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
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
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: newsTitleArray.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          elevation: 2,
                          child: Container(
                            height: 270,
                            width: 270,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                    'assets/images/opening_image.jpg',
                                    fit: BoxFit.cover,
                                    height: 170,
                                    width: double.infinity,
                                  ),
                                ),
                                // Use Expanded to make the Column take up the remaining space
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          newsTitleArray[index],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          'by SAAOL  June, 2024',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Expanded(
                                          child: Text(
                                            newsTitleArray[index],
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    'SAAOL Zero oil Recipe of the month',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'FontPoppins',
                        color: Colors.black),
                  ),
                  Expanded(child: Container()),
                  const Text(
                    'View All',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: 'FontPoppins',
                        color: AppColors.primaryColor),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
