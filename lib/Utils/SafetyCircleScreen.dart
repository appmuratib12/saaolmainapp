import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';

class SafetyCircleScreen extends StatefulWidget {
  const SafetyCircleScreen({super.key});

  @override
  State<SafetyCircleScreen> createState() => _SafetyCircleScreenState();
}

class _SafetyCircleScreenState extends State<SafetyCircleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'SAAOL Safety Circle',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(
              height: 20,
              thickness: 8,
              color: Colors.lightBlue[50],
            ),
            const Image(
              image: AssetImage('assets/icons/safety_circle.jpg'),
              height: 270,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    safetyTxt,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        fontSize:14,
                        color: Colors.black87),
                  ),
                  SizedBox(height:15,),
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Red (means high risk)',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black87),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Red (means high risk)',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black87),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Green (lowest risk or reversal)',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black87),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
