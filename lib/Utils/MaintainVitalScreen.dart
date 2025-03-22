import 'package:flutter/material.dart';
import 'package:saaoldemo/constant/text_strings.dart';
import '../common/app_colors.dart';


class MaintainVitalScreen extends StatefulWidget {
  final String vitals;
  const MaintainVitalScreen({super.key,required this.vitals});

  @override
  State<MaintainVitalScreen> createState() => _MaintainVitalScreenState();
}

class _MaintainVitalScreenState extends State<MaintainVitalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title:  Text(
          widget.vitals,
          style: const TextStyle(
              fontFamily: 'FontPoppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,size:20,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child:Container(
          margin:const EdgeInsets.all(10),
          child:Column(crossAxisAlignment:CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Same radius as the container
                child: Image.network(
                  'https://etimg.etb2bimg.com/photo/85063521.cms', // Replace with your image URL
                  fit: BoxFit.cover, // Ensures the image covers the entire area
                ),
              ),
              const Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text:'Healthy Range: ',style:TextStyle(fontFamily:'FontPoppins',fontWeight:FontWeight.w600,fontSize:16,color:Colors.black)),
                      TextSpan(
                        text:'Resting heart rate typically ranges from 60–100 beats per minute',
                        style: TextStyle(fontWeight: FontWeight.w600,fontFamily:'FontPoppins',fontSize:16,color:AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height:10,),
              Container(
                height:300,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Changes position of shadow (x, y)
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Heart Rate Maintenance', // Main heading
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:17.0,
                        fontFamily:'FontPoppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '• Regular Exercise: ',
                            style: TextStyle(
                              color: Colors.black, // Bla
                              fontFamily:'FontPoppins',
                              fontSize: 14,// ck color for the heading
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Engage in cardiovascular activities like walking, swimming, or cycling to strengthen the heart and lower the resting heart rate.',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily:'FontPoppins' ,
                                fontWeight:FontWeight.w500,
                                fontSize:13// Content in primary color
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0), // Small spacing between items
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '• Stress Management: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:14,
                              fontFamily:'FontPoppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Practice relaxation techniques such as yoga, meditation, or deep breathing exercises to reduce stress-induced tachycardia.',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily:'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize:13
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '• Healthy Diet: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily:'FontPoppins',
                                fontSize:14
                            ),
                          ),
                          TextSpan(
                            text: 'Consume a heart-healthy diet rich in fruits, vegetables, whole grains, and lean proteins while avoiding excessive caffeine and sugary foods.',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily:'FontPoppins',
                                fontWeight:FontWeight.w500,
                                fontSize:13
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
              const SizedBox(height:15,),
              const Text(
                'Understanding Heart Rate (Pulse)', // Main heading
                style: TextStyle(
                  color: Colors.black,
                  fontSize:17.0,
                  fontFamily:'FontPoppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height:15,),
              Container(
                height:220,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Changes position of shadow (x, y)
                    ),
                  ],
                ),
                child:const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(aboutHeartPulse,
                      style: TextStyle(
                        color:AppColors.primaryColor,
                        fontSize:13.0,
                        fontFamily:'FontPoppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height:15,),
              const Text(
                'Factors Affecting Heart Rate', // Main heading
                style: TextStyle(
                  color: Colors.black,
                  fontSize:17.0,
                  fontFamily:'FontPoppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height:15,),
              Container(
                height:200,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Changes position of shadow (x, y)
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Physical Activity: ',
                            style: TextStyle(
                              color: Colors.black, // Bla
                              fontFamily:'FontPoppins',
                              fontSize: 14,// ck color for the heading
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Exercise increases heart rate, while regular training can lower resting heart rate over time.',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily:'FontPoppins' ,
                                fontWeight:FontWeight.w500,
                                fontSize:13// Content in primary color
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0), // Small spacing between items
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Stress and Emotions: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:14,
                              fontFamily:'FontPoppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Anxiety, excitement, or fear can elevate heart rate.',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily:'FontPoppins',
                                fontWeight: FontWeight.w500,
                                fontSize:13
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '•Age: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily:'FontPoppins',
                                fontSize:14
                            ),
                          ),
                          TextSpan(
                            text: 'As you age, your maximum heart rate typically decreases.',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily:'FontPoppins',
                                fontWeight:FontWeight.w500,
                                fontSize:13
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

