import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/app_colors.dart';
import '../data/model/apiresponsemodel/WebinarResponseData.dart';
import '../data/network/BaseApiService.dart';

class WebinarScreen extends StatefulWidget {
  const WebinarScreen({super.key});

  @override
  State<WebinarScreen> createState() => _WebinarScreenState();
}

class _WebinarScreenState extends State<WebinarScreen> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  void _logScreenView() async {
    await _analytics.logEvent(
      name: 'webinar_screen_viewed',
      parameters: {
        'screen_name': 'WebinarScreen',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  void openWhatsApp() async {
    String phoneNumber = "+919318405344"; // Add country code (e.g., India: +91)
    String message = "Hello, I want to book webinar?";
    String url = "https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch WhatsApp");
    }
  }
  @override
  void initState() {
    super.initState();
    _logScreenView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Our Webinar',
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
      body:  SingleChildScrollView(
        physics:const ScrollPhysics(),
        child:Container(
          margin:const EdgeInsets.all(10),
          child:Column(crossAxisAlignment:CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder<WebinarResponseData>(
                future: BaseApiService().getWebinarData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return buildWebinarShimmer();
                  } else if (snapshot.hasError) {
                    final errorMessage = snapshot.error.toString();
                    if (errorMessage.contains('No internet connection')) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.wifi_off_rounded,
                                size:30,
                                color: Colors.redAccent,
                              ),
                              SizedBox(height:8),
                              Text(
                                'No Internet Connection',
                                style: TextStyle(
                                  fontSize:14,
                                  fontFamily: 'FontPoppins',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Please check your network settings and try again.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:12,
                                  fontFamily: 'FontPoppins',
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text('Error: $errorMessage'));
                    }
                  } else if (!snapshot.hasData ||
                      snapshot.data!.data == null ||
                      snapshot.data!.data!.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 12),
                            Text(
                              'No webinar available.',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'FontPoppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Please check back later. New data will be available soon!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'FontPoppins',
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    final webinars = snapshot.data!.data!;
                    _analytics.logEvent(
                      name: 'webinar_data_loaded',
                      parameters: {
                        'count': webinars.length,
                        'titles': webinars.map((e) => e.title).toList(),
                      },
                    );
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child:Column(crossAxisAlignment:CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width:double.infinity,
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                ),
                                child:Column(crossAxisAlignment:CrossAxisAlignment.start,
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child:Image(image: NetworkImage(snapshot.data!.data![index].image.toString()),
                                        fit:BoxFit.fill,width:double.infinity,height:310,),
                                    ),
                                    const SizedBox(height:15,),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(text:'Title:',style:TextStyle(fontFamily:'FontPoppins',
                                          fontSize:15,fontWeight:FontWeight.w500,color:Colors.black)),
                                          TextSpan(text:snapshot.data!.data![index].title.toString(),
                                            style:const TextStyle(fontFamily:'FontPoppins',
                                              fontSize:15,fontWeight:FontWeight.w500,color:AppColors.primaryColor),),
                                        ],
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Text('Fees:',
                                          style:TextStyle(fontFamily:'FontPoppins',
                                              fontSize:15,fontWeight:FontWeight.w500,color:Colors.black),),
                                        SizedBox(width:6,),
                                        Text('Free',
                                          style:TextStyle(fontFamily:'FontPoppins',
                                              fontSize:15,fontWeight:FontWeight.w500,color:AppColors.primaryColor),),
                                        SizedBox(width:30,),

                                      ],
                                    ),
                                    const SizedBox(height:10,),
                                    const Text('Scan the given QR code',
                                      style:TextStyle(fontFamily:'FontPoppins',fontSize:13,fontWeight:FontWeight.w500,color:Colors.black),),
                                    const SizedBox(height:20,),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Image.asset(
                                          'assets/icons/webinar_qr_code.jpg',
                                          width: 130,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height:20,),
                              Center(
                                child:SizedBox(
                                  height:40,
                                  child:ElevatedButton.icon(
                                      onPressed: () {
                                        openWhatsApp();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      icon: const Icon(Icons.call,color:Colors.white,size:20,),
                                      label: const Text("Click to join whatsapp",
                                        style:TextStyle(fontFamily:'FontPoppins',fontSize:13,color:Colors.white,fontWeight: FontWeight.w600,),
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildWebinarShimmer() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 310,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 20,
                  width: 200,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 20,
                  width: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Center(
                  child: Container(
                    width: 130,
                    height: 130,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 40,
                    width: 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
