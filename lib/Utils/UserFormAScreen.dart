import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../constant/text_strings.dart';


class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  List<String> faqsArray = [

    "Can we take appointment online?",
    "What is EECP treatment?",
    "Who is Dr. Bimal Chhajer?",
    "How to find the nearest center?",
    "What are the benefits of Zero Oil Cooking?",
    "What is the SAAOL Detox program?"
  ];

  List<Map<String, String>> faqsArray2 = [
    {
      "title": "Can we take appointment online?",
      "description": faqsTxt1,
      "icon": "assets/icons/appointment_icon.png"
    },
    {
      "title": "What is EECP treatment?",
      "description": faqsTxt2,
      "icon": "assets/icons/appointment_icon.png"
    },
    {
      "title": "Who is Dr. Bimal Chhajer?",
      "description": faqsTxt3,
      "icon": "assets/icons/appointment_icon.png"
    },
    {
      "title": "How to find the nearest center?",
      "description": faqsTxt4,
      "icon": "assets/icons/appointment_icon.png"
    },
    {
      "title": "What are the benefits of Zero Oil Cooking?",
      "description": faqsTxt5,
      "icon": "assets/icons/appointment_icon.png"
    },
    {
      "title": "What is the SAAOL Detox program?",
      "description": faqsTxt6,
      "icon": "assets/icons/appointment_icon.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "FAQ'S",
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
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: faqsArray2.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ExpansionTileCard(
                    leading: Image.asset('assets/icons/question_icon.png',
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      faqsArray2[index]["title"]!,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'FontPoppins',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    children: <Widget>[
                      const Divider(thickness: 1.0, height: 1.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            faqsArray2[index]["description"]!,
                            textAlign: TextAlign.justify,
                            style:  const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'FontPoppins',
                              fontSize: 14,
                              color: AppColors.primaryColor,
                            ),
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
      ),
    );
  }
}
