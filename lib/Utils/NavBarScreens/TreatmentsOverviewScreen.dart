import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaolapp/DialogHelper.dart';
import 'package:saaolapp/constant/text_strings.dart';
import '../../common/app_colors.dart';
import '../../data/model/apiresponsemodel/TreatmentsDetailResponseData.dart';
import '../../data/network/BaseApiService.dart';
import '../AppointmentsScreen.dart';

class TreatmentsOverviewScreen extends StatefulWidget {
  final String id;

  const TreatmentsOverviewScreen({super.key, required this.id});

  @override
  State<TreatmentsOverviewScreen> createState() =>
      _TreatmentsOverviewScreenState();
}

class _TreatmentsOverviewScreenState extends State<TreatmentsOverviewScreen> {
  final List<IconData> treatmentIcons = [
    Icons.school,
    Icons.medical_services,
    Icons.favorite,
    Icons.spa,
  ];

  Future<List<Map<String, String>>> fetchTreatmentList() async {
    return [
      {
        "title": "Education & Lifestyle Management",
        "description":
            "Entails complete training of the heart patient and his/her family member on dos and don’ts for heart patients.",
      },
      {
        "title": "Optimum Allopathic Medical Management",
        "description":
            "Modern medicines from the Allopathic system are prescribed to heart patients to reduce Angina & other risk factors.",
      },
      {
        "title": "Natural Bypass or ECP/EECP",
        "description":
            "This treatment is a highly accepted UD FDA-approved scientific and non-invasive way to treat heart disease.",
      },
      {
        "title": "Saaol Detox Therapy",
        "description":
            "A combination of Allopathic Detoxification medicines is given along with Ayurvedic, Homeopathic, Unani and herbal medicines.",
      },
    ];
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
                return Center(
                  child: Container(
                    width: 60, // Set custom width
                    height: 60, // Set custom height
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      // Background color for the progress indicator
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor, // Custom color
                        strokeWidth: 6, // Set custom stroke width
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error loading data"),
                );
              } else if (snapshot.hasData) {
                String fullDescription = snapshot.data!.data!.description ?? '';
                String mainTreatments = snapshot.data!.data!.advantage ?? '';
                String disadvantage = snapshot.data!.data!.disadvantge ?? '';
                String title = '';
                String description = '';
                String title1 = '';
                String description1 = '';
                List<String> lines = fullDescription.split('\r\n');
                if (lines.isNotEmpty) {
                  title = lines[0].trim(); // First line as title
                  description =
                      lines.sublist(1).join(' ').trim(); // Rest as description
                }
                List<String> lines2 = mainTreatments.split('\r\n');
                if (lines2.isNotEmpty) {
                  title1 = lines2[0].trim(); // First line as title
                  description1 =
                      lines2.sublist(1).join(' ').trim(); // Rest as description
                }
                String disadvantageTitle = '';
                String disadvantageContent = '';

                List<String> disadvantageLines = disadvantage.split('\r\n');
                if (disadvantageLines.isNotEmpty) {
                  disadvantageTitle =
                      disadvantageLines[0].trim(); // First line as title
                  disadvantageContent = disadvantageLines
                      .sublist(1)
                      .join(' ')
                      .trim(); // Rest as content
                }
                print('Description:$description');

                return Stack(
                  children: [

                    SizedBox(
                      height:260,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        snapshot.data!.data!.chooseDescriptionImage
                            .toString(),
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
                      padding: const EdgeInsets.only(top: 240.0),
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
                          child:SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        title.trim(),
                                        style: const TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize:16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryColor),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        description.trim(),
                                        style: const TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize:13,
                                            letterSpacing:0.2,
                                            fontWeight: FontWeight.w500,
                                            height:1.6,
                                            color: Colors.black87),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          title1.trim(),
                                          style: const TextStyle(
                                              fontFamily: 'FontPoppins',
                                              fontSize:16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        description1.trim(),
                                        style: const TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize:13,
                                            letterSpacing: 0.2,
                                            height:1.6,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      FutureBuilder<List<Map<String, String>>>(
                                        future: fetchTreatmentList(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}');
                                          } else {
                                            final listArray = snapshot.data!;
                                            return SizedBox(
                                              height:180,
                                              child: ListView.builder(
                                                itemCount: listArray.length,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  final item = listArray[index];
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 10),
                                                    child: Container(
                                                      width: 320,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.circular(16),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.black12,
                                                            blurRadius: 10,
                                                            offset: Offset(0, 4),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(16),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Container(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: AppColors
                                                                    .primaryDark
                                                                    .withOpacity(0.1),
                                                                shape:
                                                                BoxShape.circle,
                                                              ),
                                                              child: Icon(
                                                                treatmentIcons[index % treatmentIcons.length],
                                                                size: 32,
                                                                color: AppColors.primaryDark,
                                                              ),
                                                            ),
                                                            const SizedBox(width: 16),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                mainAxisSize:
                                                                MainAxisSize.min,
                                                                children: [

                                                                  Text(
                                                                    textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                    item["title"] ??
                                                                        "",
                                                                    style:
                                                                    const TextStyle(
                                                                      fontSize:14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                      fontFamily:
                                                                      'FontPoppins',
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height: 10),
                                                                  Text(
                                                                    item["description"] ??
                                                                        "".trim(),
                                                                    style:
                                                                    const TextStyle(
                                                                      fontSize:12,
                                                                      fontFamily:
                                                                      'FontPoppins',
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: Colors
                                                                          .black87,
                                                                      height: 1.4,
                                                                    ),
                                                                    maxLines: 4,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        disadvantageTitle,
                                        style: const TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontSize:16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/icons/safety_circle.jpg'),
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text(
                                              disadvantageContent.trim(),
                                              style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:13,
                                                  letterSpacing:0.2,
                                                  height: 1.5,
                                                  color: Colors.black87),
                                            ),

                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                buildRiskIndicator(
                                                  color: Colors.red,
                                                  text: 'Red (means high risk)',
                                                  icon: Icons.warning_amber_rounded,
                                                ),
                                                buildRiskIndicator(
                                                  color: Colors.yellow[800]!,
                                                  text: 'Yellow (medium risk or prevention range)',
                                                  icon: Icons.report_problem_rounded,
                                                ),
                                                buildRiskIndicator(
                                                  color: Colors.green,
                                                  text: 'Green (lowest risk or reversal)',
                                                  icon: Icons.check_circle_rounded,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 80,
                                )
                              ],
                            ),
                          ),
                      ),
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
  Widget buildRiskIndicator({
    required Color color,
    required String text,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.2),
            ),
            padding: const EdgeInsets.all(6),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text.trim(),
              style: TextStyle(
                fontFamily: 'FontPoppins',
                fontWeight: FontWeight.w500,
                fontSize:13,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
