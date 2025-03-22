import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../data/model/apiresponsemodel/TreatmentsDetailResponseData.dart';
import '../../data/network/BaseApiService.dart';
import '../AppointmentsScreen.dart';


class DetoxScreen extends StatefulWidget {
  final String id;

  const DetoxScreen({super.key, required this.id});

  @override
  State<DetoxScreen> createState() => _DetoxScreenState();
}

class _DetoxScreenState extends State<DetoxScreen> {
  String heading = '';
  String description = '';
  String image = 'https://www.canadadrugrehab.ca/wp-content/uploads/2022/06/iStock-1300493714.jpg';


  void extractHeadingAndDescription(String content) {
    List<String> parts = content.split('\r\n');
    heading = parts.isNotEmpty ? parts[0] : 'No Heading';
    description =
        parts.length > 1 ? parts.sublist(1).join('\n') : 'No Description';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'SAAOL Detox',
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
            child: Image.network(
              image,
              width: double.infinity,
              fit: BoxFit.cover,
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
                    // Extract the heading and description from the API data
                    extractHeadingAndDescription(snapshot.data!.data!.description.toString());

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
                                  heading, // Display the extracted heading
                                  style: const TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  description,
                                  // Display the extracted description
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontFamily: 'FontPoppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                    width: 0.4,
                    color: Colors.grey.withOpacity(0.6),
                  ),
                ),
              ),
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
                                  const MyAppointmentsScreen(),
                            ),
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
                            color: Colors.white,
                          ),
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
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
