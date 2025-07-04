import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:saaolapp/DialogHelper.dart';
import '../../common/app_colors.dart';
import '../../data/model/apiresponsemodel/TreatmentsDetailResponseData.dart';
import '../../data/model/apiresponsemodel/ZeroOilHealthyFoodResponseData.dart';
import '../../data/model/apiresponsemodel/ZeroOilRecipeResponseData.dart';
import '../../data/network/BaseApiService.dart';
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
  final DraggableScrollableController sheetController =
      DraggableScrollableController();
  int? expandedIndex;

  String convertToHtml(String raw) {
    List<String> lines = raw.split('\r\n');
    StringBuffer buffer = StringBuffer();
    bool headingAdded = false;
    for (var line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;
      if (!headingAdded) {
        buffer.writeln('<h2>$trimmed</h2>');
        headingAdded = true;
        continue;
      }
      if (trimmed.contains(':')) {
        final colonIndex = trimmed.indexOf(':');
        if (colonIndex != -1 && colonIndex < trimmed.length - 1) {
          final title = trimmed.substring(0, colonIndex + 1);
          final rest = trimmed.substring(colonIndex + 1).trim();
          buffer.writeln('<p><b>$title</b> $rest</p>');
        } else {
          buffer.writeln('<p>$trimmed</p>');
        }
      } else {
        buffer.writeln('<p>$trimmed</p>');
      }
    }

    return buffer.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          children: [
            FutureBuilder<TreatmentsDetailResponseData>(
              future: treatmentDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
                  String extractedPortion =
                      extractPortion(fullDescription, "Welcome", "heart");
                  String advantage = snapshot.data!.data!.advantage ?? '';
                  String disadvantage = snapshot.data!.data!.disadvantge ?? '';
                  String avoidOther = snapshot.data!.data!.whythisOtherData ?? '';
                  final String htmlDisadvantage = convertToHtml(disadvantage ?? '');
                  List<Map<String, String>> advantageList = extractAdvantageDetails(advantage);
                  List<Map<String, String>> disadvantageList = extractDisadvantageDetails(disadvantage);
                  List<Map<String, String>> avoidOtherList = extractAvoidData(avoidOther);
                  return Stack(
                    children: [
                      SizedBox(
                        height: 260,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          snapshot.data!.data!.chooseDescriptionImage
                              .toString(),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 30,
                        // Adjust according to your app bar height / status bar
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 22,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      DraggableScrollableSheet(
                        initialChildSize: 0.7,
                        minChildSize: 0.7,
                        maxChildSize: 0.9,
                        expand: true,
                        controller: sheetController,
                        builder: (BuildContext context, scrollController) {
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: CustomScrollView(
                              controller: scrollController,
                              slivers: [
                                SliverToBoxAdapter(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                extractedDescription.trim(),
                                                style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize: 15,
                                                  color: AppColors
                                                      .primaryColor,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                extractedPortion.trim(),
                                                // Replace with API data
                                                style: const TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize: 13,
                                                  letterSpacing: 0.2,
                                                  height: 1.5,
                                                  color: Colors.black87,
                                                ),
                                                maxLines: 12,
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                            height: 15,
                                            thickness: 5,
                                            color: AppColors.primaryColor),
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Advantages of Oil Free Cooking',
                                                style: TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Column(
                                                children: advantageList
                                                    .map((advantage) {
                                                  return _buildTimelineTile(
                                                    icon:
                                                    Icons.check_circle,
                                                    title: advantage[
                                                    'title'] ?? '',
                                                    subTitle: advantage[
                                                    'description'] ??
                                                        '',
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
                                            color: AppColors.primaryColor),
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              /*const Text(
                                                'Disadvantages of Oil-Based Foods',
                                                style: TextStyle(
                                                  fontFamily: 'FontPoppins',
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 15),*/
                                              Html(
                                                data: htmlDisadvantage,
                                                style: {
                                                  "h2": Style(
                                                    fontSize: FontSize(16.0),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:'FontPoppins',
                                                    color: Colors.black,
                                                    margin: Margins.only(bottom: 12),
                                                  ),
                                                  "p": Style(
                                                    fontSize: FontSize(12),
                                                    color: Colors.black87,
                                                    fontWeight:FontWeight.w500,
                                                    fontFamily:'FontPoppins',
                                                    letterSpacing: 0.1,
                                                    margin: Margins.only(bottom: 8),
                                                  ),
                                                  "b": Style(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'FontPoppins',
                                                    fontSize:FontSize(13)
                                                  ),
                                                },
                                              ),

                                              /*Column(
                                                children: disadvantageList
                                                    .map((advantage) {
                                                  return _buildTimelineTile(
                                                    icon:
                                                    Icons.check_circle,
                                                    title: advantage[
                                                    'title'] ??
                                                        '',
                                                    subTitle: advantage[
                                                    'description'] ??
                                                        '',
                                                    isCompleted: true,
                                                  );
                                                }).toList(),
                                              ),*/
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                            height: 15,
                                            thickness: 5,
                                            color: AppColors.primaryColor),
                                        Padding(
                                          padding:const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Why Avoid Oil-Based Food?',
                                                style: TextStyle(
                                                    fontFamily:
                                                    'FontPoppins',
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                children: avoidOtherList
                                                    .map((avoidData) {
                                                  return _buildTimelineTile(
                                                    icon:
                                                    Icons.check_circle,
                                                    title: avoidData[
                                                    'title'] ??
                                                        '',
                                                    subTitle: avoidData[
                                                    'description'] ??
                                                        '',
                                                    isCompleted: true,
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Mastering the Art of Zero-Oil Cooking: Creative Techniques and Recipes',
                                                style: TextStyle(
                                                    fontFamily:
                                                    'FontPoppins',
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height:370,
                                          child: FutureBuilder<
                                              ZeroOilRecipeResponseData>(
                                            future: BaseApiService()
                                                .getZeroOilRecipeData(),
                                            builder:
                                                (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView
                                                    .builder(
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  itemCount: snapshot.data!.data!.length,
                                                  padding:const EdgeInsets.symmetric(horizontal:10),
                                                  itemBuilder: (context, index) {
                                                    final item =
                                                    snapshot.data!
                                                        .data![
                                                    index];
                                                    final String
                                                    description =
                                                    cleanText(
                                                        item.contentCard ??
                                                            '');
                                                    final String tag =
                                                        item.tag ??
                                                            '';
                                                    final String
                                                    imageUrl = item.image ??'';

                                                    return Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10,
                                                          vertical:
                                                          10),
                                                      child:
                                                      Container(
                                                        width:310,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: Colors
                                                              .white,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black12,
                                                              blurRadius:
                                                              8,
                                                              offset: Offset(
                                                                  0,
                                                                  4),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius: const BorderRadius
                                                                  .only(
                                                                  topLeft:
                                                                  Radius.circular(18),
                                                                  topRight: Radius.circular(18)),
                                                              child: Image
                                                                  .network(
                                                                imageUrl,
                                                                height:
                                                                160,
                                                                width:
                                                                double.infinity,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .all(
                                                                  12),
                                                              child:
                                                              Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                                children: [
                                                                  // Tag badge
                                                                  Container(
                                                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.primaryColor.withOpacity(0.1),
                                                                      borderRadius: BorderRadius.circular(20),
                                                                    ),
                                                                    child: Text(
                                                                      tag,
                                                                      style: const TextStyle(
                                                                        fontFamily: 'FontPoppins',
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: AppColors.primaryColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 10),
                                                                  // Description
                                                                  Text(
                                                                    description.trim(),
                                                                    style: const TextStyle(
                                                                      fontFamily: 'FontPoppins',
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Colors.black87,
                                                                      letterSpacing: 0.2,
                                                                      height: 1.5,
                                                                    ),
                                                                    maxLines: 6,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else if (snapshot
                                                  .hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else {
                                                return const Center(
                                                    child:
                                                    CircularProgressIndicator());
                                              }
                                            },
                                          ),
                                        ),
                                        const Divider(
                                            height: 15,
                                            thickness: 5,
                                            color: AppColors.primaryColor),
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'What are some healthy food recipes without Oil',
                                                style: TextStyle(
                                                    fontFamily:
                                                    'FontPoppins',
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(
                                                height:750,
                                                child:FutureBuilder<ZeroOilHealthyFoodResponseData>(
                                                  future: BaseApiService().getZeroOilHealthyData(),
                                                  builder:
                                                      (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      final data = snapshot.data!.data!;
                                                      return ListView.builder(
                                                        itemCount: data.length,
                                                        physics:const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        clipBehavior:Clip.hardEdge,
                                                        itemBuilder: (context, index) {
                                                          final item = data[index];
                                                          final isExpanded = expandedIndex == index;
                                                          return Padding(
                                                            padding:
                                                            const EdgeInsets.symmetric(vertical: 5),
                                                            child: Card(
                                                              color: Colors.white,
                                                              elevation: 2,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                                side: const BorderSide(
                                                                  color: Colors.black54, // Change to any color you want
                                                                  width:0.5,         // Thickness of the border
                                                                ),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  InkWell(
                                                                    onTap:
                                                                        () {
                                                                      setState(
                                                                              () {
                                                                            if (expandedIndex ==
                                                                                index) {
                                                                              expandedIndex = null; // collapse if same tapped
                                                                            } else {
                                                                              expandedIndex = index; // expand new, collapse previous
                                                                            }
                                                                          });
                                                                    },
                                                                    child:
                                                                    Padding(padding: const EdgeInsets.all(15),
                                                                      child:
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text(
                                                                              item.tag.toString(),
                                                                              style: const TextStyle(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: 'FontPoppins',
                                                                                color: AppColors.primaryColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          AnimatedRotation(
                                                                            turns: isExpanded ? 0.5 : 0.0,
                                                                            duration: const Duration(milliseconds: 300),
                                                                            child: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  AnimatedCrossFade(
                                                                    crossFadeState: isExpanded
                                                                        ? CrossFadeState.showSecond
                                                                        : CrossFadeState.showFirst,
                                                                    duration:
                                                                    const Duration(milliseconds: 300),
                                                                    firstChild:
                                                                    const SizedBox.shrink(),
                                                                    secondChild:
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal: 10,
                                                                          vertical: 10),
                                                                      child:
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                        children: [
                                                                          ClipRRect(
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            child: Image.network(
                                                                              item.image.toString(),
                                                                              fit: BoxFit.cover,
                                                                              height: 120,
                                                                              width: double.infinity,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(height: 10),
                                                                          Text(
                                                                            item.contentCard.toString(),
                                                                            style: const TextStyle(
                                                                              fontSize: 12,
                                                                              fontFamily: 'FontPoppins',
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black54,
                                                                            ),
                                                                            textAlign: TextAlign.justify,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Center(
                                                          child: Text(
                                                              "Error: ${snapshot.error}"));
                                                    } else {
                                                      return const Center(
                                                          child:
                                                          CircularProgressIndicator());
                                                    }
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
                    DialogHelper.makingPhoneCall('');
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
                title.trim(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'FontPoppins',
                  color: Colors.black,
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  fontFamily: 'FontPoppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.black87,
                  height: 1.5,
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

  String cleanText(String rawText) {
    return rawText.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
