import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
        title: const Text(
          'Testing',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width:105,
                      height:170,
                      decoration: BoxDecoration(
                        color:AppColors.primaryDark.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "Online",
                                  style: TextStyle(
                                    fontSize:14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'FontPoppins',
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Consultation",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'FontPoppins',
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(16),
                              ),
                              child: Image.asset(
                                'assets/images/female_dcotor.png',
                                width: 90,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width:10),
                    Container(
                      width:105,
                      height:170,
                      decoration: BoxDecoration(
                        color:AppColors.primaryDark.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Offline",
                                  style: TextStyle(
                                    fontSize:14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'FontPoppins',
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Consultation",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'FontPoppins',
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(16),
                              ),
                              child: Image.asset(
                                'assets/images/female_dcotor.png',
                                width: 90,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width:10),
                    Container(
                      width:105,
                      height:170,
                      decoration: BoxDecoration(
                        color:AppColors.primaryDark.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Nearest",
                                  style: TextStyle(
                                    fontSize:14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'FontPoppins',
                                    letterSpacing:0.2,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Centers",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'FontPoppins',
                                    letterSpacing:0.2,
                                    color: Colors.white70,
                                  ),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false,
                                    applyHeightToLastDescent: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(16),
                              ),
                              child: Image.asset(
                                'assets/images/female_dcotor.png',
                                width: 90,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}
