import 'package:flutter/material.dart';

import '../common/app_colors.dart';

class GoogleFitConnectScreen extends StatelessWidget {
  const GoogleFitConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icons

            // Title Text
            const Text(
              'Connect Google Fit with\n SAAOL',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/saool_logo.png', height: 80),
                // Replace with your stethoscope image path
                const SizedBox(width: 15),
                const Icon(Icons.more_horiz,
                    size: 60, color: AppColors.primaryColor),
                const SizedBox(width: 15),
                Image.asset('assets/icons/google_fit.png', height: 80),
                // Replace with your Google Fit image path
              ],
            ),

            const SizedBox(height: 30),

            // Description Text
            const Text.rich(
              TextSpan(
                text: 'Google Fit ', // Google Fit is bold
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'FontPoppins',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text:
                        'is an open platform that lets you control your fitness data from multiple apps and devices.',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'FontPoppins',
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            const Text.rich(
              TextSpan(
                text: 'By connecting Google Fit ',
                // Google Fit is bold
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize:14,
                  fontFamily: 'FontPoppins',
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:
                        'and Healthians, you can easily integrate your fitness activity like ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FontPoppins',
                        fontSize: 14,
                        color: Colors.black87),
                  ),
                  TextSpan(
                    text: 'Step Count', // Step Count is bold
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins',
                        fontSize: 16,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text:
                        ' from various sources to help you better understand your progress.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'FontPoppins',
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            const Text(
              'The battery life will not be affected',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'FontPoppins',
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Connect Button
            SizedBox(
              height: 42,
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  // Add your connection logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  // Use the same color as in the image
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'CONNECT',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Spacer(),
            const SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }
}
