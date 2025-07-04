import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../DialogHelper.dart';
import '../../common/app_colors.dart';
import '../../constant/text_strings.dart';
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


  void extractHeadingAndDescription(String content) {
    List<String> parts = content.split('\r\n');
    heading = parts.isNotEmpty ? parts[0] : 'No Heading';
    description =
        parts.length > 1 ? parts.sublist(1).join('\n') : 'No Description';
  }
  final DraggableScrollableController sheetController =
  DraggableScrollableController();
  int? expandedIndex;


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
                extractHeadingAndDescription(snapshot.data!.data!.description.toString());
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
                    DraggableScrollableSheet(
                      initialChildSize: 0.7,
                      minChildSize: 0.7,
                      maxChildSize: 0.9,
                      expand: true,
                      controller:sheetController,
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
                                child:SingleChildScrollView(
                                  physics: const ScrollPhysics(),
                                  child:Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [


                                            Text(
                                              heading,
                                              style: const TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize:16,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              description.trim(),
                                              style: const TextStyle(
                                                fontFamily: 'FontPoppins',
                                                fontSize: 13,
                                                letterSpacing:0.2,
                                                height:1.6,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                              ),
                                            ),
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
              return const Center(child: Text("No data found",
                style:TextStyle(fontWeight:FontWeight.w600,
                    fontSize:15,fontFamily:'FontPoppins',color:AppColors.primaryColor),));
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
}
