import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaoldemo/common/app_colors.dart';
import 'HeartRateMeasurement.dart';

class HeartRateScreen extends StatelessWidget {
  const HeartRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Heart beats per minute',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            // Circle with Image/Icon
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor, width: 3),
              ),
              child: const Center(
                child: Icon(
                  Icons.fingerprint_outlined,
                  size: 60,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Title Text "How to measure?"
            const Text(
              'How to Measure?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: 'FontPoppins',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            // Instructional Text
            const Text(
              'Gently place your finger over the camera lens.\n'
              'Make sure to completely cover the camera lens and flash.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'FontPoppins',
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Don\'t press too hard.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
                fontFamily: 'FontPoppins',
              ),
            ),
            const Spacer(),
            // Last Result Row
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 28,
                ),
                SizedBox(width: 8),
                Text(
                  'Last Result: 79 bpm',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            // Date and Time of Last Measurement
            const Text(
              '3rd Oct 09:56 am',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'FontPoppins',
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            // Start Measurement Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const HeartRateMonitor()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark, // Background color
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Start Measurement',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FontPoppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
