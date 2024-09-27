import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';

class PatientInstructionScreen extends StatefulWidget {
  const PatientInstructionScreen({super.key});

  @override
  State<PatientInstructionScreen> createState() =>
      _PatientInstructionScreenState();
}

class _PatientInstructionScreenState extends State<PatientInstructionScreen> {
  final List<Map<String, String>> items = [
    {
      "title": "Walk Everyday",
      "description": therapyTxt1,
      "icon": "assets/icons/walk_everyday_icon.png",
    },
    {
      "title": "Yoga",
      "description": therapyTxt2,
      "icon": "assets/icons/yoga_icon.png",
    },
    {
      "title": "Animal Foods",
      "description": therapyTxt2,
      "icon": "assets/icons/animal_food.png",
    },
    {
      "title": "Diabetes",
      "description": therapyTxt2,
      "icon": "assets/icons/diabetes.png",
    },
    {
      "title": "Medications",
      "description": therapyTxt2,
      "icon": "assets/icons/heartbeat_icon.png",
    },

    {
      "title": "Lipid Profile",
      "description": therapyTxt2,
      "icon": "assets/icons/heartbeat_icon.png",
    },
    {
      "title": "Smoking/Tobacco",
      "description": therapyTxt2,
      "icon": "assets/icons/heartbeat_icon.png",
    },
    {
      "title": "Stress",
      "description": therapyTxt2,
      "icon": "assets/icons/heartbeat_icon.png",
    },
    // Add more items with respective icons
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Instructions for Patient's",
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
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
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 0.5,
                        ),
                      ),
                      child: ExpansionTile(
                        leading: Image.asset(
                          items[index]['icon']!,
                          width: 30,
                          height: 30,
                        ),
                        title: Text(
                          items[index]['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              items[index]['description']!,
                              style: const TextStyle(
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
