import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';


class AboutSAAAOLScreen extends StatefulWidget {
  const AboutSAAAOLScreen({super.key});

  @override
  State<AboutSAAAOLScreen> createState() => _AboutSAAAOLScreenState();
}

class _AboutSAAAOLScreenState extends State<AboutSAAAOLScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'About SAAOL',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/about_us.jpg',
              width: double.infinity,
              height: 220,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            aboutSAAOLTxt,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'FontPoppins',
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoCard(
            title: "Our Vision",
            icon: 'assets/icons/vision.png',
            description: visionTxt,
          ),
          _buildInfoCard(
            title: "Our Mission",
            icon: 'assets/icons/target.png',
            description: missionTxt,
          ),
          _buildInfoCard(
            title: "Our Values",
            icon: 'assets/icons/values.png',
            description: valuesTxt,
          ),
        ],
      ),
    );
  }


  Widget _buildInfoCard({
    required String title,
    required String icon,
    required String description,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      color:Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue[50],
              child: Image.asset(icon, height: 40, width: 40),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description.trim(),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
