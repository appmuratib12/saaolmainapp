import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saaoldemo/Utils/AppointmentsScreen.dart';
import 'package:saaoldemo/data/network/BaseApiService.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../data/model/apiresponsemodel/TreatmentsDetailResponseData.dart';


class TreatmentDetailsPageScreen extends StatefulWidget {
  final String id;
  const TreatmentDetailsPageScreen({super.key,required this.id});

  @override
  State<TreatmentDetailsPageScreen> createState() =>
      _TreatmentDetailsPageScreenState();
}

class _TreatmentDetailsPageScreenState
    extends State<TreatmentDetailsPageScreen> {
  List treatmentImages = [
    "https://d3b6u46udi9ohd.cloudfront.net/wp-content/uploads/2022/09/29102307/shutterstock_2108038193.jpg",
    "https://www.mirakleihc.com/wellness_admin/resource/uploads/srcimg/1MYiNSWnzn23032024025902mirakle-eecp.jpeg",
    'https://saaol.com/assets/images/eecp-treatment/Benefits-of-EECP.png',
    'https://saaol.com/assets/images/eecp-treatment/eecp-treatment-3.png',
    'https://3.imimg.com/data3/AC/GP/MY-9507883/eecp-500x500.jpg'
  ];
  final List<Map<String, String>> items = [
    {
      "title": "Exclusion from Invasive Procedures",
      "description": therapyTxt1,
    },
    {
      "title": "High-Risk Profiles",
      "description": therapyTxt2,
    },
    {
      "title": "Medication Efficacy Waning",
      "description": therapyTxt3,
    },
    {
      "title": "Post-Invasive Procedure Resurgence",
      "description": therapyTxt4,
    },
    {
      "title": "Infeasibility or High Surgical Risk",
      "description": therapyTxt5,
    },
    {
      "title": "Persistent Chest Discomfort",
      "description": therapyTxt6,
    },
    {
      "title": "Complex Coronary Architecture",
      "description": therapyTxt7,
    },
  ];
  List<String> zeroOilArray = [
    'Steaming',
    'Baking & Roasting',
    'Grilling',
    'Stir-Frying Without Oil',
    'Air Frying',
    'Pureeing and Blending:',
    ''
  ];
  CarouselController carouselController = CarouselController();


  _makingPhoneCall() async {
    var url = Uri.parse("tel:8447776000");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  String extractDescription(String description) {
    List<String> paragraphs = description.split('\r\n');
    if (paragraphs.isNotEmpty) {
      return paragraphs.first.trim();
    }
    return description;
  }

  List<Map<String, String>> extractAdvantageDetails(String advantage) {
    List<Map<String, String>> advantageList = [];
    List<String> sections =
    advantage.split('\r\n\r\n'); // Split sections by double line breaks

    for (String section in sections) {
      List<String> titleAndDescription =
      section.split(':'); // Split title and description by ':'
      if (titleAndDescription.length == 2) {
        String title = titleAndDescription[0].trim();
        String description = titleAndDescription[1].trim();
        advantageList.add({'title': title, 'description': description});
      }
    }
    return advantageList;
  }
  List<Map<String, String>> extractDisadvantageDetails(String advantage) {
    List<Map<String, String>> advantageList = [];
    List<String> sections =
    advantage.split('\r\n\r\n'); // Split sections by double line breaks

    for (String section in sections) {
      List<String> titleAndDescription =
      section.split(':'); // Split title and description by ':'
      if (titleAndDescription.length == 2) {
        String title = titleAndDescription[0].trim();
        String description = titleAndDescription[1].trim();
        advantageList.add({'title': title, 'description': description});
      }
    }
    return advantageList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'EECP Treatment',
          style: TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          SizedBox(
            height: 260, // Adjust this height value as needed
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      child: CarouselSlider(
                        items: treatmentImages.map((imagePath) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset("assets/logo.png");
                              },
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 240, // Adjust this height value as needed
                          autoPlay: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              /*carouselController.previousPage(
                                curve: Curves.easeIn,
                              );*/
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(.5),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              /*carouselController.nextPage(
                                curve: Curves.easeIn,
                              );*/
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(.5),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 210.0),
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
              child:  FutureBuilder<TreatmentsDetailResponseData>(
                future:BaseApiService().getTreatmentDetailsData(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error loading data"),
                    );
                  } else if (snapshot.hasData) {
                    String fullDescription = snapshot.data!.data!.description ?? '';
                    String advantage = snapshot.data!.data!.advantage ?? '';
                    String disadvantage = snapshot.data!.data!.disadvantge ?? '';
                    List<Map<String, String>> advantageList = extractAdvantageDetails(advantage);
                    List<Map<String, String>> disadvantageList = extractDisadvantageDetails(disadvantage);
                    List<String> sections = fullDescription.split('\r\n');
                    List<String> headings = [];
                    List<String> contents = [];

                    for (int i = 0; i < sections.length; i++) {
                      if (i % 2 == 0) {
                        headings.add(sections[i]);
                      } else {
                        contents.add(sections[i]);
                      }
                    }

                    return SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(headings.length, (index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      headings[index],
                                      style: const TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      contents.length > index ? contents[index] : '',
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 20), // Space between sections
                                  ],
                                );
                              }),
                            ),
                          ),
                          Divider(
                            height: 15,
                            thickness: 5,
                            color: Colors.lightBlue[50],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Key advantages of EECP treatment',
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  children: advantageList.map((advantage) {
                                    return _buildTimelineTile(
                                      icon: Icons.check_circle,
                                      title: advantage['title'] ?? '',
                                      subTitle:
                                      advantage['description'] ?? '',
                                      isCompleted: true,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 15,
                            thickness: 5,
                            color: Colors.lightBlue[50],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'EECP Therapy: For Whom Does It Suit? Eligibility for EECP',
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  children:
                                  disadvantageList.map((advantage) {
                                    return _buildTimelineTile(
                                      icon: Icons.check_circle,
                                      title: advantage['title'] ?? '',
                                      subTitle:
                                      advantage['description'] ?? '',
                                      isCompleted: true,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 15,
                            thickness: 5,
                            color: Colors.lightBlue[50],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Revolutionizing Heart Health: EECP Treatment at SAAOL Heart Center',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: AppColors.primaryColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  therapyTxt,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.black54),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 8,
                                ),
                                ListView.builder(
                                  itemCount: items.length,
                                  physics:const NeverScrollableScrollPhysics(),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.grey.withOpacity(0.3),
                                                width: 0.3)),
                                        child: ExpansionTile(
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
                                                    color: Colors.black87),
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
                          Divider(
                            height: 15,
                            thickness: 5,
                            color: Colors.lightBlue[50],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Preparing for EECP Therapy: A Journey Towards Heart Wellness',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: AppColors.primaryColor),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          preparingEECPTxt,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.black54),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                  _buildSectionTitle(
                                      'Before EECP therapy: The Foundation for Best Heart Blockage Treatment'),
                                  _buildParagraph(preparingEECPTxt1),
                                  _buildParagraph(preparingEECPTxt2),
                                  _buildSectionTitle(
                                      'During EECP Therapy: The Heart’s Renewal'),
                                  _buildParagraph(preparingEECPTxt3),
                                  _buildParagraph(preparingEECPTxt4),
                                  _buildSectionTitle(
                                      'After EECP Therapy: Nurturing Heart Health Beyond the Sessions'),
                                  _buildParagraph(preparingEECPTxt5),
                                  _buildParagraph(preparingEECPTxt6),
                                ]),
                          ),
                          Divider(
                            height: 15,
                            thickness: 5,
                            color: Colors.lightBlue[50],
                          ),
                          const SizedBox(height:60,)
                        ],
                      ),
                    );
                  }
                  return const Center(child: Text("No data found"));
                },
              ),




            ),
          ),


          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                        width: 0.4, color: Colors.grey.withOpacity(0.6)),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const MyAppointmentsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Book Appointment',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                iconSize: 25,
                icon: const Icon(
                  Icons.call,
                  color: Colors.white,
                ),
                onPressed: () {
                  _makingPhoneCall();
                  Fluttertoast.showToast(msg: 'Call');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
          fontFamily: 'FontPoppins',
        ),
      ),
    );
  }

  Widget _buildParagraph(String title) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        textAlign: TextAlign.justify,
        title,
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
            fontFamily: 'FontPoppins',
            letterSpacing: 0.1),
      ),
    );
  }

  Widget _buildTimelineTile({
    required IconData icon,
    required String title,
    required bool isCompleted,
    required String subTitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              icon,
              color: isCompleted ? AppColors.primaryColor : Colors.grey,
            ),
            Container(
              height: 80,
              width: 2,
              color: isCompleted ? AppColors.primaryColor : Colors.grey,
            ),
          ],
        ),
        const SizedBox(width: 13),
        Expanded(
          // Wrap the text column in an Expanded widget
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'FontPoppins',
                    color: Colors.black),
              ),
              Text(
                subTitle,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.black54,
                    letterSpacing: 0.1),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
