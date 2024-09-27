import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';
import 'AppointmentsScreen.dart';

class DiseaseDetailScreen extends StatefulWidget {
  const DiseaseDetailScreen({super.key});

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'Angina',
            style: TextStyle(
                fontFamily: 'FontPoppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'What Conditions Can EECP Therapy Treat?',
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(
                      height: 15,
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
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: const Image(
                                  image: AssetImage(
                                      'assets/images/angina_image.png'),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 150,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Angina',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                textAlign: TextAlign.justify,
                                anginaTxt,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'FontPoppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Why Choose SAAOL for EECP Treatment in Aligarh?',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      textAlign: TextAlign.justify,
                      "Choosing SAAOL Heart Center for EECP Treatment in Aligarh means opting for excellence, compassion, and tangible results. Here's why our heart center stands out from the rest:",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: treatmentArray.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                elevation: 2,
                                child: Container(
                                  height: 150,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                // Optional: Limit the title to 1 line
                                                overflow: TextOverflow
                                                    .ellipsis, // Add ellipsis for overflow
                                              ),
                                              const SizedBox(height: 5),
                                              const Flexible(
                                                child: Text(
                                                  'Our team comprises seasoned professionals dedicated to your heart health. With years of experience and expertise, we deliver top-notch care and innovative treatments.',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'FontPoppins',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                  maxLines: 6,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap:
                                                      true, // Allow text to wrap
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      ecpTxt,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'FontPoppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 50,
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
                        child: const Text(
                          'Book Appointment',
                          style: TextStyle(
                              fontFamily: 'FontPoppins',
                              fontSize: 15,
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
                    Fluttertoast.showToast(msg: 'Call');
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
