import 'dart:ui';
import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../constant/text_strings.dart';

class CausesHealthScreen extends StatefulWidget {
  const CausesHealthScreen({super.key});

  @override
  State<CausesHealthScreen> createState() => _CausesHealthScreenScreenState();
}

class _CausesHealthScreenScreenState extends State<CausesHealthScreen> {
  int initialLabelIndex = 0;
  List<String> causesTreatmentArray = [
    "Education & Lifestyle Management",
    "Optimum Allopathic Medical Manag ement",
    "Natural Bypass or ECP/EECP",
    "Saaol Detox Therapy"
  ];
  String titleTxt = "Modern medicines from the Allopathic system are prescribed to heart patients to reduce Angina & other risk factors.";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height:400, // Adjust this height value as needed
            width: MediaQuery.of(context).size.width,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage('assets/images/human_heart1.jpg'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 210.0),
            child: Container(
              decoration:  BoxDecoration(
                borderRadius:const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.grey[200],
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding:const EdgeInsets.all(16),
                        child:Column(crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Heart Health Causes',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            causesTxt.trim(),
                            style: const TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 12,
                                letterSpacing:0.2,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHealthPoint('Diabetes', isBold: true, textColor: Colors.black87),
                              _buildHealthPoint('Overweight and obesity',isBold: true, textColor: Colors.black87),
                              _buildHealthPoint('Unhealthy diet',isBold: true, textColor: Colors.black87),
                              _buildHealthPoint('Physical inactivity',isBold: true, textColor: Colors.black87),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('Causes Treatment',
                              style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            causesTxt2.trim(),
                            style: const TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 12,
                                letterSpacing:0.2,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                       ),
                      ),
                      SizedBox(
                        height: 270,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: causesTreatmentArray.length,
                          padding:const EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // Handle tap
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                child: Container(
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12.withOpacity(0.08),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Image
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                        child: Stack(
                                          children: [
                                            Image.asset(
                                              'assets/images/lifestyle_Image.jpg',
                                              fit: BoxFit.cover,
                                              height: 110,
                                              width: double.infinity,
                                            ),
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black.withOpacity(0.3),
                                                      Colors.transparent
                                                    ],
                                                    begin: Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Content
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Title
                                            Text(
                                              causesTreatmentArray[index],
                                              style: const TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                            const SizedBox(height: 6),

                                            // Subtitle or Description
                                            Text(
                                              titleTxt,
                                              style: const TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black54,
                                                height: 1.4,
                                              ),
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height:50,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildHealthPoint(String title, {bool isBold = false, Color textColor = Colors.black54}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:3.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            size: 22,
            color: AppColors.primaryDark,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'FontPoppins',
                fontSize:13,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
