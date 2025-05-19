import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaolapp/DialogHelper.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';
import '../data/model/apiresponsemodel/TreatmentsDetailResponseData.dart';
import '../data/network/BaseApiService.dart';
import 'AppointmentsScreen.dart';

class TreatmentDetailsPageScreen extends StatefulWidget {
  final String id;

  const TreatmentDetailsPageScreen({super.key, required this.id});

  @override
  State<TreatmentDetailsPageScreen> createState() =>
      _TreatmentDetailsPageScreenState();
}

class _TreatmentDetailsPageScreenState
    extends State<TreatmentDetailsPageScreen> {
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          FutureBuilder<TreatmentsDetailResponseData>(
            future: BaseApiService().getTreatmentDetailsData(widget.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error loading data"),
                );
              } else if (snapshot.hasData) {
                String fullDescription = snapshot.data!.data!.description ?? '';
                String advantage = snapshot.data!.data!.advantage ?? '';
                String disadvantage = snapshot.data!.data!.disadvantge ?? '';
                List<Map<String, String>> advantageList =
                    extractAdvantageDetails(advantage);
                List<Map<String, String>> disadvantageList =
                    extractDisadvantageDetails(disadvantage);
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

                return Stack(
                  children: [
                    SizedBox(
                      height: 260,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        snapshot.data!.data!.chooseDescriptionImage.toString(),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top:35, // Adjust according to your app bar height / status bar
                      left:12,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,size:22,),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:220.0),
                      child: Container(
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: Colors.grey[200],
                          ),
                          height: double.infinity,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        List.generate(headings.length, (index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            headings[index],
                                            style: const TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontSize:16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            contents.length > index
                                                ? contents[index].trim()
                                                : '',
                                            style: const TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontSize: 13,
                                              letterSpacing:0.2,
                                              height: 1.5,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          // Space between sections
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                                const Divider(
                                  height: 15,
                                  thickness: 5,
                                  color: AppColors.primaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Key advantages of EECP treatment',
                                        style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize:16,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Column(
                                        children:
                                            advantageList.map((advantage) {
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
                                const Divider(
                                  height: 15,
                                  thickness: 5,
                                  color: AppColors.primaryColor
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'EECP Therapy: For Whom Does It Suit? Eligibility for EECP',
                                        style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize:16,
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
                                const Divider(
                                  height: 15,
                                  thickness: 5,
                                  color: AppColors.primaryColor
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Revolutionizing Heart Health: EECP Treatment at SAAOL Heart Center',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize:16,
                                            color: AppColors.primaryColor),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        therapyTxt,
                                        style: TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize:13,
                                            letterSpacing:0.2,
                                            height:1.5,
                                            color: Colors.black87),
                                      ),
                                      ListView.builder(
                                        itemCount: items.length,
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap:true,
                                        clipBehavior:Clip.hardEdge,
                                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      width: 0.3)),
                                              child: ExpansionTile(
                                                title: Text(
                                                  items[index]['title']!,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'FontPoppins',
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        16.0),
                                                    child: Text(
                                                      items[index]['description']!.trim(),
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          'FontPoppins',
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontSize:13,
                                                          letterSpacing:0.2,
                                                          color: Colors.black87),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 15,
                                  thickness: 5,
                                  color: AppColors.primaryColor
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                         Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Preparing for EECP Therapy: A Journey Towards Heart Wellness',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:16,
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                preparingEECPTxt.trim(),
                                                style: const TextStyle(
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:13,
                                                    height:1.5,
                                                    letterSpacing:0.2,
                                                    color: Colors.black87),
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
                                const Divider(
                                  height: 15,
                                  thickness: 5,
                                  color: AppColors.primaryColor
                                ),
                                const SizedBox(
                                  height:40,
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                );
              }
              return const Center(child: Text("No data found"));
            },
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
                  DialogHelper.makingPhoneCall(Consulation_Phone);
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
        title.trim(),
        style: const TextStyle(
            fontSize:13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            height:1.5,
            fontFamily: 'FontPoppins',
            letterSpacing: 0.2),
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
                    fontSize:13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'FontPoppins',
                    color: Colors.black),
              ),
              Text(
                subTitle.trim(),
                style: const TextStyle(
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    height:1.5,
                    color: Colors.black87,
                    letterSpacing: 0.2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
