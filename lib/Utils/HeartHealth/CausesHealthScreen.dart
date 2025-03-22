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
            height: 300, // Adjust this height value as needed
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
                    Icons.arrow_back,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250.0),
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Heart Health Causes',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        causesTxt,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 20,
                            color: AppColors.primaryDark,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Diabetes',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          )
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 20,
                            color: AppColors.primaryDark,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Overweight and obesity',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          )
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 20,
                            color: AppColors.primaryDark,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Unhealthy diet',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          )
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 20,
                            color: AppColors.primaryDark,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Physical inactivity',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Causes Treatment',
                          style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        causesTxt2,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 270,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: causesTreatmentArray.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {

                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height:260,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.5),
                                          width: 0.4,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    'assets/images/lifestyle_Image.jpg',
                                                    fit: BoxFit.cover,
                                                    height: 100,
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
                                                        end:
                                                            Alignment.topCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
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
                                            SizedBox(
                                              width: 250,
                                              child: Text(
                                                textAlign: TextAlign.start,
                                                causesTreatmentArray[index],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'FontPoppins',
                                                  fontSize:14,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Container(
                                              constraints: const BoxConstraints(
                                                minHeight:70, // Set the minimum height as needed
                                              ),
                                              child: Text(
                                                titleTxt,
                                                style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                                maxLines: 4, // Limit the number of lines to handle long text
                                                overflow: TextOverflow.ellipsis, // Add ellipsis to indicate overflow
                                              ),
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
}
