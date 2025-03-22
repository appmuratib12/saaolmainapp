import 'package:flutter/material.dart';
import 'package:saaoldemo/data/model/apiresponsemodel/WebinarResponseData.dart';
import 'package:saaoldemo/data/network/BaseApiService.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/app_colors.dart';

class WebinarScreen extends StatefulWidget {
  const WebinarScreen({super.key});

  @override
  State<WebinarScreen> createState() => _WebinarScreenState();
}

class _WebinarScreenState extends State<WebinarScreen> {


  void openWhatsApp() async {
    String phoneNumber = "919068544483"; // Add country code (e.g., India: +91)
    String message = "Hello, I want to book webinar?";
    String url = "https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch WhatsApp");
    }
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
      body:SingleChildScrollView(
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
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Error fetching webinar: ${snapshot.error}');
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.data == null ||
                      snapshot.data!.data!.isEmpty) {
                    return const Center(child: Text('No webinar available.'));
                  } else {
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
                                          fontSize:16,fontWeight:FontWeight.w500,color:Colors.black)),
                                          TextSpan(text:snapshot.data!.data![index].title.toString(),
                                            style:const TextStyle(fontFamily:'FontPoppins',
                                              fontSize:16,fontWeight:FontWeight.w500,color:AppColors.primaryColor),),
                                        ],
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Text('Fees:',
                                          style:TextStyle(fontFamily:'FontPoppins',
                                              fontSize:16,fontWeight:FontWeight.w500,color:Colors.black),),
                                        SizedBox(width:5,),
                                        Text('Free',
                                          style:TextStyle(fontFamily:'FontPoppins',
                                              fontSize:16,fontWeight:FontWeight.w500,color:AppColors.primaryColor),),
                                        SizedBox(width:30,),

                                      ],
                                    ),
                                    const SizedBox(height:10,),
                                    const Text('Scan the given QR code',
                                      style:TextStyle(fontFamily:'FontPoppins',fontSize:15,fontWeight:FontWeight.w500,color:Colors.black),),
                                    const SizedBox(height:20,),
                                    const Center(
                                      child:  Image(image:
                                      AssetImage('assets/icons/webinar_qr_code.jpg'),width:130,height:130,fit:BoxFit.cover,),
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
                                        style:TextStyle(fontFamily:'FontPoppins',fontSize:14,color:Colors.white,fontWeight: FontWeight.w600,),
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
}
