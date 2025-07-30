import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../common/app_colors.dart';
import '../../constant/text_strings.dart';

class KnowYourHeartScreen extends StatefulWidget {
  const KnowYourHeartScreen({super.key});

  @override
  State<KnowYourHeartScreen> createState() => _KnowYourHeartScreenState();
}

class _KnowYourHeartScreenState extends State<KnowYourHeartScreen> {
  int initialLabelIndex = 0;
  final List<String> _contentList = [aboutTxtHeart, riskTxt, treatmentTxt];

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
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:220.0),
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
                        'What is Heart Attack?',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize:15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                       Text(
                        aboutHearAttackTxt.trim(),
                        style: const TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 12,
                            letterSpacing:0.2,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                         softWrap:true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(
                        child: Text(
                          'High Blood Pressure',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryDark),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ToggleSwitch(
                        minWidth: double.infinity,
                        cornerRadius: 20.0,
                        activeBgColors: const [
                          [AppColors.primaryDark],
                          [AppColors.primaryDark],
                          [AppColors.primaryDark],
                        ],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.blue[50],
                        inactiveFgColor: AppColors.primaryDark,
                        initialLabelIndex: initialLabelIndex,
                        totalSwitches: 3,
                        labels: const [
                          'About',
                          'Risk',
                          'Treatments',
                        ],
                        customTextStyles: const [
                          TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                          ),
                          TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                          ),
                          TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                        radiusStyle: true,
                        onToggle: (index) {
                          setState(() {
                            initialLabelIndex = index!;
                          });
                          print('switched to: $index');
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                              color: AppColors.primaryColor, width: 0.4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _contentList[initialLabelIndex],
                              style: const TextStyle(
                                fontSize: 12,
                                letterSpacing:0.2,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      /*const Text(
                        'Video Gallery',
                        style: TextStyle(
                            fontFamily: 'FontPoppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      )*/
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
