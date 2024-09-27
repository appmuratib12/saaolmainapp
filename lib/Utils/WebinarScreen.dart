import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../common/app_colors.dart';

class WebinarScreen extends StatefulWidget {
  const WebinarScreen({super.key});

  @override
  State<WebinarScreen> createState() => _WebinarScreenState();
}

class _WebinarScreenState extends State<WebinarScreen> {
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
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        physics:ScrollPhysics(),
        child:Container(
          margin:EdgeInsets.all(10),
          child:Column(crossAxisAlignment:CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height:520,
                width:double.infinity,
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(10),
                ),
                child:Column(crossAxisAlignment:CrossAxisAlignment.start,
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:Image(image: AssetImage('assets/images/Webinar.jpg'),fit:BoxFit.fill,width:double.infinity,height:300,),
                    ),
                    SizedBox(height:15,),
                    Row(
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
                    SizedBox(height:10,),
                    Text('Scan the given QR code',
                      style:TextStyle(fontFamily:'FontPoppins',fontSize:15,fontWeight:FontWeight.w500,color:Colors.black),),
                    SizedBox(height:20,),
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
                        Fluttertoast.showToast(msg: 'Click');
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
        ),
      ),
    );
  }
}
