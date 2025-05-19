import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import 'HeartHealth/AssessRiskScreen.dart';
import 'HeartHealth/CausesHealthScreen.dart';
import 'HeartHealth/KnowYourHeartScreen.dart';
import 'HeartHealth/OverviewScreen.dart';

class HeartHealthScreen extends StatefulWidget {
  const HeartHealthScreen({super.key});

  @override
  State<HeartHealthScreen> createState() => _HeartHealthScreenState();
}

class _HeartHealthScreenState extends State<HeartHealthScreen> {
  List<String> healthArray = [
    "Overview",
    "Assess Risk",
    "Know Your Heart",
    "Heart Health Causes",
  ];

  List<IconData> healthIcons = [
    Icons.info_outline,
    Icons.assignment,
    Icons.favorite,
    Icons.local_hospital,
    Icons.book
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Heart Health',
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
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 500,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: healthArray.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const OverviewScreen()),
                            );
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const HeartHealthAssessmentForm()),
                            );
                            break;
                          case 2:
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const KnowYourHeartScreen()),
                            );
                            break;
                          case 3:
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const CausesHealthScreen()),
                            );
                            break;
                          default:
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Icon(
                                      healthIcons[index],
                                      color: AppColors.primaryColor,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        healthArray[index],
                                        style: const TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontSize:14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: AppColors.primaryDark,
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
    );
  }
}
