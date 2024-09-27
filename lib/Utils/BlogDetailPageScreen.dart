import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../constant/text_strings.dart';


class BlogDetailPageScreen extends StatefulWidget {
  const BlogDetailPageScreen({super.key});

  @override
  State<BlogDetailPageScreen> createState() => _BlogDetailPageScreenState();
}

class _BlogDetailPageScreenState extends State<BlogDetailPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Stack(
        children: [
          // Image at the top
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/blog_image_latest.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15, top: 190),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Center(
                      child: Icon(Icons.share,
                          color: AppColors.primaryDark, size: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                      child: Image(
                        image: AssetImage('assets/icons/save_icon.png'),
                        width: 20,
                        height: 20,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Blog content
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Blog Title
                      const Text(
                        'Essential Heart Tests for Early Detection: Safeguard Your Heart Health Now',
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // First paragraph
                      const Text(
                        blogTxt1,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Section Title
                      const Text(
                        'Understanding Heart Blockages and Coronary Artery Disease',
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Second paragraph
                      const Text(
                        blogTxt2,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Another Section Title
                      const Text(
                        'The Importance of Early Detection',
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Third paragraph
                      const Text(
                        blogTxt3,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Non-Invasive Heart Tests Section
                      const Text(
                        'Key Non-Invasive Heart Tests',
                        style: TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      // List of Tests
                      ..._buildHeartTests(),
                      SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Advanced Diagnostic Tests',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      ..._diagnosticsTest()
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

  List<Widget> _buildHeartTests() {
    List<String> tests = [
      '1. Electrocardiogram Test (ECG)',
      '2. Exercise Stress Test (TMT)',
      '3. Holter Monitoring Test',
      '4. Treadmill Test (TMT)',
    ];
    List<String> descriptions = [
      blogTxt4,
      blogTxt5, // Example: Add corresponding text strings for each test
      blogTxt6,
      blogTxt7,
    ];

    List<Widget> widgets = [];
    for (int i = 0; i < tests.length; i++) {
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tests[i],
              style: const TextStyle(
                fontFamily: 'FontPoppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              descriptions[i],
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontFamily: 'FontPoppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }
    return widgets;
  }

  List<Widget> _diagnosticsTest() {
    List<String> tests = [
      '1. Biochemistry Tests (Lipid Profile and Sugar)',
      '2. Angiography Test',
      '3. CT Angiography Test',
      '4. Treadmill Test (TMT)',
      '5. Thallium Scan/PET Scan Test',
    ];
    List<String> descriptions = [
      blogTxt4,
      blogTxt5, // Example: Add corresponding text strings for each test
      blogTxt6,
      blogTxt7,
      blogTxt8,
    ];

    List<Widget> widgets = [];
    for (int i = 0; i < tests.length; i++) {
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tests[i],
              style: const TextStyle(
                fontFamily: 'FontPoppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              descriptions[i],
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontFamily: 'FontPoppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }
    return widgets;
  }
}
