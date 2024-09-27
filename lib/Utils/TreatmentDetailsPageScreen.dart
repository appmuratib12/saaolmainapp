import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';
import 'AppointmentBookScreen.dart';

class TreatmentDetailsPageScreen extends StatefulWidget {
  const TreatmentDetailsPageScreen({super.key});

  @override
  State<TreatmentDetailsPageScreen> createState() =>
      _TreatmentDetailsPageScreenState();
}

class _TreatmentDetailsPageScreenState
    extends State<TreatmentDetailsPageScreen> {
  //CarouselController carouselController = CarouselController();
  List treatmentImages = [
    "https://d3b6u46udi9ohd.cloudfront.net/wp-content/uploads/2022/09/29102307/shutterstock_2108038193.jpg",
    "https://www.mirakleihc.com/wellness_admin/resource/uploads/srcimg/1MYiNSWnzn23032024025902mirakle-eecp.jpeg",
    'https://saaol.com/assets/images/eecp-treatment/Benefits-of-EECP.png',
    'https://saaol.com/assets/images/eecp-treatment/eecp-treatment-3.png',
    'https://3.imimg.com/data3/AC/GP/MY-9507883/eecp-500x500.jpg'
  ];
  final List<Map<String, String>> items = [
    {
      "title": "Exclusion from Invasive Procedures",
      "description": therapyTxt1,
    },
    {
      "title": "High-Risk Profiles",
      "description": therapyTxt2,
    },
    {
      "title": "Medication Efficacy Waning",
      "description": therapyTxt3,
    },
    {
      "title": "Post-Invasive Procedure Resurgence",
      "description": therapyTxt4,
    },
    {
      "title": "Infeasibility or High Surgical Risk",
      "description": therapyTxt5,
    },
    {
      "title": "Persistent Chest Discomfort",
      "description": therapyTxt6,
    },
    {
      "title": "Complex Coronary Architecture",
      "description": therapyTxt7,
    },
  ];
  List<String> zeroOilArray = [
    'Steaming',
    'Baking & Roasting',
    'Grilling',
    'Stir-Frying Without Oil',
    'Air Frying',
    'Pureeing and Blending:',
    ''
  ];

  @override
  Widget build(BuildContext context) {
    bool isExpanded = false;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'EECP Treatment',
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
      backgroundColor: Colors.white,
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
                   /* ClipRRect(
                      child: CarouselSlider(
                        carouselController: carouselController,
                        items: treatmentImages.map((imagePath) {
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
                    ),*/
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
                            'Revolutionizing Heart Health: EECP Treatment at SAAOL Heart Center',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColors.primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            aboutEECPTxt,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 8,
                          )
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
                          const Text(
                            'Key advantages of EECP treatment',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              _buildTimelineTile(
                                icon: Icons.check_circle,
                                title: 'Effective Cardiac Care',
                                subTitle: advantageTxt1,
                                isCompleted: true,
                              ),
                              _buildTimelineTile(
                                icon: Icons.check_circle,
                                title: 'Gentle Approach ',
                                subTitle: advantageTxt2,
                                isCompleted: true,
                              ),
                              _buildTimelineTile(
                                icon: Icons.check_circle,
                                title:
                                    'Addressing Cardiac Blockages Naturally ',
                                subTitle: advantageTxt3,
                                isCompleted: true,
                              ),
                              _buildTimelineTile(
                                icon: Icons.check_circle,
                                title: 'Increased Vitality',
                                subTitle: advantageTxt4,
                                isCompleted: true,
                              ),
                              _buildTimelineTile(
                                icon: Icons.check_circle,
                                title: 'Refined Blood Circulation',
                                subTitle: advantageTxt5,
                                isCompleted: true,
                              ),
                            ],
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Revolutionizing Heart Health: EECP Treatment at SAAOL Heart Center',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColors.primaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            therapyTxt,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 8,
                          ),
                          SizedBox(
                            height: 470,
                            child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.3),
                                            width: 0.3)),
                                    child: ExpansionTile(
                                      title: Text(
                                        items[index]['title']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'FontPoppins',
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            items[index]['description']!,
                                            style: const TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.black87),
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
                    Divider(
                      height: 15,
                      thickness: 5,
                      color: Colors.lightBlue[50],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue[50],
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Preparing for EECP Therapy: A Journey Towards Heart Wellness',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: AppColors.primaryColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    preparingEECPTxt,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.black54),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 8,
                                  ),
                                ],
                              ),
                            ),
                            _buildSectionTitle(
                                'Before EECP therapy: The Foundation for Best Heart Blockage Treatment'),
                            _buildParagraph(preparingEECPTxt1),
                            _buildParagraph(preparingEECPTxt2),
                            _buildSectionTitle(
                                'During EECP Therapy: The Heart’s Renewal'),
                            _buildParagraph(preparingEECPTxt3),
                            _buildParagraph(preparingEECPTxt4),
                            _buildSectionTitle(
                                'After EECP Therapy: Nurturing Heart Health Beyond the Sessions'),
                            _buildParagraph(preparingEECPTxt5),
                            _buildParagraph(preparingEECPTxt6),
                          ]),
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
                          const Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Mastering the Art of Zero-Oil Cooking: Creative Techniques and Recipes',
                                  style: TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ExpandableNotifier(
                            child: ScrollOnExpand(
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0),
                                      ),
                                      child: Image.asset(
                                        'assets/icons/Steaming.jpg',
                                        height: 140.0,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    ExpandablePanel(
                                      theme: const ExpandableThemeData(
                                        tapBodyToExpand: true,
                                        tapBodyToCollapse: true,
                                        hasIcon: true,
                                      ),
                                      header: const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text(
                                          'Steaming',
                                          style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      collapsed: Container(),
                                      expanded: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 5.0),
                                                  height: 7,
                                                  width: 7,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Flexible(
                                                  child: Text(
                                                    'Steaming is a fantastic way to preserve the natural flavors and nutrients in your food.',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontFamily: 'FontPoppins',
                                                      fontSize: 13,
                                                      letterSpacing: 0.1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 7),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 5.0),
                                                  height: 7,
                                                  width: 7,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Flexible(
                                                  child: Text(
                                                    'Steaming is a fantastic way to preserve the natural flavors and nutrients in your food.',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontFamily: 'FontPoppins',
                                                      fontSize: 13,
                                                      letterSpacing: 0.1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 7),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 5.0),
                                                  height: 7,
                                                  width: 7,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Flexible(
                                                  child: Text(
                                                    'Steaming is a fantastic way to preserve the natural flavors and nutrients in your food.',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontFamily: 'FontPoppins',
                                                      fontSize: 13,
                                                      letterSpacing: 0.1,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
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
                            ),
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
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 340,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.primaryColor,
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'What are some healthy food recipes without Oil',
                                    style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              healthyFoodTxt,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ExpandableNotifier(
                        child: ScrollOnExpand(
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                  child: Image.asset(
                                    'assets/icons/kurkuri.png',
                                    height: 140.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                ExpandablePanel(
                                  theme: const ExpandableThemeData(
                                    tapBodyToExpand: true,
                                    tapBodyToCollapse: true,
                                    hasIcon: true,
                                  ),
                                  header: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      'Zero Oil Kurkuri Bhindi',
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  collapsed: Container(),
                                  expanded: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5.0),
                                              height: 7,
                                              width: 7,
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const Flexible(
                                              child: Text(
                                                'Steaming is a fantastic way to preserve the natural flavors and nutrients in your food.',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontSize: 13,
                                                  letterSpacing: 0.1,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 7),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5.0),
                                              height: 7,
                                              width: 7,
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const Flexible(
                                              child: Text(
                                                'Steaming is a fantastic way to preserve the natural flavors and nutrients in your food.',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontSize: 13,
                                                  letterSpacing: 0.1,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 7),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5.0),
                                              height: 7,
                                              width: 7,
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            const Flexible(
                                              child: Text(
                                                'Steaming is a fantastic way to preserve the natural flavors and nutrients in your food.',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontSize: 13,
                                                  letterSpacing: 0.1,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
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
                        ),
                      ),
                    )
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
                                    const AppointmentBookScreen()),
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
                onPressed: () {
                  Fluttertoast.showToast(msg: 'Call');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
          fontFamily: 'FontPoppins',
        ),
      ),
    );
  }

  Widget _buildParagraph(String title) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        textAlign: TextAlign.justify,
        title,
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
            fontFamily: 'FontPoppins',
            letterSpacing: 0.1),
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
