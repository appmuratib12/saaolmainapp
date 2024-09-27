import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../constant/text_strings.dart';

class AboutSAAAOLScreen extends StatefulWidget {
  const AboutSAAAOLScreen({super.key});

  @override
  State<AboutSAAAOLScreen> createState() => _AboutSAAAOLScreenState();
}

class _AboutSAAAOLScreenState extends State<AboutSAAAOLScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'About SAAOL',
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
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/about_us.png'),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                aboutSAAOLTxt,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: 20),
              const Text(
                'SAAOL Goal',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'FontPoppins',
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark),
              ),
              const SizedBox(height: 15,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
                  height:240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:Padding(padding: EdgeInsets.all(10),
                    child: Column(crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[50],
                          ),
                          child: Image(
                            image: AssetImage('assets/icons/vision.png'),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Our Vision', style: TextStyle(fontSize: 16,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark),),
                        SizedBox(height: 10,),
                        Text(visionTxt,
                          textAlign: TextAlign.justify, style: TextStyle(fontSize: 13,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black),),


                      ],
                    ),
                  ),
                ),
              ),

              const Divider(
                height: 15, color: AppColors.primaryDark, thickness: 0.2,),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
                  height:240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:Padding(padding: const EdgeInsets.all(10),
                    child: Column(crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[50],
                          ),
                          child: const Image(
                            image: AssetImage('assets/icons/target.png'),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 15,),
                        const Text('Our Mission', style: TextStyle(fontSize: 16,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark),),
                        const SizedBox(height: 10,),
                        const Text(missionTxt,
                          textAlign: TextAlign.justify, style: TextStyle(fontSize: 13,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),),


                      ],
                    ),
                  ),
                ),
              ),


              const Divider(
                height: 15, color: AppColors.primaryDark, thickness: 0.2,),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
                  height:240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:Padding(padding: const EdgeInsets.all(10),
                    child: Column(crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[50],
                          ),
                          child: Image(
                            image: AssetImage('assets/icons/values.png'),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 15,),
                        const Text('Our Values', style: TextStyle(fontSize: 16,
                            fontFamily: 'FontPoppins',
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark),),
                        const SizedBox(height: 10,),
                        const Text(valuesTxt,
                          textAlign: TextAlign.justify, style: TextStyle(fontSize: 13,
                              fontFamily: 'FontPoppins',
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),),

                      ],
                    ),
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
