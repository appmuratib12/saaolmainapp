import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/DiseaseResponseData.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';
import 'AppointmentsScreen.dart';

class DiseaseDetailScreen extends StatefulWidget {
  final Data data;
  const DiseaseDetailScreen({super.key, required this.data});

  @override
  State<DiseaseDetailScreen> createState() => _DiseaseDetailScreenState();
}

class _DiseaseDetailScreenState extends State<DiseaseDetailScreen> {
  String anginaTxt =
      'EECP therapy addresses angina by enhancing blood flow to the heart and reducing the frequency and severity of chest pain episodes and Heart attacks.';

  List<String> treatmentArray = [
    "Expert Team",
    "Holistic Approach",
    "Innovative Treatments",
    "SAAOL Detox Therapy"
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            widget.data.title.toString(),
            style: TextStyle(
                fontFamily: 'FontPoppins',
                fontSize: screenWidth * 0.05,
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
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'What is coronary artery disease?',
                      style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 2,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image(
                                  image: NetworkImage(widget.data.image.toString()),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: screenHeight * 0.2,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              Text(
                                widget.data.title.toString(),
                                style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                widget.data.description.toString(),
                                textAlign: TextAlign.start, // Changed from justify to start
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035, // Responsive font size
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'What are the symptoms of coronary artery disease?',
                      style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      chooseSaaolTxt, // The text to display
                      textAlign: TextAlign.justify, // Align to start (left)
                      style: TextStyle(
                        fontSize: screenWidth * 0.035, // Responsive font size
                        fontFamily: 'FontPoppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        letterSpacing:0.2,
                        height: 1.5, // Line height for better readability
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    SizedBox(
                      height: screenHeight * 0.2,
                      child: SizedBox(
                        height: 160,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: treatmentArray.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  elevation: 2,
                                  child: Container(
                                    height: 150,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: const Image(
                                              image: AssetImage(
                                                'assets/icons/leader.png',
                                              ),
                                              fit: BoxFit.cover,
                                              width: 55,
                                              height: 55,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  treatmentArray[index],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 5),
                                                const Flexible(
                                                  child: Text(
                                                    textAlign: TextAlign.start,
                                                    'Our team comprises seasoned professionals dedicated to your heart health. With years of experience and expertise, we deliver top-notch care and innovative treatments.',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'FontPoppins',
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black87,
                                                    ),
                                                    maxLines: 5, // Adjust maxLines to prevent overflow
                                                    overflow: TextOverflow.ellipsis, // Ensure long text doesn't overflow
                                                    softWrap: true, // Allow text to wrap
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
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      anginaTxt,
                      style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                const MyAppointmentsScreen()),
                          );
                          Fluttertoast.showToast(msg: 'Book');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Book Appointment',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.1,
              right: screenWidth * 0.05,
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
                    Fluttertoast.showToast(msg: 'Call');
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
