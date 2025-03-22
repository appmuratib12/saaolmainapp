import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaoldemo/common/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/model/apiresponsemodel/TreatmentsDetailResponseData.dart';
import '../../data/network/BaseApiService.dart';
import '../AppointmentsScreen.dart';


class TreatmentsOverviewScreen extends StatefulWidget {
  final String id;
  const TreatmentsOverviewScreen({super.key,required this.id});

  @override
  State<TreatmentsOverviewScreen> createState() => _TreatmentsOverviewScreenState();
}

class _TreatmentsOverviewScreenState extends State<TreatmentsOverviewScreen> {
  List<String> listArray = ["Item1", "Item2"];
  String image = 'https://saaol.com/psd//assets/images/about/home/treatments-section.jpg';

  _makingPhoneCall() async {
    var url = Uri.parse("tel:8447776000");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Treatments Overview',
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
            width: MediaQuery.of(context).size.width,
            child: Image.network(image,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 220.0),
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
              child: FutureBuilder<TreatmentsDetailResponseData>(
                future: BaseApiService().getTreatmentDetailsData(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        width: 60, // Set custom width
                        height:60, // Set custom height
                        decoration: BoxDecoration(
                          color:AppColors.primaryColor.withOpacity(0.1), // Background color for the progress indicator
                          borderRadius: BorderRadius.circular(30), // Rounded corners
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor, // Custom color
                            strokeWidth:6, // Set custom stroke width
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error loading data"),
                    );
                  } else if (snapshot.hasData) {
                    String fullDescription =
                        snapshot.data!.data!.description ?? '';
                    String mainTreatments =
                        snapshot.data!.data!.advantage ?? '';
                    String disadvantage =
                        snapshot.data!.data!.disadvantge ?? '';
                    String title = '';
                    String description = '';
                    String title1 = '';
                    String description1 = '';
                    List<String> lines = fullDescription.split('\r\n');
                    if (lines.isNotEmpty) {
                      title = lines[0].trim(); // First line as title
                      description = lines
                          .sublist(1)
                          .join(' ')
                          .trim(); // Rest as description
                    }
                    List<String> lines2 = mainTreatments.split('\r\n');
                    if (lines2.isNotEmpty) {
                      title1 = lines2[0].trim(); // First line as title
                      description1 = lines2
                          .sublist(1)
                          .join(' ')
                          .trim(); // Rest as description
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

                    return SingleChildScrollView(
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
                                  title,
                                  style: const TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  textAlign: TextAlign.justify,
                                  description,
                                  style: const TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
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
                                Center(
                                  child: Text(
                                    title1,
                                    style: const TextStyle(
                                        fontFamily: 'FontPoppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  description1,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 160,
                                  child: ListView.builder(
                                    itemCount: listArray.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7.0),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                width: 0.3, color: Colors.grey),
                                          ),
                                          constraints: const BoxConstraints(
                                            minHeight:
                                                150, // Set the minimum height for the container
                                          ),
                                          width: 350,
                                          child: const Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.ac_unit_rounded,
                                                size: 40,
                                                color: AppColors.primaryDark,
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  // Dynamically adjust height
                                                  children: [
                                                    Text(
                                                      'Hello world',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            'FontPoppins',
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8),
                                                    Flexible(
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.justify,
                                                        'Entails complete training of the heart patient and his/her family member on dos and don’ts for heart patients',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'FontPoppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black54,
                                                        ),
                                                        maxLines: 5,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
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
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  disadvantageTitle,
                                  style: const TextStyle(
                                      fontFamily: 'FontPoppins',
                                      fontSize: 18,
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
                                        disadvantageContent,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                            fontFamily: 'FontPoppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color:Colors.red,
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
                                                color: Colors.red),
                                          )
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.yellow,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Yellow (medium risk or prevention range)',
                                            style: TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                color: Colors.yellow),
                                          )
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.green,
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
                                                color: Colors.green),
                                          )
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
