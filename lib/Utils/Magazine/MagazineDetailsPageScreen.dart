import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:saaolapp/common/app_colors.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineGalleryResponse.dart';
import 'package:saaolapp/data/model/apiresponsemodel/EmagazineSliderResponse.dart';

class MagazineDetailsPageScreen extends StatefulWidget {
  final Gallery gallery;
  const MagazineDetailsPageScreen({super.key,required this.gallery});

  @override
  State<MagazineDetailsPageScreen> createState() => _MagazineDetailsPageScreenState();
}

class _MagazineDetailsPageScreenState extends State<MagazineDetailsPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.network(widget.gallery.image.toString(),
              width: double.infinity,
              fit: BoxFit.fill,
              height:250,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5), // manual nudge for visual balance
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size:22,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 230.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.gallery.title.toString(),
                        style: const TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize:14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height:10,),
                      Row(crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('SAAOL Heart Center',
                            style:TextStyle(fontWeight:FontWeight.w500,
                                fontSize:12,fontFamily:'FontPoppins',color:AppColors.primaryColor),),
                          SizedBox(width:10,),
                          Text('${widget.gallery.monthName},${widget.gallery.year}',
                            style:TextStyle(fontWeight:FontWeight.w500,
                                fontSize:12,fontFamily:'FontPoppins',color:Colors.black),),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Html(
                        data: widget.gallery.content,
                        style: {
                          "p": Style(
                            fontSize: FontSize(13.0),
                            fontFamily: 'FontPoppins',
                            color: Colors.black,
                            fontWeight:FontWeight.w500,
                            letterSpacing:0.2,
                            textAlign: TextAlign.justify,
                          ),
                          "h2": Style(
                            fontSize: FontSize(16.0),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            color: AppColors.primaryColor,
                            margin: Margins.only(top: 20, bottom: 10),
                          ),
                          "strong": Style(
                            fontWeight: FontWeight.w600,
                            fontSize:FontSize(13.0),fontFamily:'FontPoppins',color:Colors.black
                          ),
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MagazineSliderPageScreen extends StatefulWidget {
  final EmagazineDataSlider sliderData;
  const MagazineSliderPageScreen({super.key,required this.sliderData});
  @override
  State<MagazineSliderPageScreen> createState() => _MagazineSliderPageScreenState();
}

class _MagazineSliderPageScreenState extends State<MagazineSliderPageScreen> {
  String formatMonthYear(String month, String year) {
    final date = DateTime(int.parse(year), int.parse(month));
    return DateFormat('MMMM, yyyy').format(date); // Output: March, 2025
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.network(widget.sliderData.image.toString(),
              width: double.infinity,
              fit: BoxFit.fill,
              height:250,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5), // manual nudge for visual balance
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size:22,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 230.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.sliderData.title.toString(),
                        style: const TextStyle(
                          fontFamily: 'FontPoppins',
                          fontSize:14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height:10,),
                      Row(crossAxisAlignment:CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('SAAOL Heart Center',
                            style:TextStyle(fontWeight:FontWeight.w500,
                                fontSize:12,fontFamily:'FontPoppins',color:AppColors.primaryColor),),
                          const SizedBox(width:10,),

                          Text(
                            formatMonthYear(widget.sliderData.emagzineMonth.toString(), widget.sliderData.year.toString()),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily: 'FontPoppins',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Html(
                        data: widget.sliderData.content,
                        style: {
                          "p": Style(
                            fontSize: FontSize(13.0),
                            fontFamily: 'FontPoppins',
                            color: Colors.black,
                            fontWeight:FontWeight.w500,
                            letterSpacing:0.2,
                            textAlign: TextAlign.justify,
                          ),
                          "h2": Style(
                            fontSize: FontSize(16.0),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FontPoppins',
                            color: AppColors.primaryColor,
                            margin: Margins.only(top: 20, bottom: 10),
                          ),
                          "strong": Style(
                              fontWeight: FontWeight.w600,
                              fontSize:FontSize(13.0),fontFamily:'FontPoppins',color:Colors.black
                          ),
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
