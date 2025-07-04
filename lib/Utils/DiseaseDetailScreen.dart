import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:saaolapp/DialogHelper.dart';
import 'package:saaolapp/data/model/apiresponsemodel/DiseaseResponseData.dart';
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
  List<Map<String, String>> formattedText = [];
  List<String> treatmentArray = [
    "Angioplasty",
    "Bypass Surgery",
    "Heart Valve Repair",
    "Pacemaker Implant",
    "Cardiac Rehabilitation"
  ];

  @override
  void initState() {
    super.initState();
    formattedText = extractFormattedText(widget.data.description.toString());
  }

  List<Map<String, String>> extractFormattedText(String description) {
    List<Map<String, String>> sections = [];
    List<String> parts = description.split("\r\n\r\n");
    for (String part in parts) {
      List<String> lines = part.split("\r\n");
      if (lines.isNotEmpty) {
        sections
            .add({"heading": lines.first, "content": lines.skip(1).join("\n")});
      }
    }
    return sections;
  }

  String convertToHtml(String raw) {
    List<String> lines = raw.split('\r\n');
    StringBuffer buffer = StringBuffer();
    for (var line in lines) {
      if (line.trim().isEmpty) continue;
      if (line.trim().endsWith('?')) {
        buffer.writeln('<h2>${line.trim()}</h2>');
      } else if (RegExp(r'^\d+\.\s').hasMatch(line)) {
        final colonIndex = line.indexOf(':');
        if (colonIndex != -1) {
          final beforeColon = line.substring(0, colonIndex + 1);
          final afterColon = line.substring(colonIndex + 1);
          buffer.writeln('<p><b>$beforeColon</b>$afterColon</p>');
        } else {
          buffer.writeln('<p>${line.trim()}</p>');
        }
      } else {
        buffer.writeln('<p>${line.trim()}</p>');
      }
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final String htmlDescription = convertToHtml(widget.data.description ?? '');
    
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
        title: Text(
          widget.data.title.toString(),
          style: const TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding:EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical:15),child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.data.image.toString(),
                      width: double.infinity,
                      height: screenHeight * 0.25,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            )),
            Padding(padding:EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child:Column(crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Html(
                  data: htmlDescription,
                  style: {
                    "h2": Style(
                      fontSize: FontSize(15.0),
                      fontWeight: FontWeight.w600,
                      fontFamily:'FontPoppins',
                      color: Colors.black,
                      margin: Margins.only(bottom: 10),
                    ),
                    "p": Style(
                      fontSize: FontSize(12.0),
                      fontFamily:'FontPoppins',
                      fontWeight:FontWeight.w500,
                      color: Colors.black87,
                      margin: Margins.only(bottom: 6),
                    ),
                    "b": Style(
                      color: Colors.black,
                    ),
                  },
                ),
                const Text(
                  "Recommended Treatments",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontFamily: 'FontPoppins',
                  ),
                ),
              ],
            ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height:140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: treatmentArray.length,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal:5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      shadowColor: Colors.grey.withOpacity(0.3),
                      child: Container(
                        width: 280,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/icons/leader.png',
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      treatmentArray[index],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontFamily: 'FontPoppins',
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Our team provides top-notch care with the latest medical advancements.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                        fontFamily: 'FontPoppins',
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(padding: EdgeInsets.symmetric(horizontal:screenWidth * 0.05),child:SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const MyAppointmentsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 6,
                ).copyWith(
                  backgroundColor:
                  MaterialStateProperty.all(Colors.transparent),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryColor, Colors.deepPurple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Book Appointment',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'FontPoppins'),
                    ),
                  ),
                ),
              ),
            ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[300],
          elevation: 6,
          child: const Icon(Icons.call, color: Colors.white, size: 28),
          onPressed: () {
            DialogHelper.makingPhoneCall(Consulation_Phone);
          }),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Fixed at the bottom right
    );
  }
}
