import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/ZeroOilHealthyFoodResponseData.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/ZeroOilRecipeResponseData.dart';
import 'package:saaoldemo/data/network/BaseApiService.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/app_colors.dart';
import '../../data/model/apiresponsemodel/TreatmentsDetailResponseData.dart';
import '../AppointmentsScreen.dart';

class ZeroOilPageScreen extends StatefulWidget {
  final String id;
  const ZeroOilPageScreen({super.key, required this.id});

  @override
  State<ZeroOilPageScreen> createState() => _ZeroOilPageScreenState();
}

class _ZeroOilPageScreenState extends State<ZeroOilPageScreen> {
  List<String> zeroOilArray = [
    "https://saaol.com/psd//assets/images/about/home/zero-oil-cooking-page.jpeg",
    "https://saaol.com/blog/saaol-blog-storage/2023/10/How-is-Zero-Oil-Cooking-Good-for-Your-Heart-Health.jpg",
  ];

  _makingPhoneCall() async {
    var url = Uri.parse("tel:8447776000");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  late Future<TreatmentsDetailResponseData> treatmentDetails;

  @override
  void initState() {
    super.initState();
    treatmentDetails = BaseApiService().getTreatmentDetailsData(widget.id);
  }

  String extractDescription(String description) {
    List<String> paragraphs = description.split('\r\n');
    if (paragraphs.isNotEmpty) {
      return paragraphs.first.trim();
    }
    return description;
  }

  String extractPortion(
      String description, String startKeyword, String endKeyword) {
    int startIndex = description.indexOf(startKeyword);
    int endIndex = description.indexOf(endKeyword) +
        endKeyword.length; // Include the end keyword
    if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
      return description.substring(startIndex, endIndex).trim();
    }

    return ''; // Return an empty string if no valid portion is found
  }


  String extractPortion1(
      String description, String startKeyword, String endKeyword) {
    int startIndex = description.indexOf(startKeyword);
    int endIndex = description.indexOf(endKeyword) +
        endKeyword.length; // Include the end keyword
    if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
      return description.substring(startIndex, endIndex).trim();
    }

    return ''; // Return an empty string if no valid portion is found
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

  List<Map<String, String>> extractAvoidData(String advantage) {
    List<Map<String, String>> advantageList = [];
    List<String> sections =
        advantage.split('\r\n'); // Split sections by double line breaks

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
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'ZERO OIL COOKING',
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
                        items: zeroOilArray.map((imagePath) {
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
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FutureBuilder<TreatmentsDetailResponseData>(
                      future: treatmentDetails,
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
                          var treatmentData = snapshot.data!.data!;
                          String fullDescription =
                              snapshot.data!.data!.description ?? '';
                          String extractedDescription =
                              extractDescription(fullDescription);
                          String extractedPortion = extractPortion(
                              fullDescription, "Welcome", "heart");
                          String advantage =
                              snapshot.data!.data!.advantage ?? '';
                          String disadvantage =
                              snapshot.data!.data!.disadvantge ?? '';
                          String avoidOther =
                              snapshot.data!.data!.whythisOtherData ?? '';
                          List<Map<String, String>> advantageList =
                              extractAdvantageDetails(advantage);
                          List<Map<String, String>> disadvantageList =
                              extractDisadvantageDetails(disadvantage);
                          List<Map<String, String>> avoidOtherList =
                              extractAvoidData(avoidOther);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      extractedDescription,
                                      style: const TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      extractedPortion, // Replace with API data
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                      maxLines: 8,
                                      overflow: TextOverflow.ellipsis,
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
                                      'Advantages of Oil Free Cooking',
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
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
                                      'Disadvantages of Oil-Based Foods',
                                      style: TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
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
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Why Avoid Oil-Based Food?',
                                      style: TextStyle(
                                          fontFamily: 'FontPoppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: avoidOtherList.map((avoidData) {
                                        return _buildTimelineTile(
                                          icon: Icons.check_circle,
                                          title: avoidData['title'] ?? '',
                                          subTitle:
                                              avoidData['description'] ?? '',
                                          isCompleted: true,
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        return const Center(child: Text("No data found"));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Mastering the Art of Zero-Oil Cooking: Creative Techniques and Recipes',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 350,
                            child: FutureBuilder<ZeroOilRecipeResponseData>(
                              future: BaseApiService().getZeroOilRecipeData(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.data!.length,
                                    scrollDirection: Axis.horizontal,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    itemBuilder: (context, index1) {
                                      String description1 = snapshot.data!
                                              .data![index1].contentCard ??
                                          '';
                                      String extractedPortion = extractPortion1(
                                          description1, "Create", "oil.");
                                      String extractedPortion2 =
                                          extractPortion1(description1, "Puree",
                                              "dressing.");

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0.4)),
                                              width: 350,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image(
                                                        image: NetworkImage(
                                                            snapshot
                                                                .data!
                                                                .data![index1]
                                                                .image
                                                                .toString()),
                                                        height: 130,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      snapshot.data!
                                                          .data![index1].tag
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'FontPoppins',
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .primaryColor),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 8,
                                                                height: 8,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: AppColors
                                                                      .primaryDark,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .data![
                                                                          index1]
                                                                      .contentCard
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontFamily:
                                                                          'FontPoppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black54),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                      'ZeroOilResponse-->${snapshot.data!.message}');
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
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
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'What are some healthy food recipes without Oil',
                            style: TextStyle(
                                fontFamily: 'FontPoppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 300,
                            child:
                                FutureBuilder<ZeroOilHealthyFoodResponseData>(
                              future: BaseApiService().getZeroOilHealthyData(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.data!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Card(
                                          color: Colors.white,
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: ExpandablePanel(
                                            theme: const ExpandableThemeData(
                                              headerAlignment:
                                                  ExpandablePanelHeaderAlignment
                                                      .center,
                                              tapBodyToExpand: true,
                                              tapBodyToCollapse: true,
                                              hasIcon: true,
                                            ),
                                            header: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      snapshot.data!
                                                          .data![index].tag
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            'FontPoppins',
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            collapsed: Container(),
                                            // Keep collapsed state empty
                                            expanded: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                          snapshot
                                                              .data!
                                                              .data![index]
                                                              .image
                                                              .toString(),
                                                          // Use the image from the array
                                                          fit: BoxFit.cover,
                                                          height: 120,
                                                          width:
                                                              double.infinity,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .data![index]
                                                            .contentCard
                                                            .toString(),
                                                        // Use the description from the array
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'FontPoppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black54),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                      'ZeroOilHealthyFoodResponse-->${snapshot.data!.message}');
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                },
              ),
            ),
          ),
        ],
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'FontPoppins',
                  color: Colors.black,
                ),
              ),
              Text(
                subTitle,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Colors.black54,
                  letterSpacing: 0.1,
                ),
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
